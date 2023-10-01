import 'package:contact_list/models/contact_model.dart';
import 'package:contact_list/repository/back4app_custom_dio.dart';
import 'package:contact_list/shared/enums/filter_type.dart';
import 'package:flutter/material.dart';

class ContactsRepository {
  final _customDio = Back4AppCustomDio();

  ContactsRepository();

  Future<ContactListModel> get(String? objectId) async {
    String url = '/Contacts';
    url = objectId != null && objectId.trim() != ''
        ? '$url?where={"objectId":"$objectId"}'
        : '$url?order=name';

    final response = await _customDio.dio.get(url);

    if (response.statusCode == 200) {
      var contacts = response.data;
      return ContactListModel.fromJson(contacts);
    }

    return ContactListModel();
  }

  Future<ContactListModel> filter(FilterType filter, {int limit = 5}) async {
    String url = '/Contacts';
    url = filter == FilterType.favorites
        ? '$url?where={"favorite":true}&order=name'
        : '$url?limit=$limit&order=createdAt';

    final response = await _customDio.dio.get(url);

    if (response.statusCode == 200) {
      var contacts = response.data;
      return ContactListModel.fromJson(contacts);
    }

    return ContactListModel();
  }

  Future<ContactModel> create(ContactModel contact) async {
    String url = '/Contacts';

    try {
      final response =
          await _customDio.dio.post(url, data: contact.toJsonEndpoint());

      final objectId = response.data['objectId'];
      final newContact = await get(objectId);

      return newContact.results != null
          ? newContact.results!.first
          : ContactModel();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<ContactModel> update(ContactModel contact) async {
    String url = '/Contacts/${contact.objectId}';

    try {
      await _customDio.dio.put(url, data: contact.toJsonEndpoint());
      final updatedContact = await get(contact.objectId);

      return updatedContact.results != null
          ? updatedContact.results!.first
          : ContactModel();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> delete(String objectId) async {
    String url = '/Contacts/$objectId';

    try {
      await _customDio.dio.delete(url);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
