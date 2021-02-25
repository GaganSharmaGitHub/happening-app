import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

String base64fromFile(File f) {
  return base64String(f.readAsBytesSync());
}

ImageProvider getImagePro(String base6) {
  if (base6 == null) return null;
  base6 = base6.replaceFirst('data:image/png;base64,', '');
  Image photo = imageFromBase64String(base6);
  return photo.image;
}
