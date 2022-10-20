import 'package:flutter/material.dart';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:get/get.dart';

import '../categories_controller.dart';

class DropImagesArea extends GetView<CategoriesController> {
  const DropImagesArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DropTarget(
          onDragDone: (detail) => controller.onDragDone(detail),
          onDragEntered: (detail) => controller.onDragEntered(detail),
          onDragExited: (detail) => controller.onDragExited(detail),
          child: Obx(
            () => Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              child: Container(
                height: 350,
                width: 350,
                color: controller.dragging.value
                    ? Colors.blue.withOpacity(0.4)
                    : Colors.black26,
                child: Center(
                  child: Text(
                    'Drop Category Image here',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        GetBuilder<CategoriesController>(
          assignId: true,
          id: 'category_photo',
          builder: (controller) => !controller.isImageExists
              ? const SizedBox.shrink()
              : Container(
                  clipBehavior: Clip.antiAlias,
                  width: 200,
                  height: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.file(
                    controller.image.value!,
                    fit: BoxFit.cover,
                  ),
                ),
        )
      ],
    );
  }
}
