import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:flutter/material.dart';

class RateWidget extends StatelessWidget {
  const RateWidget({super.key, required this.rate});

  final int rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(size: 20,color: AppColorScheme.secondary, Icons.star),
        Icon(size: 20,color: rate >= 2 ? AppColorScheme.secondary : AppColorScheme.secondarySurface , Icons.star),
        Icon(size: 20,color: rate >= 3 ? AppColorScheme.secondary : AppColorScheme.secondarySurface , Icons.star),
        Icon(size: 20,color: rate >= 4 ? AppColorScheme.secondary : AppColorScheme.secondarySurface , Icons.star),
        Icon(size: 20,color: rate >= 5 ? AppColorScheme.secondary : AppColorScheme.secondarySurface , Icons.star),
      ],
    );
  }
}
