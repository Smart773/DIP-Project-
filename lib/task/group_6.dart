import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Group6 extends StatefulWidget {
  Group6({
    Key? key,
    required this.mode,
    this.fileImage,
    required this.callback,
  }) : super(key: key);

  final String mode;
  File? fileImage;
  final callback;

  @override
  State<Group6> createState() => _Group6State();
}

class _Group6State extends State<Group6> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  // File? imageFile;
  File? imageFile2 = null;
  File? imageFile3 = null;
  late Future<Uint8List> data;
  bool clicked = false;
  Uint8List? imageBytes;
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
      ],
    );
  }

  // Function will send a image and then get a image back
  Future<Uint8List> _getImage() async {
    // Send a image to the native side

    imageBytes = widget.fileImage!.readAsBytesSync();
    Uint8List imageBytes2 = imageFile3!.readAsBytesSync();
    // imageBytes1 = widget.fileImage!.readAsBytesSync();

    return await platform
        .invokeMethod('getImage6', {'data1': imageBytes, 'data2': imageBytes2});
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
