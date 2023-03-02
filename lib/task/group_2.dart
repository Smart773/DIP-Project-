import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Group2 extends StatefulWidget {
  Group2({
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
  State<Group2> createState() => _Group2State();
}

class _Group2State extends State<Group2> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  // File? imageFile;
  File? imageFile2 = null;
  late Future<Uint8List> data;
  bool clicked = false;
  List<bool> isSelected = [true, false, false];
  List<bool> rotatedPosition = [true, false, false];
  Uint8List? imageBytes;
  double shearValue = 0.0;
  double scaleValue = 0.1;
  int rotateValue = 90;
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
        // Toggle Buttons
        Positioned(
          top: MediaQuery.of(context).padding.top + 20,
          left: MediaQuery.of(context).padding.left + 20,
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
              Icon(Icons.rotate_right),
              Icon(Icons.text_rotation_angleup_rounded),
              Icon(Icons.settings_overscan_outlined),
            ],
          ),
        ),
        // Selected Toggel Repesten in Text on Right Side,
        Positioned(
          top: MediaQuery.of(context).padding.top + 25,
          right: MediaQuery.of(context).padding.right + -35,
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
                    ? "Rotate "
                    : isSelected[1]
                        ? "Shear"
                        : "Scale",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        // Rotated Position with Toggle Button(),
        Positioned(
          top: MediaQuery.of(context).padding.top + 200,
          right: MediaQuery.of(context).padding.right + 20,
          child: RotatedBox(
            quarterTurns: 1,
            child: Visibility(
              visible: isSelected[0],
              child: Container(
                color: Colors.yellow.withOpacity(0.1),
                child: ToggleButtons(
                  isSelected: rotatedPosition,
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < rotatedPosition.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          rotatedPosition[buttonIndex] = true;
                        } else {
                          rotatedPosition[buttonIndex] = false;
                        }
                      }
                      rotateValue = rotatedPosition[0]
                          ? 90
                          : rotatedPosition[1]
                              ? 180
                              : 270;
                    });
                  },
                  children: const [
                    RotatedBox(quarterTurns: 3, child: Text("90°")),
                    RotatedBox(quarterTurns: 3, child: Text("180°")),
                    RotatedBox(quarterTurns: 3, child: Text("270°")),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Slider for Shear from -1 to 1
        Positioned(
          top: MediaQuery.of(context).padding.top + 200,
          right: MediaQuery.of(context).padding.right + 20,
          child: RotatedBox(
            quarterTurns: 3,
            child: Visibility(
              visible: isSelected[1],
              child: Row(
                children: [
                  // Container with light them color showing Shear value
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      // amber color opacity 40%
                      color: Colors.amber.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Text(
                          shearValue.toStringAsFixed(2),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Slider(
                    value: shearValue,
                    min: -1,
                    max: 1,
                    divisions: 200,
                    label: shearValue.toStringAsFixed(2),
                    onChanged: (double value) {
                      setState(() {
                        shearValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        // Slider for Scale from 0 to 1
        Positioned(
          top: MediaQuery.of(context).padding.top + 200,
          right: MediaQuery.of(context).padding.right + 20,
          child: RotatedBox(
            quarterTurns: 3,
            child: Visibility(
              visible: isSelected[2],
              child: Row(
                children: [
                  // Container with light them color showing Shear value
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      // amber color opacity 40%
                      color: Colors.amber.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Text(
                          scaleValue.toStringAsFixed(2),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Slider(
                    value: scaleValue,
                    min: 0.1,
                    max: 1,
                    divisions: 100,
                    label: scaleValue.toStringAsFixed(2),
                    onChanged: (double value) {
                      setState(() {
                        scaleValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  // Function will send a image and then get a image back
  Future<Uint8List> _getImage() async {
    // Send a image to the native side
    imageBytes = widget.fileImage!.readAsBytesSync();
    if (isSelected[0]) {
      print("Rotate Value: $rotateValue");

      return await platform.invokeMethod(
          'getImage2_1', {'data': imageBytes, 'value': rotateValue});
    } else if (isSelected[1]) {
      return await platform.invokeMethod(
          'getImage2_2', {'data': imageBytes, 'value': shearValue});
    } else {
      return await platform.invokeMethod(
          'getImage2_3', {'data': imageBytes, 'value': scaleValue});
    }
    // return await platform.invokeMethod('getImage2', {'data': imageBytes});
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
