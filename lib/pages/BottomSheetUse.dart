import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn_app/custom_widgets/UploadImageBottomSheet.dart';
import 'package:flutter_learn_app/localization/MyLocalizations.dart';

class BottomSheetUse extends StatefulWidget {
  @override
  _BottomSheetUseState createState() => _BottomSheetUseState();
}

class _BottomSheetUseState extends State<BottomSheetUse> {
  File selectedImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(buildTranslate(context, "titleBottomSheet")),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return UploadProfileBottomSheet(
                        callBack:
                        this.uploadImage,
                      );
                    });
              }, child: Text("Open BottomSheet"))
            ],
          ),
        ),
      ),
    );
  }

  uploadImage(File image) {
    setState(() {
      selectedImage = image;
      print("file : " + selectedImage.path);
      print("file : " + selectedImage.toString());
    });
  }
}
