import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class formedCachedImage extends StatelessWidget {
  const formedCachedImage({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.errorWidget,
    this.isCover,
  }) : super(key: key);
  final String imageUrl;
  final double? height;
  final double? width;
  final Widget? errorWidget;
  final bool? isCover;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      fadeInDuration: const Duration(microseconds: 50),
      fadeOutDuration: const Duration(microseconds: 50),
      placeholder: (context, url) => const Center(child: CupertinoActivityIndicator()),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color(0xff545454),
            ),
          ),
    );
  }
}
