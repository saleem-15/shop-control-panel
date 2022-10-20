import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'pagination_controller.dart';

class TableFooter extends StatelessWidget {
  const TableFooter({
    Key? key,
    required this.paginationController,
  }) : super(key: key);

  final PaginationController paginationController;

  @override
  Widget build(BuildContext context) {
    final RxInt numOfPages = paginationController.numOfPages;
    final RxInt selectedPage = paginationController.currentPageNum;
    final void Function(int selectedPageNum) setSelectedPage =
        paginationController.setSelectedPage;

    return Container(
      height: 50,
      alignment: Alignment.centerRight,
      child: Obx(
        () => ListView(
          scrollDirection: Axis.horizontal,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ...List.generate(
              numOfPages.value,
              (index) {
                final isSelectedPage = selectedPage.value == index + 1;
                return TextButton(
                  onPressed: () {
                    setSelectedPage(index + 1);
                    selectedPage(index + 1);
                  },
                  child: Text(
                    '${index + 1}',
                    style: isSelectedPage
                        ? Theme.of(context).textTheme.bodyText1
                        : Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Theme.of(context).disabledColor),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 100,
            ),
          ],
        ),
      ),
    );
  }
}
