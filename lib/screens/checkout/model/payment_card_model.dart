import 'package:flutter/material.dart';
import 'package:flutter_grains_app/screens/checkout/widgets/payment_card_header.dart';

typedef ExpandedListItemBodyBuilder<T> = Widget Function(
    PaymentCardModel<T> item);

class PaymentCardModel<T> {
    PaymentCardModel({
        this.cardName,
        this.cardNumber,
        this.cardDate,
        this.cardCvv,
        this.builder,
    })  : textCVVController = TextEditingController(text: cardCvv),
            textDateController = TextEditingController(text: cardDate),
            textCardNumberController = TextEditingController(text: cardNumber);

    final String cardName;
    final String cardNumber;
    final String cardDate;
    final String cardCvv;
    final ExpandedListItemBodyBuilder<T> builder;

    final TextEditingController textCVVController;
    final TextEditingController textCardNumberController;
    final TextEditingController textDateController;

    T value;
    bool isExpanded = false;

    ExpansionPanelHeaderBuilder get headerBuilder {
        return (BuildContext context, bool isExpanded) {
            return CardHeader(
                label: cardName,
            );
        };
    }

    Widget build() => builder(this);
}