import 'package:flutter/material.dart';

class SectionDescription extends StatelessWidget {
  const SectionDescription({Key? key, required this.width, required this.text})
      : super(key: key);

  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Flexible(
              child: Text(
                text,
                style: Theme.of(context).textTheme.caption,
              ),
            )
          ],
        ),
      ),
    );
  }
}
