import 'package:flutter/material.dart';
import 'package:flutter_grains_app/utils/color_utility.dart';

class CheckoutButtonContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    _spacingSizeBox(),
                    _previousButton(context),
                    _spacingSizeBox(),
                    _nextButton(context),
                    _spacingSizeBox(),
                ],
            ),
        ),
    );
  }

  _spacingSizeBox() {
      return SizedBox(
          width: 16,
      );
  }

  _nextButton(BuildContext context) {
      return MaterialButton(
          onPressed: () => Navigator.of(context).pushNamed("/order"),
          padding: const EdgeInsets.all(16.0),
          color: Color(getColorHexFromStr(BLACK)),
          colorBrightness: Brightness.light,
          elevation: 2,
          highlightElevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)),
          child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
          ),
      );
  }

  _previousButton(BuildContext context) {
      return MaterialButton(
          onPressed: () => Navigator.of(context).pop(),
          padding: const EdgeInsets.all(16.0),
          color: Color(getColorHexFromStr(BLACK)),
          colorBrightness: Brightness.light,
          elevation: 2,
          highlightElevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)),
          child: Icon(
              Icons.arrow_back,
              color: Colors.white,
          ),
      );
  }
}
