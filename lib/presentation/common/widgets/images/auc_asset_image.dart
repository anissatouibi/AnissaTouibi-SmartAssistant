import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainImageAsset extends StatelessWidget {
  final String path;
  final String? darkPath;

  final double? height;
  final double? width;

  const MainImageAsset({super.key, required this.path, this.darkPath, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Image(
      width: width,
      height: height,
      image: AssetImage(
        path,
      ),
      fit: BoxFit.cover,
    );
  }
}
