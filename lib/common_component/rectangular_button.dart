import 'package:flutter/material.dart';
import 'package:flutter_grains_app/utils/color_utility.dart';

class RoundedRectangleButton extends StatelessWidget {
    final String label;
    final Function onPress;
    final String color;
    final Color highlightColor;
    final bool isEnabled;

    RoundedRectangleButton(
        {@required this.label,
            @required this.onPress,
            @required this.color,
            this.highlightColor,
            this.isEnabled = true,
        });

    @override
    Widget build(BuildContext context) {
        var size = MediaQuery.of(context).size;
        var textTheme = Theme.of(context).textTheme;

        return MaterialButton(
            onPressed: isEnabled ? onPress : null,
            padding: const EdgeInsets.all(16.0),
            color: Color(getColorHexFromStr(color)),
            highlightColor: highlightColor,
            splashColor: highlightColor,
            colorBrightness: Brightness.light,
            elevation: 2,
            disabledColor: Colors.grey,
            highlightElevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: Text(
                label,
                style: textTheme.button
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
            ),
        );
    }
}