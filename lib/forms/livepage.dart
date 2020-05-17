import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_realtime_detection/forms/imghashpage.dart';
import 'package:flutter_realtime_detection/models/appdata.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import '../bndbox.dart';
import '../camera.dart';
import '../models.dart';

class LivePage extends StatefulWidget {
  final _LivePageState myState = new _LivePageState();
  final String model = ssd;

  LivePage() {
    loadModel();
  }

  @override
  _LivePageState createState() => myState;

  loadModel() async {
    if(appData.res != "success") {
      appData.res = await Tflite.loadModel(
          model: "assets/ssd_mobilenet.tflite",
          labels: "assets/ssd_mobilenet.txt");
    }
    print("res: ${appData.res}");
  }
}

class _LivePageState extends State<LivePage> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  Size screen;

  @override
  void initState() {
    super.initState();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = true;
    screen = MediaQuery.of(context).size;
    //print("x=${screen.width}, y=${screen.height}");
    return Scaffold(
      body: Stack(
        children: [
          Camera(
            appData.cameras,
            widget.model,
            setRecognitions,
          ),
          BndBox(
              _recognitions == null ? [] : _recognitions,
              math.max(_imageHeight, _imageWidth),
              math.min(_imageHeight, _imageWidth),
              screen.height,
              screen.width,
              widget.model),
          Positioned(
            bottom: 20.0,
            left: 10.0,
            right: 10.0,
            child: card(),
          ),
        ],
      ),
    );
  }

  Widget card() => Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                "IMG_HASH",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(appData.img_hash),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                "Server message",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(getServerMessage()),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ImgHashPage()),
                    );
                  },
                child: Text("Start again"),
              ),
            ),
          ],
        ),
      );

  getServerMessage() {
    // TODO: get message from server
    return "No server messages yet.";
  }
}
