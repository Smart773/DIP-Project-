import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Group8 extends StatefulWidget {
  Group8({
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
  State<Group8> createState() => _Group8State();
}

class _Group8State extends State<Group8> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  // File? imageFile;
  File? imageFile2 = null;
  late Future<Uint8List> data;
  bool clicked = false;
  RangeValues values = const RangeValues(0, 255);
  RangeValues values2 = const RangeValues(0, 255);

  Uint8List? imageBytes;
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
          top: MediaQuery.of(context).padding.top + 150,
          right: MediaQuery.of(context).padding.right + 0,
          child: RotatedBox(
            quarterTurns: 3,
            child: Column(
              children: [
                // Container with light theme color showing Text "Input Intensity"
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
                      "Input Intensity",
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
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 115,
          right: MediaQuery.of(context).padding.right + 35,
          child: Column(
            children: [
              // Container with light theme color showing Text "Input Intensity"
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
                    "Output Intensity",
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
                        values2.start.round().toString(),
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
                      values: values2,
                      min: 0,
                      max: 255,
                      divisions: 255,
                      labels: RangeLabels(
                        values2.start.round().toString(),
                        values2.end.round().toString(),
                      ),
                      onChanged: (RangeValues value) {
                        setState(() {
                          values2 = value;
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
                        values2.end.round().toString(),
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
      ],
    );
  }

  // Function will send a image and then get a image back
  Future<Uint8List> _getImage() async {
    // Send a image to the native side
    imageBytes = widget.fileImage!.readAsBytesSync();

    return await platform.invokeMethod('getImage8', {
      'data': imageBytes,
      'value1': values.start.round(),
      'value2': values.end.round(),
      'value3': values2.start.round(),
      'value4': values2.end.round(),
    });
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
