import 'package:cinerv/src/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? textColor;
  final String title;
  final double? buttonHeight;
  final bool? useFullWidth;
  final double? borderRadius;
  final TextStyle? textStyle;
  final Function? onTap;
  const CommonButton({
    this.borderRadius = 10,
    this.buttonHeight = 20,
    this.onTap,
    required this.title,
    this.textColor,
    this.useFullWidth = false,
    this.textStyle = kStyleFeature,
    this.buttonColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: useFullWidth! ? 1.sw : 200,
      child: ElevatedButton(
        autofocus: false,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10)),
          foregroundColor: textColor ?? Colors.white,
          backgroundColor: buttonColor ?? Colors.red.withOpacity(0.85),
        ),
        onPressed: () {
          onTap?.call();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: buttonHeight ?? 0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: kStyleFeature,
          ),
        ),
      ),
    );
  }
}
