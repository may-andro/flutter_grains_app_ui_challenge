import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String label;
  TitleWidget({@required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .headline
                .copyWith(color: Colors.black87, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
