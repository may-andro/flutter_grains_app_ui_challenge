import 'package:flutter/material.dart';

class CardHeader extends StatelessWidget {
    const CardHeader({
        this.label,
    });

    final String label;

    @override
    Widget build(BuildContext context) {
        final ThemeData theme = Theme.of(context);
        final TextTheme textTheme = theme.textTheme;

        return Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.1,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    _getIcon(context),
                    SizedBox(
                        width: 20,
                    ),
                    _getLabel(label, context)
                ],
            ),
        );
    }

    Widget _getIcon(BuildContext context) {
        return Container(
            width: MediaQuery
                .of(context)
                .size
                .height * 0.1,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                    borderRadius: new BorderRadius.circular(8.0),
                    child: Icon(
                        Icons.credit_card
                    ),
                )),
        );
    }

    Widget _getLabel(String label, BuildContext context) {
        return Text(
            label,
            style: Theme
                .of(context)
                .textTheme
                .subtitle
                .copyWith(color: Colors.black87,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
        );
    }
}