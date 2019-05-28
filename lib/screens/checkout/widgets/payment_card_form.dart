import 'package:flutter/material.dart';
import 'package:flutter_grains_app/screens/checkout/checkout_page.dart';
import 'package:flutter_grains_app/screens/checkout/model/payment_card_model.dart';
import 'package:flutter_grains_app/utils/masked_text_input_formatter.dart';

class CardForm extends StatelessWidget {
    const CardForm({
        this.item,
    });

    final PaymentCardModel<String> item;

    @override
    Widget build(BuildContext context) {
        final ThemeData theme = Theme.of(context);
        final TextTheme textTheme = theme.textTheme;

        return Container(
            child: _paymentForm(item, context),
        );
    }

    Widget _paymentForm(PaymentCardModel<String> item, BuildContext context) {
        return Container(
            height: 100,
            color: Colors.white,
            child: Form(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                            _getCardNumberField(item, context),
                            _getExpiryDateField(item, context),
                            _getCVVField(item, context)
                        ],
                    ),
                )
            ),
        );
    }

    Widget _getCardNumberField(PaymentCardModel<String> item, BuildContext context) {
        return Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 50,
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: 45
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                        item.cardNumber,
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle
                            .copyWith(
                            color: Colors.blueGrey, letterSpacing: 1.2),
                    ),
                ),
            ),
        );
    }

    Widget _getExpiryDateField(PaymentCardModel<String> item, BuildContext context) {
        return Positioned(
            top: 40,
            left: 0,
            bottom: 0,
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.35,
                    maxHeight: 45
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                        item.cardDate,
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle
                            .copyWith(
                            color: Colors.blueGrey, letterSpacing: 1.2),
                        textAlign: TextAlign.center,
                    ),
                ),
            ),
        );
    }

    Widget _getCVVField(PaymentCardModel<String> item, BuildContext context) {
        return Positioned(
            top: 40,
            right: 0,
            bottom: 0,
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.35,
                    maxHeight: 45
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                        controller: item.textCVVController,
                        decoration: new InputDecoration(
                            hintText: "CVV",
                            border: InputBorder.none,
                            errorMaxLines: 2,
                            helperStyle: Theme
                                .of(context)
                                .textTheme
                                .caption
                                .copyWith(
                                color: Colors.blueGrey, letterSpacing: 1.2),
                            counterText: null
                        ),
                        onSaved: (String value) {
                            //item.cardDate = value;
                        },
                        inputFormatters: [
                            MaskedTextInputFormatter(
                                mask: 'xxx',
                                separator: '-',
                            ),
                        ],
                        obscureText: true,
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle
                            .copyWith(
                            color: Colors.blueGrey, letterSpacing: 1.2),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.start,
                    ),
                ),
            ),
        );
    }

}