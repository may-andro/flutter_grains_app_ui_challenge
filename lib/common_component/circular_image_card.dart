import 'package:flutter/material.dart';

class CircularImageCard extends StatelessWidget {
  CircularImageCard({@required this.image, @required this.scale});

  final String image;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: MediaQuery.of(context).size.height * 0.25 * scale,
      width: MediaQuery.of(context).size.height * 0.25 * scale,
      child: Opacity(
        opacity: scale > 1 ? 1 : scale,
        child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          shape: CircleBorder(
              side: BorderSide(color: Colors.grey.shade200, width: 0)),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
