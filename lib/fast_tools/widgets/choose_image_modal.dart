// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, invalid_use_of_visible_for_testing_member, use_build_context_synchronously, implementation_imports, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/src/types/image_options.dart';
import 'package:shared_code/shared_code.dart';

import 'package:reaya_shared_code/utils/app_routes.dart';

class ChooseImageSourceModal extends StatefulWidget {
  final void Function(File file) addImage;
  final double? maxWidth;
  final double? maxHeight;
  const ChooseImageSourceModal({
    super.key,
    required this.addImage,
    this.maxHeight,
    this.maxWidth,
  });

  @override
  State<ChooseImageSourceModal> createState() => _ChooseImageSourceModalState();
}

class _ChooseImageSourceModalState extends State<ChooseImageSourceModal> {
  void chooseImage(ImageSource imageSource) async {
    AppRoutes.pop(context);
    var image = await ImagePicker.platform.getImageFromSource(
      source: imageSource,
      options: ImagePickerOptions(
        maxWidth: widget.maxWidth ?? 500,
        maxHeight: widget.maxHeight,
      ),
    );

    String? path = image?.path;
    if (path == null) return;
    File file = File(path);
    widget.addImage(file);
  }

  @override
  Widget build(BuildContext context) {
    return ModalWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          Text('قم بإضافة صورة'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ImageSourceButton(
                iconData: Icons.image,
                onTap: () {
                  chooseImage(ImageSource.gallery);
                },
              ),
              HSpace(),
              _ImageSourceButton(
                iconData: Icons.camera_alt,
                onTap: () {
                  chooseImage(ImageSource.camera);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ImageSourceButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;

  const _ImageSourceButton({
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      border: Border.all(
        color: Colors.grey,
        width: 1,
      ),
      borderRadius: 1000,
      padding: EdgeInsets.all(largePadding),
      onTap: onTap,
      child: Icon(
        iconData,
        color: Colors.grey,
        size: mediumIconSize,
      ),
    );
  }
}
