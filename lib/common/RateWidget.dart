import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/providers/ReviewProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RateWidget extends StatelessWidget {
  const RateWidget({super.key, required this.rate, this.size});

  final int rate;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(onTap: (){Provider.of<ReviewProvider>(context, listen: false).setRate(1);}, child: Icon(size: size ?? 20,color: rate >= 1 ? AppColorScheme.secondary : AppColorScheme.secondarySurface , Icons.star),),
        GestureDetector(onTap: (){Provider.of<ReviewProvider>(context, listen: false).setRate(2);}, child: Icon(size: size ?? 20,color: rate >= 2 ? AppColorScheme.secondary : AppColorScheme.secondarySurface , Icons.star),),
        GestureDetector(onTap: (){Provider.of<ReviewProvider>(context, listen: false).setRate(3);}, child: Icon(size: size ?? 20,color: rate >= 3 ? AppColorScheme.secondary : AppColorScheme.secondarySurface , Icons.star),),
        GestureDetector(onTap: (){Provider.of<ReviewProvider>(context, listen: false).setRate(4);}, child: Icon(size: size ?? 20,color: rate >= 4 ? AppColorScheme.secondary : AppColorScheme.secondarySurface , Icons.star),),
        GestureDetector(onTap: (){Provider.of<ReviewProvider>(context, listen: false).setRate(5);}, child: Icon(size: size ?? 20,color: rate >= 5 ? AppColorScheme.secondary : AppColorScheme.secondarySurface , Icons.star),),
      ],
    );
  }
}
