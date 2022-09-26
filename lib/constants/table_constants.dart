import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

final  tableConfiguration = PlutoGridConfiguration(
  enterKeyAction: PlutoGridEnterKeyAction.editingAndMoveRight,
  style: PlutoGridStyleConfig(
    gridBorderRadius: BorderRadius.circular(10),
    enableCellBorderVertical: false,
    enableColumnBorderHorizontal: false,
    enableColumnBorderVertical: false,
    gridBorderColor: Colors.transparent,
  ),
);
