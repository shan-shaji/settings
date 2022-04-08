import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectableSvgImage extends StatelessWidget {
  const SelectableSvgImage(
      {Key? key,
      required this.path,
      this.onTap,
      required this.selected,
      required this.height,
      required this.selectedColor,
      this.padding})
      : super(key: key);

  final String path;
  final VoidCallback? onTap;
  final bool selected;
  final double height;
  final double? padding;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6.0),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding ?? 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SvgPicture.asset(
              path,
              color:
                  selected ? selectedColor : Theme.of(context).backgroundColor,
              colorBlendMode: selected ? BlendMode.srcIn : BlendMode.color,
              height: height,
            ),
          ),
        ),
      ),
    );
  }
}
