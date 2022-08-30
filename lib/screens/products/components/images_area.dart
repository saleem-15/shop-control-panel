import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../products_controller.dart';

class DropImagesArea extends GetView<ProductsController> {
  const DropImagesArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        DropTarget(
          onDragDone: (detail) => controller.onDragDone(detail),
          onDragEntered: (detail) => controller.onDragEntered(detail),
          onDragExited: (detail) =>controller. onDragExited(detail),
          child: Obx(
            () => Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              child: Container(
                height: 300,
                width: 300,
                color: controller.dragging.value ? Colors.blue.withOpacity(0.4) : Colors.black26,
                child: Center(
                  child: Text(
                    controller.list.isEmpty ? 'Drop Images here' : '${controller.list.length} Images',
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
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Obx(
            () => ListView(
              scrollDirection: Axis.horizontal,
              children: controller.list
                  .map((e) => Container(
                        clipBehavior: Clip.antiAlias,
                        width: 170,
                        height: 170,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.file(
                          e,
                          fit: BoxFit.cover,
                        ),
                      ))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}
