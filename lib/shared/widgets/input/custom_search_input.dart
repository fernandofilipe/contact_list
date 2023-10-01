import 'package:contact_list/models/contact_model.dart';
import 'package:contact_list/pages/contacts/contact_detail_page.dart';
import 'package:contact_list/shared/widgets/tile/detail_contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchInput extends StatefulWidget {
  final TextEditingController? searchController;
  final Function()? onTap;
  final List<Widget>? trailing;
  final List<ContactModel> contactList;
  const CustomSearchInput({
    super.key,
    this.searchController,
    this.onTap,
    this.trailing,
    required this.contactList,
  });

  @override
  State<CustomSearchInput> createState() => _CustomSearchInputState();
}

class _CustomSearchInputState extends State<CustomSearchInput> {
  late List<ContactModel> localContactList = [];
  @override
  void initState() {
    localContactList = widget.contactList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0),
            ),
            onTap: () {
              controller.openView();
            },
            onChanged: (String value) {
              controller.openView();
            },
            leading: const Icon(Icons.search),
            trailing: widget.trailing,
          );
        },
        suggestionsBuilder: (_, SearchController controller) {
          final keyword = controller.value.text;
          return localContactList
              .where((ContactModel contact) =>
                  '${contact.name} ${contact.surname}'
                      .toLowerCase()
                      .startsWith(keyword.toLowerCase()))
              .map(
            (ContactModel contact) {
              final String item = '${contact.name} ${contact.surname}';
              return DetailContactTile(
                contact: contact,
                item: item,
                onTap: () {
                  setState(() {
                    FocusScope.of(context).unfocus();
                    Get.to(
                      () => ContactDetailPage(contact: contact),
                    );
                  });
                },
              );
            },
          ).toList();
        },
      ),
    );
  }
}
