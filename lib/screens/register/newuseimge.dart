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

class UserAfterRegImage extends StatefulWidget {
  @override
  _UserAfterRegImageState createState() => _UserAfterRegImageState();
}

class _UserAfterRegImageState extends State<UserAfterRegImage> {
  bool isLoading = false;
  File image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        showSheet() async {
          var im = await showModalBottomSheet(
            builder: (context) => ImageSheet(),
            context: context,
          );
          if (im is File) {
            setState(() {
              image = im;
            });
          }
        }

        upload() async {
          setState(() {
            isLoading = true;
          });
          try {
            CurrentUser c = context.read<CurrentUser>();
            Map upload = await ApiRepository()
                .userUploadimage(authToken: c.authToken, image: image);
            if (upload['success'] == true) {
              c.setUser(User.fromDynamic(upload['data']), null);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('uploaded successfully'),
              ));
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('${upload['reason']}'),
              ));
            }
          } catch (e) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('$e'),
            ));
          } finally {
            setState(() {
              isLoading = false;
            });
          }
        }

        return ScrollableFullScreen(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    BackButton(),
                    Flexible(
                      child: Text(
                        DefaultTexts.newImageTitle,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: LoadingDisabler(
                    isLoading: isLoading,
                    loader: LinearProgressIndicator(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.primary,
                          backgroundImage: image == null
                              ? ProfilePic().build(context).image
                              : Image.file(image).image,
                          radius: 70,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(DefaultTexts.newImageMessage),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        HappButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Select a file',
                            ),
                          ),
                          onPressed: showSheet,
                        ),
                        HappButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Upload',
                            ),
                          ),
                          onPressed: image == null ? null : upload,
                        ),
                        SizedBox(
                          child: FlatButton(
                            child: Text('Skip'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            onPressed: Navigator.of(context).pop,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(),
                Container(),
                Container(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
