import 'dart:io';

import 'package:contact_list/helpers/path_helper.dart';
import 'package:contact_list/shared/enums/photo_storage_type.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class PhotoServices {
  final String cropperTitle;
  final Color? toolbarColor;
  PhotoServices({required this.cropperTitle, this.toolbarColor});

  Future<XFile?> takePicture(
      {PhotoStorageType photoType = PhotoStorageType.gallery}) async {
    XFile? photo = await _pickImage();

    if (photoType == PhotoStorageType.gallery) {
      return photo != null ? await _saveInGallery(photo) : photo;
    } else {
      return photo != null ? await _saveInCellPhone(photo) : photo;
    }
  }

  Future<XFile?> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.camera);
  }

  Future<XFile> _saveInGallery(XFile photo) async {
    final croppedImage = await _cropImage(photo);
    if (croppedImage != null) {
      photo = XFile(croppedImage.path);
      await GallerySaver.saveImage(croppedImage.path);
    } else {
      await GallerySaver.saveImage(photo.path);
    }

    return photo;
  }

  Future<CroppedFile?> _cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: cropperTitle,
          toolbarColor: toolbarColor ?? Colors.amber,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: cropperTitle,
        ),
      ],
    );

    return croppedFile;
  }

  Future<XFile?> getPhotoFromGalery() async {
    XFile? photo = await _pickImage();
    return photo != null ? _saveInGallery(photo) : null;
  }

  Future<String> getDocumentPath() async {
    return (await path_provider.getApplicationDocumentsDirectory()).path;
  }

  Future<XFile?> _saveInCellPhone(XFile photo) async {
    String documentsPath = await getDocumentPath();

    final croppedImage = await _cropImage(photo);
    if (croppedImage != null) {
      photo = XFile(croppedImage.path);
      String name = PathHelper.getBaseName(photo.path);
      await photo.saveTo("$documentsPath/$name");
    } else {
      String name = PathHelper.getBaseName(photo.path);
      await photo.saveTo("$documentsPath/$name");
    }

    return photo;
  }

  bool isValidPhoto(String path) {
    return path.trim() != '' && File(path).existsSync();
  }

  Future<XFile?> loadPhotoFromStorage(String photo) async {
    if (photo != '') {
      String documentsPath = await getDocumentPath();
      String name = photo;
      return isValidPhoto("$documentsPath/$name")
          ? XFile("$documentsPath/$name")
          : null;
    }

    return null;
  }

  String getPhotoName(XFile? photo) {
    return photo != null ? PathHelper.getBaseName(photo.path) : '';
  }

  Future<bool> deleteFile(String filename) async {
    try {
      String documentsPath = await getDocumentPath();
      File localFile = File("$documentsPath/$filename");
      await localFile.delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  FileImage? buildPhoto(String photoPath) {
    return FileImage(File(photoPath));
  }
}
