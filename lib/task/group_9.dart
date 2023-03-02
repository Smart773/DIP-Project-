import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Group9 extends StatefulWidget {
  Group9({
    Key? key,
    required this.mode,
    this.fileImage,
    required this.callback,
  }) : super(key: key);

  final String mode;
  File? fileImage;
  final callback;

////////////////////////////////

//////////////////////////////////

  @override
  State<Group9> createState() => _Group8State();
}

class _Group8State extends State<Group9> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  // File? imageFile;
  File? imageFile2 = null;
  late Future<Uint8List> data;
  bool clicked = false;
  Uint8List? imageBytes;
  RangeValues values = const RangeValues(0, 255);
  List<bool> isSelected = [true, false];
  List<bool> isSelected2 = [true, false];
  List<bool> margeList = [true, false, false, false, false, false, false];
  int count = 2;
  Future getImage() async {
    // imageFile = null;
    widget.fileImage = null;
    imageFile2 = null;
    clicked = false;
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (image == null) return;
      widget.fileImage = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey,
                    child: widget.fileImage == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "No preview available",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Swipe left or right to change modes",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        : clicked
                            ? FutureBuilder(
                                future: _getImage(),
                                builder: ((context, snapshot) {
                                  if (snapshot.hasData) {
                                    Uint8List imagez = snapshot.data!;
                                    clicked = false;
                                    return Image.memory(imagez);
                                  }
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }))
                            : Image.file(widget.fileImage!)),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: Text(
                  widget.mode,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 70,
          right: MediaQuery.of(context).padding.right + 20,
          // Ellivated apply button
          child: ElevatedButton(
            onPressed: () {
              if (widget.fileImage == null) return;
              if (clicked) return;
              setState(() {
                clicked = true;
              });
              // call back Fuction(),
              // callback();
            },
            style: ElevatedButton.styleFrom(
              // shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
            ),
            child: const Text(
              "Apply",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).padding.top + 50,
            left: MediaQuery.of(context).padding.right + 50,
            child: ToggleButtons(
              isSelected: isSelected,
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < isSelected.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      isSelected[buttonIndex] = true;
                    } else {
                      isSelected[buttonIndex] = false;
                    }
                  }
                });
              },
              children: const [
                Text(" Intensity Level Slicing "),
                Text(" Bitplane Slicing "),
              ],
            )),
        Positioned(
          top: MediaQuery.of(context).padding.top + 150,
          right: MediaQuery.of(context).padding.right + 10,
          child: RotatedBox(
            quarterTurns: 3,
            child: Visibility(
              visible: isSelected[0],
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 30,
                    decoration: BoxDecoration(
                      // amber color opacity 40%
                      color: Colors.amber.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Intensity Level Slicing",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      // Container with light them color showing Start value
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          // amber color opacity 40%
                          color: Colors.amber.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            values.start.round().toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8 - 60,
                        child: RangeSlider(
                          values: values,
                          min: 0,
                          max: 255,
                          divisions: 255,
                          labels: RangeLabels(
                            values.start.round().toString(),
                            values.end.round().toString(),
                          ),
                          onChanged: (RangeValues value) {
                            setState(() {
                              values = value;
                            });
                          },
                        ),
                      ),
                      // Container with light them color showing End value
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          // amber color opacity 40%
                          color: Colors.amber.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            values.end.round().toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Toggel Button()
        Positioned(
            top: MediaQuery.of(context).padding.top + 150,
            right: MediaQuery.of(context).padding.right + 10,
            child: Visibility(
              visible: isSelected[1],
              child: RotatedBox(
                quarterTurns: 1,
                child: ToggleButtons(
                  isSelected: isSelected2,
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected2.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected2[buttonIndex] = true;
                        } else {
                          isSelected2[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  children: const [
                    RotatedBox(quarterTurns: 3, child: Text(" GridView ")),
                    RotatedBox(quarterTurns: 3, child: Text(" Merge")),
                    // Text(" Marge"),
                  ],
                ),
              ),
            )),
        // Toggel Button(),
        Positioned(
          top: MediaQuery.of(context).padding.top + 150,
          left: MediaQuery.of(context).padding.left + 10,
          child: Visibility(
            visible: isSelected[1] && isSelected2[1],
            child: RotatedBox(
              quarterTurns: 1,
              child: Container(
                color: Colors.white.withOpacity(0.4),
                child: ToggleButtons(
                  isSelected: margeList,
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < margeList.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          margeList[buttonIndex] = true;
                        } else {
                          margeList[buttonIndex] = false;
                        }
                      }
                    });
                    count = index == 0
                        ? 2
                        : index == 1
                            ? 3
                            : index == 2
                                ? 4
                                : index == 3
                                    ? 5
                                    : index == 4
                                        ? 6
                                        : index == 5
                                            ? 7
                                            : 8;
                  },
                  children: const [
                    RotatedBox(quarterTurns: 3, child: Text(" 1-2")),
                    RotatedBox(quarterTurns: 3, child: Text(" 1-3")),
                    RotatedBox(quarterTurns: 3, child: Text(" 1-4")),
                    RotatedBox(quarterTurns: 3, child: Text(" 1-5")),
                    RotatedBox(quarterTurns: 3, child: Text(" 1-6")),
                    RotatedBox(quarterTurns: 3, child: Text(" 1-7")),
                    RotatedBox(quarterTurns: 3, child: Text(" 1-8")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Function will send a image and then get a image back
  Future<Uint8List> _getImage() async {
    // Send a image to the native side
    imageBytes = widget.fileImage!.readAsBytesSync();

    if (isSelected[0]) {
      // if (clicked) clicked = false;
      // also send the value Start and End as int
      return await platform.invokeMethod('getImage9_1', {
        'data': imageBytes,
        'value1': values.start.round(),
        'value2': values.end.round()
      });
    } else if (isSelected[1] && isSelected2[0]) {
      return await platform.invokeMethod('getImage9_2', {'data': imageBytes});
    } else {
      return await platform
          .invokeMethod('getImage9_3', {'data': imageBytes, 'value': count});
    }
    // return await platform.invokeMethod('getImage9', {'data': imageBytes});
    // writeUint8ListToFile(image as Uint8List);
  }

  void writeUint8ListToFile(Uint8List data) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath/myfile.bin');
    await file.writeAsBytes(data);
    imageFile2 = file;
    setState(() {});
  }
}
