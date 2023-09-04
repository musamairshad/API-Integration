import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _selectedImage;

  bool _showSpinner = false;

  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
      imageQuality: 80,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  Future<void> uploadImage() async {
    setState(() {
      _showSpinner = true;
    });

    var stream = http.ByteStream(_selectedImage!.openRead());
    stream.cast();

    var length = await _selectedImage!.length();

    final uri = Uri.https('fakestoreapi.com', '/products');

    final request = http.MultipartRequest('POST', uri);

    request.fields['title'] = 'Static title';

    var multiport = http.MultipartFile('image', stream, length);

    request.files.add(multiport);

    var response = await request.send();

    if (response.statusCode == 200) {
      // print(response.stream.toString());
      setState(() {
        _showSpinner = false;
      });
      // print('Image uploaded.');
    } else {
      setState(() {
        _showSpinner = false;
      });
      // print('Failed to upload an image!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload Image'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _takePicture();
              },
              child: Container(
                child: _selectedImage == null
                    ? const Center(
                        child: Text('Pick an image.'),
                      )
                    : Center(
                        child: Image.file(
                          _selectedImage!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 150),
            GestureDetector(
              onTap: () {
                uploadImage();
              },
              child: Container(
                height: 50,
                width: 200,
                color: Colors.green,
                child: const Center(child: Text('Upload Image')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
