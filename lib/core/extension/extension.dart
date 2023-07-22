extension ParseLabel on String {
  String parseLabel() => replaceAll(RegExp(r'\d'), '').trim();
}
