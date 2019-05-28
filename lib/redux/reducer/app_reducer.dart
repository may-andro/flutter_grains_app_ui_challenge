import 'package:flutter_grains_app/redux/reducer/cart_reducer.dart';
import 'package:flutter_grains_app/redux/reducer/theme_change_reducers.dart';
import 'package:flutter_grains_app/redux/state/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
    return AppState(
        cartList: selectedCartReducer(state.cartList, action),
        themeDataId: changeThemeReducer(state.themeDataId, action)
    );

    //return state.setUser(user: action.user);
}