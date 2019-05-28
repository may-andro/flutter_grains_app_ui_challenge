import 'package:flutter/material.dart';

class SubTitleWidget extends StatelessWidget {
  final String label;
  SubTitleWidget({@required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.5, left: 16, top: 24, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              label,
              style: Theme.of(context)
                  .textTheme.caption.copyWith(
                  color: Colors.black87, fontWeight: FontWeight.w300),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
