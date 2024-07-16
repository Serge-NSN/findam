import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:findam/home_screen.dart';

class ReportItem extends StatefulWidget {
  const ReportItem({super.key});

  @override
  _ReportItemState createState() => _ReportItemState();
}

class _ReportItemState extends State<ReportItem> {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  bool _isImageUploaded = false;
  bool _isFormValid = false;
  bool _isLoading = false;
  File? _selectedImage;
  DateTime? _foundDate;

  final ImagePicker _picker = ImagePicker();
  final textRecognizer = GoogleMlKit.vision.textRecognizer();

  void _validateForm() {
    setState(() {
      _isFormValid = _itemNameController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty &&
          _locationController.text.isNotEmpty &&
          _phoneNumberController.text.isNotEmpty &&
          _isImageUploaded &&
          _foundDate != null;
    });
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _pickImageFromSource(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImageFromSource(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromSource(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

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

    const phrases = [
      'REPUBLIC OF CAMEROON',
      'NOM/SURNAME',
      'Request identifiant',
      'Carte Nationale',
      'Profession',
      'SIGNATURE',
      'SEX',
      'PLACE OF BIRTH',
      'demande',
      'Temporary Identity Document',
      'CAMEROUN',
      'NATIONAL SECURITY',
      'provisoire'
    ];

    final matchedPhrases = phrases.where((phrase) =>
        recognizedText.text.toUpperCase().contains(phrase.toUpperCase()));
    if (matchedPhrases.length >= 4) {
      setState(() {
        _itemNameController.text = 'ID Card';
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    Color.fromARGB(255, 97, 59, 3), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _foundDate) {
      setState(() {
        _foundDate = picked;
        _validateForm();
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String imageUrl = '';
          if (_selectedImage != null) {
            try {
              final storageRef = FirebaseStorage.instance.ref().child(
                  'reported_items/${DateTime.now().millisecondsSinceEpoch}.jpg');
              final uploadTask = storageRef.putFile(_selectedImage!);
              final snapshot = await uploadTask.whenComplete(() {});
              imageUrl = await snapshot.ref.getDownloadURL();
            } catch (e) {
              print('Error uploading image: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text('Failed to upload the image. Please try again.')),
              );
              setState(() {
                _isLoading = false;
              });
              return;
            }
          }

          await FirebaseFirestore.instance.collection('reported_items').add({
            'item_name': _itemNameController.text,
            'description': _descriptionController.text,
            'location': _locationController.text,
            'phone_number': _phoneNumberController.text,
            'found_date': _foundDate?.toIso8601String(),
            'image_url': imageUrl,
            'user_id': user.uid,
            'user_email': user.email,
          });

          // Navigate to home screen after successful submission
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(selectedIndex: 0)),
            (Route<dynamic> route) => false,
          );
        }
      } catch (e) {
        print('Error submitting form: $e');
        // Show an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to submit the form. Please try again.')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _phoneNumberController.dispose();
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
                      SizedBox(height: 5),
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
                            fontWeight: FontWeight.w300),
                      ),
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
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: TextFormField(
                          controller: _descriptionController,
                          cursorColor: Colors.grey,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Provide details here...',
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
                            fontSize: 15,
                          ),
                        ),
                      ),
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
                            ' Date Found',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _foundDate == null
                                    ? 'Select date'
                                    : '${_foundDate!.day}/${_foundDate!.month}/${_foundDate!.year}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
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
                            ' Where did you find this item?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _locationController,
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
                          fontWeight: FontWeight.w300,
                        ),
                      ),
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
                            ' Phone Number',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _phoneNumberController,
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
                          fontWeight: FontWeight.w300,
                        ),
                        maxLength: 9,
                        keyboardType: TextInputType.phone,
                      ),
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
                          onPressed:
                              _isFormValid && !_isLoading ? _submitForm : null,
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFF031B01)),
                                )
                              : const Text(
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
