import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatefulWidget {
  const Menu({
    Key? key,
    required this.index,
  }) : super(key: key);

  final RxInt index;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with TickerProviderStateMixin {
  late AnimationController _controller;
  final Tween<double> turnsTween = Tween<double>(
    begin: 1,
    end: .5,
  );
  final Tween<TextStyle> textStyleTween = Tween<TextStyle>(
    begin: const TextStyle(
        // color: widget.index.value == 0 ? Colors.white : unselectedIconColor,
        fontSize: 18),
    end: const TextStyle(fontSize: 1),
  );

  final duration = const Duration(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      // upperBound: .5,
      duration: duration,
    );
  }

  RxBool isShrinked = false.obs;

  @override
  Widget build(BuildContext context) {
    // also used for the unselected text
    final unselectedIconColor = Theme.of(context).iconTheme.color;
    return Obx(
      () => AnimatedContainer(
        duration: duration,
        color: Theme.of(context).drawerTheme.backgroundColor,
        height: double.infinity,
        width: isShrinked.value ? 50 : Theme.of(context).drawerTheme.width,
        child: Obx(
          () => Column(
            children: [
              // ListTile(
              //   onTap: () => widget.index.value = 0,
              //   leading: Icon(
              //     Icons.shopping_cart,
              //     color: widget.index.value == 0 ? Colors.white : unselectedIconColor,
              //   ),
              //   title: isShrinked.value
              //       ? null
              //       : FittedBox(
              //           child: Text(
              //             'Orders',
              //             style: TextStyle(
              //               color: widget.index.value == 0 ? Colors.white : unselectedIconColor,
              //             ),
              //           ),
              //         ),
              // ),
              ListTile(
                onTap: () => widget.index.value = 0,
                leading: Icon(
                  Icons.shopping_cart,
                  color: widget.index.value == 0 ? Colors.white : unselectedIconColor,
                ),
                title: isShrinked.value
                    ? null
                    : DefaultTextStyleTransition(
                        style: textStyleTween.animate(_controller),
                        child: Text(
                          'Orders',
                          style: TextStyle(
                            color: widget.index.value == 0 ? Colors.white : unselectedIconColor,
                          ),
                        ),
                      ),
              ),
              ListTile(
                onTap: () => widget.index.value = 1,
                leading: Icon(
                  Icons.add_box,
                  color: widget.index.value == 1 ? Colors.white : unselectedIconColor,
                ),
                title: isShrinked.value
                    ? null
                    : Text(
                        'Products',
                        style: TextStyle(
                          color: widget.index.value == 1 ? Colors.white : unselectedIconColor,
                        ),
                      ),
              ),
              ListTile(
                onTap: () => widget.index.value = 2,
                leading: Icon(
                  Icons.category,
                  color: widget.index.value == 2 ? Colors.white : unselectedIconColor,
                ),
                title: isShrinked.value
                    ? null
                    : Text(
                        'Categories',
                        style: TextStyle(
                          color: widget.index.value == 2 ? Colors.white : unselectedIconColor,
                        ),
                      ),
              ),
              ListTile(
                onTap: () => widget.index.value = 3,
                leading: Icon(
                  Icons.people,
                  color: widget.index.value == 3 ? Colors.white : unselectedIconColor,
                ),
                title: isShrinked.value
                    ? null
                    : Text(
                        'Customers',
                        style: TextStyle(
                          color: widget.index.value == 3 ? Colors.white : unselectedIconColor,
                        ),
                      ),
              ),
              const Spacer(),
              RotationTransition(
                turns: turnsTween.animate(_controller),
                child: IconButton(
                  onPressed: () {
                    isShrinked.toggle();

                    if (_controller.isCompleted) {
                      _controller.reverse();
                    } else {
                      _controller.forward();
                    }
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
