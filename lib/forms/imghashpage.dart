import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_realtime_detection/forms/livepage.dart';
import 'package:flutter_realtime_detection/models/appdata.dart';

class ImgHashPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ImgHashPage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liveness App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Liveness App'),
        ),
        body: Container(
          margin: EdgeInsets.all(30),
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Please enter img_hash from your task description here',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter img_hash here',
                          border: OutlineInputBorder(),
                        ),
                        textAlign: TextAlign.center,
                        validator: (text) {
                          //if (text == null || text.isEmpty) {
                          //  return 'IMG_HASH is empty!';
                          //}
                          return null;
                        },
                          onSaved: (val) {
                            appData.img_hash = val;
                          },
                        //autofocus: true,
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            Navigator.push(
                              context,
                              //MaterialPageRoute(builder: (context) => HomePage.withModel(cameras, ssd)),
                              MaterialPageRoute(builder: (context) => LivePage()),
                            );
                          }
                        },
                        child: Text('Submit'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
