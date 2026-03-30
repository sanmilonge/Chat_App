import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  const UserImage({super.key, required this.onImagePicked});

  final void Function(File pickedImage) onImagePicked;

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File? _pickedImage;
  bool _isTakingPhoto = true;
  bool _isPickingImage = false;

  Future<void> _selectPhoto() async {
    if (_isPickingImage) return;
    setState(() => _isPickingImage = true);

    try {
      final pickedImage = await ImagePicker().pickImage(
        source: _isTakingPhoto ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 150,
        imageQuality: 50,
      );

      if (pickedImage == null) return;

      final file = File(pickedImage.path);
      if (!mounted) return;

      setState(() => _pickedImage = file);
      widget.onImagePicked(file);
    } finally {
      if (!mounted) return;
      setState(() => _isPickingImage = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage != null
              ? FileImage(_pickedImage!)
              : null,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _isPickingImage
                  ? null
                  : () {
                      setState(() => _isTakingPhoto = true);
                      _selectPhoto();
                    },
              icon: const Icon(Icons.add_a_photo_outlined),
              label: Text(_isPickingImage ? 'Opening…' : 'Take Photo'),
            ),
            const SizedBox(width: 5),
            TextButton.icon(
              onPressed: _isPickingImage
                  ? null
                  : () {
                      setState(() => _isTakingPhoto = false);
                      _selectPhoto();
                    },
              icon: const Icon(Icons.image_outlined),
              label: Text(_isPickingImage ? 'Opening…' : 'Select Photo'),
            ),
          ],
        ),
      ],
    );
  }
}
