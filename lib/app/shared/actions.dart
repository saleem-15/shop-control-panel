import 'package:flutter/material.dart';

import 'package:pluto_grid/pluto_grid.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key? key,
    required this.rendererContext,
    required this.deleteRow,
  }) : super(key: key);

  final PlutoColumnRendererContext rendererContext;
  final Function(PlutoRow row) deleteRow;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => deleteRow(rendererContext.row),
      icon: const Icon(Icons.delete),
    );
  }
}
