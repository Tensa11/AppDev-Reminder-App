import 'package:flutter/material.dart';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import '../constants/colors.dart';

class PicturePage extends StatefulWidget {
  const PicturePage({Key? key}) : super(key: key);

  @override
  State<PicturePage> createState() => _HomePageState();
}

class _HomePageState extends State<PicturePage> {
  List<dynamic> listImagePath = <dynamic>[];
  Future? _futureGetPath;

  @override
  void initState() {
    _getPermission();
    super.initState();
    _futureGetPath = getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tdBGColor,
        leading: const Icon(Icons.image_outlined),
        title: const Center(child: Text("Photo's of Anthony", textAlign: TextAlign.center)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1010,
            child: GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 11,
              mainAxisSpacing: 11,
              crossAxisCount: 2,
              children: _getListImg(listImagePath),
            ),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: _futureGetPath,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var dir = Directory(snapshot.data);
                  if (true) _fetchFiles(dir);
                  return Text(snapshot.data);
                } else {
                  return const Text("PICTURES FOLDER EMPTY");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _getPermission() async {
    await Permission.storage.request().isGranted;
    setState(() {
    }
    );
  }

  Future<String> getImage() {
    return ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_PICTURES);
  }

  _fetchFiles(Directory dir) {
    List<dynamic> listImage = [];
    dir.list().forEach((element) {
      RegExp regExp = RegExp(
          "(gif|jpe?g|png|webp|bmp)", caseSensitive: false);
      if (regExp.hasMatch('$element')) listImage.add(element);
      setState(() {
        listImagePath = listImage;
      }
      );
    }
    );
  }

  List<Widget> _getListImg(List<dynamic> listImagePath) {
    List<Widget> listImages = [];
    for (var imagePath in listImagePath) {
      listImages.add(
        Container(
          padding: const EdgeInsets.all(8),
          child: Image.file(imagePath, fit: BoxFit.cover),
        ),
      );
    }
    return listImages;
  }
}

