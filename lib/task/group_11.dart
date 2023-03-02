import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Group11 extends StatefulWidget {
  Group11({
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
  State<Group11> createState() => _Group8State();
}

class _Group8State extends State<Group11> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  // File? imageFile;
  File? imageFile2 = null;
  late Future<Uint8List> data;
  bool clicked = false;
  Uint8List? imageBytes;
  List<bool> isSelected = [true, false];
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
            left: MediaQuery.of(context).padding.left + 2,
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
                Text(" Linear Spatial Filtering "),
                Text(" Non-Linear Spatial Filtering "),
              ],
            )),
      ],
    );
  }

  // Function will send a image and then get a image back
  Future<Uint8List> _getImage() async {
    // Send a image to the native side
    imageBytes = widget.fileImage!.readAsBytesSync();

    if (isSelected[0]) {
      if (clicked) clicked = false;
      // also send the value Start and End as int
      return await platform.invokeMethod('getImage11_1', {
        'data': imageBytes,
      });
    } else {
      if (clicked) clicked = false;
      return await platform.invokeMethod('getImage11_2', {'data': imageBytes});
    }
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
