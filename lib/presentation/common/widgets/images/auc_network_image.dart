import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MainNetworkImage extends StatelessWidget {
  final String path;
  final String placeholder;

  final double? height;
  final double? width;

  const MainNetworkImage(
      {super.key, required this.path, this.height, this.width, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: BoxFit.cover,
      imageUrl: path,
      placeholder: (context, url) {
        return _placeholderWidget().animate().blur();
      },
      placeholderFadeInDuration: Duration.zero,
      errorWidget: (context, error, stackTrace) {
        if (placeholder.isNotEmpty) {
          return _placeholderWidget().animate().blur();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  CachedNetworkImage _placeholderWidget() {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: BoxFit.cover,
      imageUrl: placeholder,
      errorWidget: (context, url, error) => const SizedBox.shrink(),
    );
  }
}
