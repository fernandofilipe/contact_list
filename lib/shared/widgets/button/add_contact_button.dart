import 'package:contact_list/models/contact_model.dart';
import 'package:contact_list/pages/contacts/contact_detail_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContactButton extends StatelessWidget {
  const AddContactButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ContactDetailPage(contact: ContactModel()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.person_add_alt,
                color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            Text(
              'APP_CONTACT_BUTTON_LABEL_NEW_CONTACT',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Theme.of(context).colorScheme.primary,
              ),
            ).tr(),
          ],
        ),
      ),
    );
  }
}
