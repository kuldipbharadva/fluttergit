import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_learn_app/localization/MyLocalizations.dart';
import 'package:flutter_learn_app/utilities/AppColor.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UploadProfileBottomSheet extends StatefulWidget {
  const UploadProfileBottomSheet({Key key, this.callBack}) : super(key: key);

  @override
  _UploadProfileBottomSheetState createState() =>
      _UploadProfileBottomSheetState();
  final Function callBack;
}

class _UploadProfileBottomSheetState extends State<UploadProfileBottomSheet> {
  TextStyle titleStyle = TextStyle(
      fontFamily: 'AppBold', fontSize: 16.0, color: AppColor.appBlack);

  File _image;

  @override
  void initState() {
    super.initState();
  }

  cropImage(File imageFile) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColor.appColor,
            toolbarWidgetColor: Colors.white,
            statusBarColor: AppColor.appColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile != null) {
      Navigator.pop(context);
      widget.callBack(croppedFile);
    }
  }

  Future pickImage(int index) async {
    var image;
    if (index == 0) {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    setState(() {
      if (image != null) {
        _image = image;
        cropImage(_image);
        /*Navigator.pop(context);
        widget.callback(_image);*/
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
        color: AppColor.appWhite,
        child: new Container(
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0))),
          child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Upload Image",
                          style: titleStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          color: AppColor.appWhite,
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                          splashColor: AppColor.appWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10),
                            side: BorderSide(color: AppColor.appColor),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: AppColor.appWhite,
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      buildTranslate(context, "takeAPhoto")),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            pickImage(1);
                          },
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          color: AppColor.appWhite,
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                          splashColor: AppColor.appWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10),
                            side: BorderSide(color: AppColor.appColor),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.image,
                                  color: AppColor.appWhite,
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      buildTranslate(context, "selectAnImage")),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            pickImage(0);
                          },
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          color: AppColor.appColor,
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                          splashColor: AppColor.appColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30),
                            side: BorderSide(color: AppColor.appColor),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.cancel,
                                  color: AppColor.appColor,
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child:
                                      Text("Cancel"),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
