import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  bool _isImageUploaded = false;
  bool _isFormValid = false;
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController phoneController =
      TextEditingController(text: '+237');
  final FocusNode phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    phoneFocusNode.addListener(() {
      if (phoneFocusNode.hasFocus && !phoneController.text.startsWith('+237')) {
        phoneController.text = '+237';
        phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: phoneController.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    phoneFocusNode.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _fullNameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          _isImageUploaded;
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
    }
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
              SizedBox(height: 20),
              Center(
                child: const Text(
                  'Set up Profile',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w100,
                    color: Color(0xFFC4C4C4),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 134,
                          height: 134,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(254, 235, 234, 1),
                            borderRadius: BorderRadius.circular(100),
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
                            'Full Name',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _fullNameController,
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
                      SizedBox(height: 10),
                      TextFormField(
                        controller: phoneController,
                        focusNode: phoneFocusNode,
                        cursorColor: const Color.fromARGB(192, 255, 255, 255),
                        decoration: const InputDecoration(
                          labelText:
                              'Phone Number *', // Add an asterisk to indicate it's required
                          labelStyle: TextStyle(
                            color: Color(0xFFB1B1B1),
                          ),
                        ),
                        style: const TextStyle(color: Color(0xFFB1B1B1)),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(13),
                          FilteringTextInputFormatter.allow(RegExp(r'[\d+]')),
                        ],
                        validator: (value) {
                          if (value!.length <= 13) {
                            return 'Please enter a phone number';
                          }
                          return null; // Return null if validation passes.
                        },
                        onChanged: (value) {
                          if (!value.startsWith('+237')) {
                            phoneController.text = '+237';
                            phoneController.selection =
                                TextSelection.fromPosition(
                              TextPosition(offset: phoneController.text.length),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        cursorColor: Color.fromARGB(192, 255, 255, 255),
                        decoration: InputDecoration(
                          labelText: 'E-mail Address',
                          labelStyle: TextStyle(
                            color: Color(0xFFB1B1B1),
                          ),
                        ),
                        style: TextStyle(color: Color(0xFFB1B1B1)),
                      ),
                      SizedBox(
                        height: 60,
                      ),
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
                            'Save',
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
