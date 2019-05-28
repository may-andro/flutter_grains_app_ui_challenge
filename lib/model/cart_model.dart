import 'package:meta/meta.dart';

import 'grain_model.dart';

class CartModel {
    CartModel({
        @required this.grainsModel,
        @required this.quantity,
    });

    final GrainsModel grainsModel;
    final int quantity;
}
