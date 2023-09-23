import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:flutter/material.dart';

class RateWidget extends StatelessWidget {
  const RateWidget({super.key, required this.rate, this.size});

  final int rate;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(size: size ?? 20,color: rate >= 1 ? AppColorScheme.secondary : AppColorScheme.secondarySurface , Icons.star),
        Icon(size: size ?? 20,color: rate >= 2 ? AppColorScheme.secondary : AppColorScheme.secondarySurface , Icons.star),
        Icon(size: size ?? 20,color: rate >= 3 ? AppColorScheme.secondary : AppColorScheme.secondarySurface , Icons.star),
        Icon(size: size ?? 20,color: rate >= 4 ? AppColorScheme.secondary : AppColorScheme.secondarySurface , Icons.star),
        Icon(size: size ?? 20,color: rate >= 5 ? AppColorScheme.secondary : AppColorScheme.secondarySurface , Icons.star),
      ],
    );
  }
}
