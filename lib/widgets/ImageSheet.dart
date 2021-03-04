import 'package:flutter/material.dart';
import 'dart:io';
import 'package:happening/models/currentuser.dart';
import 'package:happening/utils/imageUtil.dart';
import 'package:flutter/material.dart';
import 'package:happening/api/apiRepo.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/constants/constants.dart';
import 'package:happening/widgets/basicwidgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageSheet extends StatelessWidget {
  final Function camera;
  final Function gallery;

  ImageSheet({this.camera, this.gallery});
  Future<File> _pickImage({
    ImageSource source,
  }) async {
    final picked = await ImagePicker().getImage(
      source: source,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 80,
    );
    File selected = File(picked.path);
    return selected;
  }

  Future<File> crop(File selectedfile) async {
    try {
      File toSend = await ImageCropper.cropImage(
          sourcePath: selectedfile.path,
          androidUiSettings: AndroidUiSettings(
            backgroundColor: AppColors.lightColor,
            toolbarColor: AppColors.primaryAccent,
            activeControlsWidgetColor: Colors.white,
            toolbarWidgetColor: Colors.white,
            toolbarTitle: 'Crop Image',
          ),
          iosUiSettings: IOSUiSettings(
            title: 'Crop image',
          ));
      if (toSend == null) {
        return selectedfile;
      } else
        return toSend;
    } catch (e) {
      return selectedfile;
    }
  }

  @override
  Widget build(BuildContext context) {
    select(ImageSource src) async {
      File selected = await _pickImage(source: src);
      if (selected != null) {
        File cselected = await crop(selected);
        if (cselected != null) {
          selected = cselected;
        }
        navigatorService.pop(selected);
        return;
      }
      navigatorService.pop();
    }

    return Container(
      color: Colors.grey,
      height: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            child: CircleAvatar(
              child: Icon(
                Icons.camera_alt,
                size: 40,
              ),
              minRadius: 40,
            ),
            onTap: () => select(ImageSource.camera),
          ),
          InkWell(
            child: CircleAvatar(
              child: Icon(
                Icons.photo,
                size: 40,
              ),
              minRadius: 40,
            ),
            onTap: () => select(ImageSource.gallery),
          ),
        ],
      ),
    );
  }
}
