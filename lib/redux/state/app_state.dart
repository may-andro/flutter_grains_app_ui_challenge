import 'dart:collection';
import 'package:flutter_grains_app/model/grain_model.dart';

class AppState {
    final Map<GrainsModel, int> cartList;
    final int themeDataId;

    AppState({this.cartList,
        this.themeDataId,
    });

    factory AppState.initial() {
        return AppState(
            cartList: HashMap(),
            themeDataId: 0,
        );
    }

    AppState copyWith({
        List<GrainsModel> selectedList,
        int themeDataId,
    }) {
        return AppState(
            cartList: selectedList ?? this.cartList,
            themeDataId: themeDataId ?? this.themeDataId,
        );
    }
}