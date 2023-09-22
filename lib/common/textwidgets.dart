import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:flutter/material.dart';

class PrimaryText extends StatelessWidget {
  const PrimaryText(this.data, this.fontSize, {super.key});

  final String data;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: AppColorScheme.primary,
        fontSize: fontSize,
      ),
    );
  }
}

class SecondaryText extends StatelessWidget {
  const SecondaryText(this.data, this.fontSize, {super.key});

  final String data;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: AppColorScheme.secondary,
        fontSize: fontSize,
      ),
    );
  }
}

class SurfaceText extends StatelessWidget {
  const SurfaceText(this.data, this.fontSize, {super.key});

  final String data;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: AppColorScheme.onSurface,
        fontSize: fontSize,
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText(this.data, {super.key, this.fontSize, this.color});

  final String data;
  final Color? color;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: color ?? AppColorScheme.primary,
        fontWeight: FontWeight.w400,
        fontSize: fontSize ?? 45,
      ),
    );
  }
}
