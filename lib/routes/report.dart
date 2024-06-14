import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';

class ReportItem extends StatefulWidget {
  const ReportItem({super.key});

  @override
  _ReportItemState createState() => _ReportItemState();
}

class _ReportItemState extends State<ReportItem> {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isImageUploaded = false;
  bool _isFormValid = false;
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();
  final textRecognizer = GoogleMlKit.vision.textRecognizer();

  void _validateForm() {
    setState(() {
      _isFormValid = _itemNameController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty &&
          _isImageUploaded;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _isImageUploaded = true;
        _validateForm();
      });
      _extractTextFromImage(File(pickedFile.path));
    }
  }

  Future<void> _extractTextFromImage(File image) async {
    final inputImage = InputImage.fromFile(image);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    setState(() {
      _descriptionController.text = recognizedText.text;
    });
    _validateForm();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _descriptionController.dispose();
    textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          onChanged: _validateForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Report an item',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 167,
                          height: 135,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(254, 235, 234, 1),
                            borderRadius: BorderRadius.circular(20),
                            image: _selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(_selectedImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _selectedImage == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.file_upload_outlined,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      'Upload',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Text(
                            '*',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            ' Item name',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                          controller: _itemNameController,
                          cursorColor: Color.fromARGB(192, 255, 255, 255),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Color(0xFFB1B1B1),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB1B1B1)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w300)),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            '*',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            ' Description',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.grey,
                            width: 1.0, // Adjust the width as needed
                          ))),
                          child: TextFormField(
                            controller: _descriptionController,
                            cursorColor: Colors.grey,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Enter your text...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(8),
                              hintStyle: TextStyle(
                                fontSize: 15,
                                color: const Color.fromARGB(132, 255, 255, 255),
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                                fontSize: 15),
                            // Set the text color to white
                          )),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.all(13),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              _isFormValid
                                  ? Color.fromARGB(255, 254, 235, 234)
                                  : Color.fromARGB(167, 254, 235, 234),
                            ),
                          ),
                          onPressed: _isFormValid
                              ? () {
                                  // Handle form submission
                                }
                              : null,
                          child: const Text(
                            'Report',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF031B01),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
