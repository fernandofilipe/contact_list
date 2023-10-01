import 'package:contact_list/controllers/contact_controller.dart';
import 'package:contact_list/models/contact_model.dart';
import 'package:contact_list/services/photo_services.dart';
import 'package:contact_list/shared/enums/filter_type.dart';
import 'package:contact_list/shared/widgets/app_bar/custom_app_bar.dart';
import 'package:contact_list/shared/widgets/button/custom_elevated_button.dart';
import 'package:contact_list/shared/widgets/button/custom_image_picker.dart';
import 'package:contact_list/shared/widgets/button/favorite_buttom.dart';
import 'package:contact_list/shared/widgets/button/remove_buttom.dart';
import 'package:contact_list/shared/widgets/dialog/delete_dialog.dart';
import 'package:contact_list/shared/widgets/input/custom_input.dart';
import 'package:contact_list/shared/widgets/loader.dart/custom_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:email_validator/email_validator.dart';

class ContactDetailPage extends StatefulWidget {
  final ContactModel contact;
  final FilterType? filter;
  const ContactDetailPage({
    super.key,
    required this.contact,
    this.filter,
  });

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  final formKey = GlobalKey<FormState>();
  final ContactsController _contactController = Get.put(ContactsController());
  late PhotoServices photoServices =
      PhotoServices(cropperTitle: tr('APP_CONTACT_IMAGE_CROPER_TITLE'));

  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    _contactController.nameController.text = widget.contact.name ?? "";
    _contactController.surnameController.text = widget.contact.surname ?? "";
    _contactController.phoneController.text = widget.contact.phone ?? "";
    _contactController.emailController.text = widget.contact.email ?? "";
    _contactController.companyController.text = widget.contact.company ?? "";
    _contactController.photoController.text = widget.contact.photoUrl ?? "";
    _contactController.favoriteController.text =
        widget.contact.favorite.toString();

    debugPrint(_contactController.favoriteController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isEditingAppBar: true,
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: _contactController.loading
              ? const CustomLoader()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          FavoriteButton(
                            controller: _contactController.favoriteController,
                            onTap: () {
                              _contactController.favoriteController.text =
                                  _contactController.favoriteController.text ==
                                          'true'
                                      ? 'false'
                                      : 'true';
                              setState(() {});
                            },
                          ),
                          Expanded(child: Container()),
                          RemoveButton(
                            onTap: () async {
                              await _showDeleteDialog();
                            },
                          ),
                        ],
                      ),
                      CustomImagePicker(
                        controller: _contactController.photoController,
                      ),
                      const SizedBox(height: 20),
                      CustomInput(
                        label: "APP_CONTACT_FORM_NAME",
                        controller: _contactController.nameController,
                        maxLength: 50,
                        validator: (String? value) {
                          return value == null || value.length < 3
                              ? tr('APP_CONTACT_FORM_NAME_FAIL_VALIDATION')
                              : null;
                        },
                      ),
                      CustomInput(
                        label: "APP_CONTACT_FORM_SURNAME",
                        controller: _contactController.surnameController,
                        maxLength: 50,
                      ),
                      CustomInput(
                        label: "APP_CONTACT_FORM_PHONE",
                        controller: _contactController.phoneController,
                        formatters: [
                          MaskTextInputFormatter(
                            mask: '+## (##) ####-####',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy,
                          )
                        ],
                        keyboardType: TextInputType.phone,
                      ),
                      CustomInput(
                        label: "APP_CONTACT_FORM_EMAIL",
                        controller: _contactController.emailController,
                        keyboardType: TextInputType.emailAddress,
                        maxLength: 100,
                        validator: (String? email) =>
                            !EmailValidator.validate(email ?? '') && email != ''
                                ? tr('APP_CONTACT_FORM_EMAIL_FAIL_VALIDATION')
                                : null,
                      ),
                      CustomInput(
                        label: "APP_CONTACT_FORM_COMPANY",
                        controller: _contactController.companyController,
                        maxLength: 200,
                      ),
                      const SizedBox(height: 10),
                      CustomElevatedButton(
                        label: 'APP_CONTACT_FORM_SAVE_BUTTON',
                        onPressed: () async {
                          setState(() {
                            _contactController.loading = true;
                          });

                          final form = formKey.currentState!;

                          if (form.validate()) {
                            if (widget.filter != null) {
                              await _contactController.upsertContact(
                                widget.contact.objectId,
                                filter: widget.filter!,
                              );
                            } else {
                              await _contactController
                                  .upsertContact(widget.contact.objectId);
                            }

                            Get.back();
                          }

                          setState(() {
                            _contactController.loading = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return DeleteDialog(
            what:
                '${_contactController.nameController.text} ${_contactController.surnameController.text}',
            title: 'APP_CONTACT_MESSAGE_REMOVE_CONTACT_ACTION',
            textOk: 'APP_CONTACT_BUTTON_LABEL_DELETE',
            iconData: Icons.person,
            onCancel: () => Get.back(),
            onOk: () async {
              await _contactController.delete(widget.contact);
              await photoServices
                  .deleteFile(_contactController.phoneController.text);
              Get.back();
            },
          );
        });
  }
}
