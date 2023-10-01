import 'package:contact_list/models/contact_model.dart';
import 'package:contact_list/models/general_response_model.dart';
import 'package:contact_list/repository/contacts_repository.dart';
import 'package:contact_list/shared/enums/filter_type.dart';
import 'package:contact_list/shared/widgets/dialog/feedback_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactsController extends GetxController {
  var contactList = <ContactModel>[].obs;

  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController surnameController =
      TextEditingController(text: "");
  final TextEditingController initialController =
      TextEditingController(text: "");
  final TextEditingController phoneController = TextEditingController(text: "");
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController companyController =
      TextEditingController(text: "");
  final TextEditingController photoController = TextEditingController(text: "");
  final TextEditingController favoriteController =
      TextEditingController(text: "");
  late ContactsRepository contactRepository = ContactsRepository();
  bool loading = false;

  void init(ContactModel contactModel) {
    nameController.text = contactModel.name ?? "";
    surnameController.text = contactModel.surname ?? "";
    initialController.text = contactModel.initial ?? "";
    phoneController.text = contactModel.phone ?? "";
    emailController.text = contactModel.email ?? "";
    companyController.text = contactModel.company ?? "";
    photoController.text = contactModel.photoUrl ?? "";
    favoriteController.text = contactModel.favorite.toString();
  }

  void disposeControllers() {
    nameController.dispose();
    surnameController.dispose();
    initialController.dispose();
    phoneController.dispose();
    emailController.dispose();
    companyController.dispose();
    photoController.dispose();
    favoriteController.dispose();
  }

  Future<ContactResponse> get({String? filter}) async {
    final contactRepository = ContactsRepository();
    ContactListModel contactItems = await contactRepository.get(null);
    ContactResponse response = ContactResponse(
      error: false,
      data: [],
      message: tr('APP_CONTACT_FEEDBACK_CONTACT_GET_MANY'),
      title: tr('APP_CONTACT_FEEDBACK_SUCCESS'),
    );

    contactList.assignAll(contactItems.results!.map((data) => data).toList());

    if (response.error) {
      await Get.dialog(FeedBackDialog(response: response));
    }

    return response;
  }

  Future<ContactResponse> getWithFilter(FilterType filter) async {
    final contactRepository = ContactsRepository();
    ContactListModel contactItems = await contactRepository.filter(filter);
    ContactResponse response = ContactResponse(
      error: false,
      data: [],
      message: tr('APP_CONTACT_FEEDBACK_CONTACT_GET_MANY'),
      title: tr('APP_CONTACT_FEEDBACK_SUCCESS'),
    );

    contactList.assignAll(contactItems.results!.map((data) => data).toList());

    if (response.error) {
      await Get.dialog(FeedBackDialog(response: response));
    }

    return response;
  }

  Future<ContactResponse> add() async {
    ContactModel contactModel = ContactModel(
      name: nameController.text,
      surname: surnameController.text,
      initial: nameController.text.substring(0, 1),
      phone: phoneController.text,
      email: emailController.text,
      company: companyController.text,
      photoUrl: photoController.text,
      favorite: favoriteController.text == 'true',
    );

    final contactRepository = ContactsRepository();
    ContactResponse response;

    ContactModel createdContact = await contactRepository.create(contactModel);
    final newList = [createdContact, ...contactList];
    newList.sort(
        ((a, b) => '${a.name}${a.surname}'.compareTo('${b.name}${b.surname}')));
    contactList.assignAll(newList);

    response = ContactResponse(
      error: false,
      message: tr('APP_CONTACT_FEEDBACK_CONTACT_CREATE'),
      title: tr('APP_CONTACT_FEEDBACK_SUCCESS'),
    );

    return response;
  }

  Future<ContactResponse> search(String contact) async {
    final contactRepository = ContactsRepository();
    ContactListModel contactItems = await contactRepository.get(contact);
    ContactResponse response;

    if (contactItems.results!.isNotEmpty) {
      contactList.assignAll(contactItems.results!.map((data) => data).toList());
      response = ContactResponse(
        error: false,
        data: contactItems,
        message: tr('APP_CONTACT_FEEDBACK_CONTACT_GET'),
        title: tr('APP_CONTACT_FEEDBACK_SUCCESS'),
      );
    } else {
      response = ContactResponse(
        error: true,
        data: contactItems,
        message: tr('APP_CONTACT_FEEDBACK_CONTACT_GET_FAIL'),
        title: tr('APP_CONTACT_FEEDBACK_WARNING'),
      );
    }

    await Get.dialog(FeedBackDialog(response: response));

    return response;
  }

  Future<ContactResponse> upsertContact(String? objectId,
      {FilterType? filter}) async {
    return objectId == null
        ? add()
        : filter == null
            ? updateContact(objectId)
            : updateContact(objectId, filter: filter);
  }

  Future<ContactResponse> updateContact(String objectId,
      {FilterType? filter}) async {
    ContactModel contactModel = ContactModel(
      objectId: objectId,
      name: nameController.text,
      surname: surnameController.text,
      initial: nameController.text.substring(0, 1),
      phone: phoneController.text,
      email: emailController.text,
      company: companyController.text,
      photoUrl: photoController.text,
      favorite: favoriteController.text == 'true',
    );

    ContactModel updatedContactModel =
        await contactRepository.update(contactModel);

    if (filter != null) {
      if (filter == FilterType.favorites) {
        if (!contactModel.favorite!) {
          contactList.removeWhere((ContactModel localContact) =>
              localContact.objectId == contactModel.objectId);
        }
      }
    } else {
      int indexOfContact = contactList.indexWhere((ContactModel contactModel) =>
          contactModel.objectId == updatedContactModel.objectId);

      contactList[indexOfContact].name = updatedContactModel.name;
      contactList[indexOfContact].surname = updatedContactModel.surname;
      contactList[indexOfContact].initial =
          updatedContactModel.name!.substring(0, 1);
      contactList[indexOfContact].phone = updatedContactModel.phone;
      contactList[indexOfContact].email = updatedContactModel.email;
      contactList[indexOfContact].company = updatedContactModel.company;
      contactList[indexOfContact].photoUrl = updatedContactModel.photoUrl;
      contactList[indexOfContact].favorite = updatedContactModel.favorite;
    }

    contactList.refresh();
    ContactResponse response = ContactResponse(
      error: false,
      data: updatedContactModel,
      message: tr('APP_CONTACT_FEEDBACK_CONTACT_UPDATE'),
      title: tr('APP_CONTACT_FEEDBACK_SUCCESS'),
    );

    await Get.dialog(FeedBackDialog(response: response));

    return response;
  }

  Future<ContactResponse> delete(ContactModel contact) async {
    final contactRepository = ContactsRepository();
    await contactRepository.delete(contact.objectId!);

    ContactResponse contactResponse = ContactResponse(
      error: false,
      data: [ContactModel(objectId: contact.objectId)],
      message: tr('APP_CONTACT_FEEDBACK_CONTACT_DELETE'),
      title: tr('APP_CONTACT_FEEDBACK_SUCCESS'),
    );
    ContactModel oldContact = contactResponse.data.first;
    contactList.removeWhere((ContactModel localContact) =>
        localContact.objectId == oldContact.objectId);

    await Get.dialog(FeedBackDialog(response: contactResponse));
    if (!contactResponse.error) Get.back();
    return contactResponse;
  }

  void validate(ContactModel contact) async {
    if (contact.name == null || contact.name!.trim() == "") {
      await Get.dialog(FeedBackDialog(
          response: ContactResponse(
        error: false,
        data: contact,
        message: tr('APP_CONTACT_FEEDBACK_CONTACT_VALIDATION_NAME'),
        title: tr('APP_CONTACT_FEEDBACK_ERROR'),
      )));

      return;
    }

    if (contact.surname == null || contact.surname!.trim() == "") {
      await Get.dialog(FeedBackDialog(
          response: ContactResponse(
        error: false,
        data: contact,
        message: tr('APP_CONTACT_FEEDBACK_CONTACT_VALIDATION_SURNAME'),
        title: tr('APP_CONTACT_FEEDBACK_ERROR'),
      )));

      return;
    }
  }
}
