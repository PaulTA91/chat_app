import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    super.key,
    required this.imagePickFn,
  });

  final void Function(File pickedImage) imagePickFn;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? pickedImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage() async {
    final userImage = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      pickedImage = File(userImage!.path);
    });
    widget.imagePickFn(pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: pickedImage != null ? FileImage(pickedImage!) : null,
          backgroundColor: Colors.grey,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text("Add Image"),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).backgroundColor,
          ),
        ),
      ],
    );
  }
}
