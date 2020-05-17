import 'package:camera/camera.dart';

class AppData {
  static final AppData _appData = new AppData._internal();

  List<CameraDescription> cameras;
  String img_hash;
  String res; // result of lib init

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}
final appData = AppData();