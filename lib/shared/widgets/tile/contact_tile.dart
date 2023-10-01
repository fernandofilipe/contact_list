import 'package:contact_list/models/contact_model.dart';
import 'package:contact_list/services/photo_services.dart';
import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  final ContactModel contact;
  final String documentsPath;
  final PhotoServices photoServices;
  final Function()? onTap;
  const ContactTile({
    super.key,
    required this.contact,
    this.onTap,
    required this.documentsPath,
    required this.photoServices,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 24),
        child: Row(
          children: [
            contact.photoUrl != null &&
                    photoServices
                        .isValidPhoto("$documentsPath/${contact.photoUrl}")
                ? CircleAvatar(
                    backgroundImage: photoServices
                        .buildPhoto("$documentsPath/${contact.photoUrl}"),
                    backgroundColor: Colors.transparent,
                    child: const SizedBox(),
                  )
                : CircleAvatar(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    child: Text(contact.initial ?? ""),
                  ),
            const SizedBox(width: 10),
            Text(
              "${contact.name} ${contact.surname}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
