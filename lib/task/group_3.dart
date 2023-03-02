import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Group3 extends StatefulWidget {
  Group3({
    Key? key,
    required this.mode,
    this.fileImage,
    required this.callback,
  }) : super(key: key);

  final String mode;
  File? fileImage;
  final callback;

  @override
  State<Group3> createState() => _Group3State();
}

class _Group3State extends State<Group3> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  // File? imageFile;
  File? imageFile2 = null;
  File? imageFile3 = null;
  late Future<Uint8List> data;
  bool clicked = false;
  Uint8List? imageBytes;
  int value = 0;
  List<bool> isSelected = [true, false, false, false];
  Future getImage() async {
    // imageFile = null;
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (image == null) return;
      imageFile3 = File(image.path);
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
              if (imageFile3 == null) return;
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
          top: MediaQuery.of(context).padding.top + 30,
          right: MediaQuery.of(context).padding.right + 20,
          // Ellivated apply button
          child: ElevatedButton(
            onPressed: getImage,
            style: ElevatedButton.styleFrom(
              // shape: const CircleBorder(),
              padding: imageFile3 == null
                  ? const EdgeInsets.all(40)
                  : const EdgeInsets.all(10),
            ),
            child: imageFile3 == null
                ? const Text(
                    "+",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  )
                : SizedBox(
                    height: 100, width: 100, child: Image.file(imageFile3!)),
          ),
        ),
        // Toggel Button for +  -  *  /
        Positioned(
          top: MediaQuery.of(context).padding.top + 200,
          left: MediaQuery.of(context).padding.left + 20,
          child: RotatedBox(
            quarterTurns: 1,
            child: Container(
              color: Colors.white.withOpacity(0.4),
              child: ToggleButtons(
                children: const [
                  Text("+", style: TextStyle(fontSize: 20)),
                  Text("-", style: TextStyle(fontSize: 20)),
                  Text("*", style: TextStyle(fontSize: 20)),
                  Text("/", style: TextStyle(fontSize: 20)),
                ],
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

                    if (index == 0) {
                      value = 0;
                    } else if (index == 1) {
                      value = 1;
                    } else if (index == 2) {
                      value = 2;
                    } else if (index == 3) {
                      value = 3;
                    }
                  });
                },
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 25,
          left: MediaQuery.of(context).padding.left + -20,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              // amber color opacity 40%
              color: Colors.amber.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                isSelected[0]
                    ? "Addition"
                    : isSelected[1]
                        ? "Subtraction"
                        : isSelected[2]
                            ? "Multiplication"
                            : "Division",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
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
    Uint8List imageBytes2 = imageFile3!.readAsBytesSync();
    // imageBytes1 = widget.fileImage!.readAsBytesSync();
    if (isSelected[0]) {
      return await platform.invokeMethod(
          'getImage3_1', {'data1': imageBytes, 'data2': imageBytes2});
    } else if (isSelected[1]) {
      return await platform.invokeMethod(
          'getImage3_2', {'data1': imageBytes, 'data2': imageBytes2});
    } else if (isSelected[2]) {
      return await platform.invokeMethod(
          'getImage3_3', {'data1': imageBytes, 'data2': imageBytes2});
    } else {
      return await platform.invokeMethod(
          'getImage3_4', {'data1': imageBytes, 'data2': imageBytes2});
    }

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
