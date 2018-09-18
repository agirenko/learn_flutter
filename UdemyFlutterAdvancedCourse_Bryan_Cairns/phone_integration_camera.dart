import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:simple_permissions/simple_permissions.dart';

List<CameraDescription> cameras;

Permission permissionFromString(String value) {
  Permission permission;
  for (Permission item in Permission.values) {
    if (item.toString() == value) {
      permission = item;
      break;
    }
  }
  return permission;
}

void main() async {
  cameras = await availableCameras();

  await SimplePermissions.requestPermission(permissionFromString('Permission.WriteExternalStorage'));
  await SimplePermissions.requestPermission(permissionFromString('Permission.Camera'));

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  CameraController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Permission _permissionCamera;
  Permission _permissionStorage;

  @override
  void initState() {
    super.initState();

    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        //TO DO - Anything we want
      });
    });

    _permissionCamera = permissionFromString('Permission.Camera');
    _permissionStorage = permissionFromString('Permission.WriteExternalStorage');
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<String> saveImage() async {
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    String filePath = '/storage/emulated/0/Pictures/$timeStamp.jpg';

    if (controller.value.isTakingPicture) return null;
    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      showInSnackBar(e.toString());
    }

    return filePath;
  }

  void takePicture() async {
    bool hasCamera = await SimplePermissions.checkPermission(_permissionCamera);
    bool hasStorage = await SimplePermissions.checkPermission(_permissionStorage);

    if (hasStorage == false || hasCamera == false) {
      showInSnackBar('Lacking permissions to take a picture!');
      return;
    }

    saveImage().then((String filePath) {
      if (mounted && filePath != null) showInSnackBar('Picture saved to $filePath');
    });
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Name here'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                RaisedButton(
                  onPressed: takePicture,
                  child: Text('Take Picture'),
                ),
                RaisedButton(
                  onPressed: SimplePermissions.openSettings,
                  child: Text('Settings'),
                ),
              ]),
              AspectRatio(
                aspectRatio: 1.0,
                child: CameraPreview(controller),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
