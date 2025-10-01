// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:pack_bags/validator.dart';
//
// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({super.key});
//
//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }
//
// class _EditProfilePageState extends State<EditProfilePage> {
//   final _formKey = GlobalKey<FormState>();
//   bool isloading = false;
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _surnameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   File? _profileImage;
//
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _pickImage(ImageSource source) async {
//     final XFile? image = await _picker.pickImage(source: source);
//     if (image != null) {
//       setState(() {
//         _profileImage = File(image.path);
//       });
//     }
//     Navigator.pop(context); // Close the dialog
//   }
//   void _showImagePickerOptions() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.grey[900],
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: const Text(
//           'Choose Profile Photo',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           textAlign: TextAlign.center,
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.photo, color: Colors.white),
//               title: const Text('Gallery', style: TextStyle(color: Colors.white)),
//               onTap: () => _pickImage(ImageSource.gallery),
//             ),
//             ListTile(
//               leading: const Icon(Icons.camera_alt, color: Colors.white),
//               title: const Text('Camera', style: TextStyle(color: Colors.white)),
//               onTap: () => _pickImage(ImageSource.camera),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           ),
//           title: const Text(
//             'EDIT PROFILE',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.transparent,
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               GestureDetector(
//                 onTap: _showImagePickerOptions,
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundColor: Colors.grey[700],
//                   backgroundImage:
//                   _profileImage != null ? FileImage(_profileImage!) : null,
//                   child: _profileImage == null
//                       ? const Icon(Icons.person, color: Colors.white, size: 60)
//                       : null,
//                 ),
//               ),
//               const SizedBox(height: 32),
//               TextFormField(
//                 controller: _nameController,
//                 validator: (value)=>Validator.validateEmptyField("first name",value),
//                 style: const TextStyle(color: Colors.white),
//                 decoration: const InputDecoration(
//                   labelText: 'First Name',
//                   labelStyle: TextStyle(color: Colors.white),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _surnameController,
//                 validator: (value)=>Validator.validateEmptyField("last name",value),
//                 style: const TextStyle(color: Colors.white),
//                 decoration: const InputDecoration(
//                   labelText: 'Last Name',
//                   labelStyle: TextStyle(color: Colors.white),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _emailController,
//                 validator: (value)=>Validator.validateEmail(value),
//                 style: const TextStyle(color: Colors.white),
//                 decoration: const InputDecoration(
//                   labelText: 'Email',
//                   labelStyle: TextStyle(color: Colors.white),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//           GestureDetector(
//             onTap: () {
//               if (_formKey.currentState!.validate()) {
//                 setState(() => isloading = true);
//                 Future.delayed(const Duration(milliseconds: 500), () {
//                   Navigator.pop(context, {
//                     'name': _nameController.text.trim(),
//                     'email': _emailController.text.trim(),
//                   });
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Profile Updated!')),
//                   );
//                 });
//               }
//             },
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               decoration: BoxDecoration(
//                 color: Colors.teal,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               alignment: Alignment.center,
//               child: Text(
//                 'Submit',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
