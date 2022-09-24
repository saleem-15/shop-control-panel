import 'dart:developer';

/// column index is the determines what is changed (name,price,quantity)
void updateRowInfo(String productId, int columnIndex, String newValue) {
  log(productId);
  log('$columnIndex');
  log('new VALUE: $newValue');

  final String columnName;

  switch (columnIndex) {
    case 1:
      columnName = 'product_id';
      break;
    case 2:
      columnName = 'price';
      break;
    case 3:
      columnName = 'quantity';
      break;
    case 4:
      columnName = 'colors';
      break;
    case 5:
      columnName = 'sizes';
      break;
  }

  
}
