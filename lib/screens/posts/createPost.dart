import 'package:flutter/material.dart';
import 'package:happening/api/apiRepo.dart';
import 'package:happening/models/currentuser.dart';
import 'package:happening/models/posts.dart';
import 'package:happening/utils/imageUtil.dart';
import 'package:happening/widgets/basicwidgets.dart';
import 'package:happening/widgets/posts/posts.dart';
import 'dart:io';

class CreatePost extends StatefulWidget {
  final Post repost;
  CreatePost({this.repost});
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  File image;
  String contents;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    CurrentUser c = context.watch<CurrentUser>();

    post() async {
      setState(() {
        isLoading = true;
      });
      Map resp = await ApiRepository().createPost(
          authToken: c.authToken,
          contents: contents,
          image: image == null
              ? null
              : 'data:image/png;base64,' + base64fromFile(image),
          repost: widget.repost == null ? null : widget.repost.id);

      setState(() {
        isLoading = false;
        Navigator.of(context).pop(resp);
      });
    }

    return LoadingDisabler(
      isLoading: isLoading,
      loader: AnimatedHappLoader(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            FlatButton(
              onPressed:
                  contents == null || contents == '' || isLoading ? null : post,
              child: Text('post'),
              color: Colors.white,
            )
          ],
        ),
        bottomNavigationBar: Builder(builder: (context) {
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

          return Row(
            children: image == null
                ? [
                    IconButton(
                      icon: Icon(Icons.add_photo_alternate),
                      onPressed: () {
                        showSheet();
                      },
                    )
                  ]
                : [
                    IconButton(
                      icon: Icon(Icons.repeat),
                      onPressed: () {
                        showSheet();
                      },
                    ),
                    InkWell(
                        child: CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundImage: Image.file(image).image,
                          radius: 40,
                        ),
                        onTap: () {
                          setState(() {
                            image = null;
                          });
                        })
                  ],
          );
        }),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: ProfilePic().build(context).image,
                    ),
                    Text('${c.user.name}'),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  maxLines: 10,
                  decoration: InputDecoration(
                      labelText: 'Write an incident',
                      border: OutlineInputBorder()),
                  onChanged: (j) {
                    setState(() {
                      contents = j;
                    });
                  },
                ),
                widget.repost == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text('Reposting:'),
                            RePostCard(
                              initPost: widget.repost,
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
