extension ExtensionOnInt on int {}

extension ExtensionOnDouble on double {}

extension ExtensionOnString on String {
  String get onlyText  {
    var result = this.replaceAll(RegExp(r"(<\/?[\w\s]*>|<.+[\W]>)|&.*;"), "");
    // result = result.replaceAll(RegExp(r"&.*;"), "");
    return result;
  }
}

extension ExtensionOnList on List {}

extension ExtensionOnMap on Map {}
