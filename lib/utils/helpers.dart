import 'dart:developer';

String formatErrorMsg(dynamic dioError) {
  if (dioError is! Map) {
    /// print the type of [data]
    log(dioError.runtimeType.toString());
    return dioError.toString();

    /// now [data] is certainly a Map
  }

  final errorsMap = dioError['Messages'];

  if (errorsMap is! Map) {
    /// print the type of [errorsMap]
    log(errorsMap.runtimeType.toString());
    return errorsMap.toString();

    /// now [errorsMap] is certainly a Map
  }

  // log('error msg type: ${errorsMap.runtimeType}');
  // for (var element in (data).keys) {
  //   log(element.toString());
  // }

  //the error map is Map<String,List<String>>
  String errorString = '';

  for (var value in errorsMap.values) {
    for (var e in (value as List)) {
      log('value: $e');
      errorString += '$e\n';
    }
  }

  return errorString.trim();
}
