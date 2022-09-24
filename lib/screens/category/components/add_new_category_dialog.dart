import 'package:flutter/material.dart';

import 'form.dart';

class AddNewCategoryDialog extends StatelessWidget {
  const AddNewCategoryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: CategoryInfoForm(),
    );
  }
}
