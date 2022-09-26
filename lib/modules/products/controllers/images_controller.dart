import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:get/get.dart';

import '../../../app_components/custom_snackbar.dart';

class ImagesController extends GetxController {
  RxBool dragging = false.obs;
  final List<File> _imagesList = <File>[].obs;

  List<File> get imagesList => _imagesList;

  onDragDone(DropDoneDetails detail) {
    final droppedImages = detail.files;
    final isNotImage = droppedImages.any((file) => !file.path.isImageFileName);

    if (isNotImage) {
      CustomSnackbar.showCustomErrorSnackBar(title: 'Error', message: 'Not valid Image!!');
      return;
    }

    addImages(detail);
  }

  void addImages(DropDoneDetails detail) => imagesList.addAll(detail.files.map((e) => File(e.path)));

  onDragEntered(DropEventDetails detail) {
    dragging.value = true;
  }

  onDragExited(DropEventDetails detail) {
    dragging.value = false;
  }

  void clearImagesList() {
    imagesList.clear();
  }
}
