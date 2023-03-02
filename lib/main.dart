import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/task/group_1.dart';
import 'package:project/task/group_10.dart';
import 'package:project/task/group_11.dart';
import 'package:project/task/group_2.dart';
import 'package:project/task/group_3.dart';
import 'package:project/task/group_4.dart';
import 'package:project/task/group_5.dart';
import 'package:project/task/group_6.dart';
import 'package:project/task/group_7.dart';
import 'package:project/task/group_8.dart';
import 'package:project/task/group_9.dart';
// import group_8.dart

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  String mode = "Photo";
  File? imageFile;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (image == null) return;
      imageFile = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 11,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.add_a_photo),
                onPressed: () {
                  getImage();
                },
              ),
            ],
            elevation: 0,
            title: const Text("Image Processing"),
            bottom: TabBar(
              indicatorColor: Colors.white,
              isScrollable: true,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                  mode = "Mode $index";
                });
              },
              tabs: [
                ModelTab(
                  mode: "Group 1",
                  currentIndex: currentIndex,
                  index: 0,
                ),
                ModelTab(
                  mode: "Group 2",
                  currentIndex: currentIndex,
                  index: 1,
                ),
                ModelTab(
                  mode: "Group 3",
                  currentIndex: currentIndex,
                  index: 2,
                ),
                ModelTab(
                  mode: "Group 4",
                  currentIndex: currentIndex,
                  index: 3,
                ),
                ModelTab(
                  mode: "Group 5",
                  currentIndex: currentIndex,
                  index: 4,
                ),
                ModelTab(
                  mode: "Group 6",
                  currentIndex: currentIndex,
                  index: 5,
                ),
                ModelTab(
                  mode: "Group 7",
                  currentIndex: currentIndex,
                  index: 6,
                ),
                ModelTab(
                  mode: "Group 8",
                  currentIndex: currentIndex,
                  index: 7,
                ),
                ModelTab(
                  mode: "Group 9",
                  currentIndex: currentIndex,
                  index: 8,
                ),
                ModelTab(
                  mode: "Group 10",
                  currentIndex: currentIndex,
                  index: 9,
                ),
                ModelTab(
                  mode: "Group 11",
                  currentIndex: currentIndex,
                  index: 10,
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Group1(
                  mode: "Interpolation ",
                  fileImage: imageFile,
                  callback: () {
                    setState(() {
                      imageFile = null;
                    });
                  }),
              Group2(
                  mode: "Scale Shear Rotate",
                  fileImage: imageFile,
                  callback: () {
                    setState(() {
                      imageFile = null;
                    });
                  }),
              Group3(
                  mode: "Arithmatic",
                  fileImage: imageFile,
                  callback: () {
                    setState(() {
                      imageFile = null;
                    });
                  }),
              Group4(
                  mode: "Gamma Correction",
                  fileImage: imageFile,
                  callback: () {
                    setState(() {
                      imageFile = null;
                    });
                  }),
              Group5(
                  mode: "pending",
                  fileImage: imageFile,
                  callback: () {
                    setState(() {
                      imageFile = null;
                    });
                  }),
              Group6(
                  mode: "Image Registration",
                  fileImage: imageFile,
                  callback: () {
                    setState(() {
                      imageFile = null;
                    });
                  }),
              Group7(
                  mode: "pending",
                  fileImage: imageFile,
                  callback: () {
                    setState(() {
                      imageFile = null;
                    });
                  }),
              Group8(
                  mode: "Histogram Equalization",
                  fileImage: imageFile,
                  callback: () {
                    setState(() {
                      imageFile = null;
                    });
                  }),
              Group9(
                  mode: "Intensity level & Bit plane",
                  fileImage: imageFile,
                  callback: () {
                    setState(() {
                      imageFile = null;
                    });
                  }),
              Group10(
                  mode: "pending",
                  fileImage: imageFile,
                  callback: () {
                    setState(() {
                      imageFile = null;
                    });
                  }),
              Group11(
                  mode: "Spatial Filtering",
                  fileImage: imageFile,
                  callback: () {
                    setState(() {
                      imageFile = null;
                    });
                  }),
            ],
          )),
    );
  }
}

class ModelTab extends StatelessWidget {
  const ModelTab({
    Key? key,
    required this.currentIndex,
    required this.index,
    required this.mode,
  }) : super(key: key);

  final int currentIndex;
  final int index;
  final String mode;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        mode,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
