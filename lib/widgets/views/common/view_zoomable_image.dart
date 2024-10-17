import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewZoomableImage extends StatelessWidget {
  final String imageUrl;

  const ViewZoomableImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(imageUrl),
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 2,
    );
  }
}
