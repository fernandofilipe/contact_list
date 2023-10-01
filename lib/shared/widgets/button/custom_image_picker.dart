import 'dart:io';

import 'package:contact_list/services/photo_services.dart';
import 'package:contact_list/shared/enums/photo_storage_type.dart';
import 'package:contact_list/shared/widgets/bottom_sheet/custom_sticker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  final TextEditingController controller;
  const CustomImagePicker({super.key, required this.controller});

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  XFile? photo;
  final String cropperTitle = tr('APP_CONTACT_IMAGE_CROPER_TITLE');
  late PhotoServices photoServices;

  _loadPhotoFromStorage() async {
    if (widget.controller.text != '') {
      photo = await photoServices.loadPhotoFromStorage(widget.controller.text);
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    photoServices = PhotoServices(
      cropperTitle: tr('APP_CONTACT_IMAGE_CROPER_TITLE'),
      toolbarColor: Theme.of(context).colorScheme.primary,
    );

    _loadPhotoFromStorage();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await showModalBottomSheet(
            context: context,
            builder: (_) {
              return Wrap(
                children: [
                  const CustomSticker(),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.camera_alt_rounded),
                    title: const Text('APP_CONTACT_IMAGE_CAMERA_LABEL').tr(),
                    onTap: () async {
                      photo = await photoServices.takePicture(
                          photoType: PhotoStorageType.storage);
                      widget.controller.text = photo != null
                          ? photoServices.getPhotoName(photo)
                          : '';
                      setState(() {});
                      Get.back();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.image_search_outlined),
                    title: const Text('APP_CONTACT_IMAGE_GALLERY_LABEL').tr(),
                    onTap: () async {
                      photo = await photoServices.getPhotoFromGalery();
                      widget.controller.text = photo != null
                          ? photoServices.getPhotoName(photo)
                          : '';
                      setState(() {});
                      Get.back();
                    },
                  ),
                ],
              );
            });
      },
      child: photo != null
          ? CircleAvatar(
              radius: 100,
              backgroundImage: FileImage(File(photo!.path)),
              backgroundColor: Colors.transparent,
              child: const SizedBox(),
            )
          : const CircleAvatar(
              radius: 100,
              child: Icon(
                Icons.add_photo_alternate_outlined,
                size: 100,
              ),
            ),
    );
  }
}
