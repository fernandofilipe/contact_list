import 'package:contact_list/models/contact_model.dart';
import 'package:contact_list/shared/layout/theme.dart';
import 'package:flutter/material.dart';

class DetailContactTile extends StatelessWidget {
  final ContactModel contact;
  final String item;
  final Function()? onTap;
  const DetailContactTile(
      {super.key, required this.contact, this.onTap, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: Text(contact.initial ?? ""),
      ),
      title: Text(
        item,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(
        contact.phone ?? "",
        style: subTitleStyle,
      ),
      onTap: onTap,
    );
  }
}
