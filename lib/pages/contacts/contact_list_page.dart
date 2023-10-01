import 'package:contact_list/controllers/contact_controller.dart';
import 'package:contact_list/pages/contacts/contact_detail_page.dart';
import 'package:contact_list/services/photo_services.dart';
import 'package:contact_list/shared/widgets/button/add_contact_button.dart';
import 'package:contact_list/shared/widgets/input/custom_search_input.dart';
import 'package:contact_list/shared/widgets/loader.dart/custom_loader.dart';
import 'package:contact_list/shared/widgets/tile/contact_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ContactListPage extends StatefulWidget {
  final ContactsController controller;
  const ContactListPage({super.key, required this.controller});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  late TextEditingController _searchController;
  late PhotoServices photoServices;
  late String documentsPath;
  bool loading = false;

  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    _searchController = TextEditingController(text: "");
    photoServices = PhotoServices(
      cropperTitle: tr('APP_CONTACT_IMAGE_CROPER_TITLE'),
    );
    setState(() {
      loading = true;
    });

    await widget.controller.get();
    documentsPath = await photoServices.getDocumentPath();

    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchInput(
          searchController: _searchController,
          contactList: widget.controller.contactList,
        ),
        const SizedBox(height: 10),
        const AddContactButton(),
        const SizedBox(height: 10),
        loading
            ? const Expanded(
                child: CustomLoader(),
              )
            : _showContactList(),
      ],
    );
  }

  _showContactList() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: widget.controller.contactList.length,
            itemBuilder: (_, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        ContactTile(
                          contact: widget.controller.contactList[index],
                          documentsPath: documentsPath,
                          photoServices: photoServices,
                          onTap: () => Get.to(
                            () => ContactDetailPage(
                              contact: widget.controller.contactList[index],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
