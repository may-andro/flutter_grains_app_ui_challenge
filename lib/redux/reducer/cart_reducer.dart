import 'package:flutter_grains_app/model/grain_model.dart';
import 'package:flutter_grains_app/redux/actions/cart_action.dart';
import 'package:redux/redux.dart';

final selectedCartReducer = combineReducers<Map<GrainsModel, int>>([
    TypedReducer<Map<GrainsModel, int>, SetCartListAction>(_setCartReducer),
]);

Map<GrainsModel, int> _setCartReducer(Map<GrainsModel, int> id, SetCartListAction action) {
    return action.itemList;
}