import 'package:flutter_grains_app/model/grain_model.dart';
import 'package:flutter_grains_app/screens/checkout/model/payment_card_model.dart';
import 'package:flutter_grains_app/screens/checkout/widgets/payment_card_form.dart';

const ONBOARDING_FINISHED = 'ONBOARDING_FINISHED';

const SELECTED_THEME = 'SELECTED_THEME';
const SELECTED_THEME_SPAIN = 0;

List<GrainsModel> listOfGrains = [
  GrainsModel(
      grainImage: "assets/images/chickpea.jpg", grainName: "Chick Pea", id: 1),
  GrainsModel(
      grainImage: "assets/images/maize.jpeg", grainName: "Maize", id: 2),
  GrainsModel(
      grainImage: "assets/images/pigeonpea.jpeg",
      grainName: "Pigeon Pea",
      id: 3),
  GrainsModel(grainImage: "assets/images/rice.jpg", grainName: "Rice", id: 4),
  GrainsModel(grainImage: "assets/images/wheat.jpg", grainName: "Wheat", id: 5),
];

List<PaymentCardModel<dynamic>> listOfCards = <PaymentCardModel<dynamic>>[
  PaymentCardModel<String>(
    cardName: "HDFC debit card",
    cardDate: '12 2023',
    cardCvv: '',
    cardNumber: "XXXX XXXX XXXX 1234",
    builder: (PaymentCardModel<String> item) {
      return CardForm(
        item: item,
      );
    },
  ),
  PaymentCardModel<String>(
    cardName: "AXIS debit card",
    cardDate: '13 2034',
    cardCvv: '',
    cardNumber: "XXXX XXXX XXXX 4343",
    builder: (PaymentCardModel<String> item) {
      return CardForm(
        item: item,
      );
    },
  ),
];
