import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:outshade/model/thumbnail.dart';

class ImageService {
  final FirebaseFirestore fb = FirebaseFirestore.instance;

  Future<File> compressedIamage(
      File image, String targetPath, int width, int height) async {
    return await FlutterImageCompress.compressAndGetFile(image.path, targetPath,
        minHeight: height, minWidth: width);
  }

  Future<void> uploadImages(File image) async {
    final lastIndex = image.path.lastIndexOf(RegExp(r'.jp'));
    final splitted = image.path.substring(0, (lastIndex));
    final name = image.path.split("/").last;
    final outPathS = "${splitted}_small_out${image.path.substring(lastIndex)}";
    final outPathL = "${splitted}_large_out${image.path.substring(lastIndex)}";

    File small = await compressedIamage(image, outPathS, 50, 50);
    File large = await compressedIamage(image, outPathL, 100, 100);

    var smallDPath = FirebaseStorage.instance
        .ref()
        .child("thumbnails/small/${name}")
        .putFile(small);

    TaskSnapshot sPath = await smallDPath.whenComplete(() {});

    String smallDownloadPath = await sPath.ref.getDownloadURL();

    var largeDPath = FirebaseStorage.instance
        .ref()
        .child("thumbnails/large/${name}")
        .putFile(large);

    TaskSnapshot lPath = await largeDPath.whenComplete(() {});

    String largeDownloadPath = await lPath.ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection("thumbnails")
        .add({"small": smallDownloadPath, "large": largeDownloadPath});
  }

  Future<List<Thumbnail>> getThumbnails() async {
    return fb.collection("thumbnails").get().then((value) {
      print(value.docs);
      return value.docs.map((e) => Thumbnail.fromMap(e.data())).toList();
    });
  }
}
