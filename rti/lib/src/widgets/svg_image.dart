import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  final String? asset;
  final double? height, width;
  final Color? color;
  const SvgImage(this.asset, {this.height, this.width,this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset ?? "",
      height: height,
      width: width,
    );
  }
}
