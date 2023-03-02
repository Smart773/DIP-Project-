import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Group4 extends StatefulWidget {
  Group4({
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
  State<Group4> createState() => _Group8State();
}

class _Group8State extends State<Group4> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  // File? imageFile;
  File? imageFile2 = null;
  late Future<Uint8List> data;
  double y = 1.5;
  bool clicked = false;
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
        // Slider
        Positioned(
          top: MediaQuery.of(context).padding.top + 130,
          right: MediaQuery.of(context).padding.right + 0,
          child: RotatedBox(
            quarterTurns: 3,
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
                      "Gamma Correction",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
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
                            y.toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Slider(
                        value: y,
                        min: 0,
                        max: 2,
                        divisions: 200,
                        label: y.toString(),
                        onChanged: (value) {
                          setState(() {
                            y = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
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

    return await platform
        .invokeMethod('getImage4', {'data': imageBytes, 'value': y});
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
