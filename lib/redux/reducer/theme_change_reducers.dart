import 'package:flutter_grains_app/redux/actions/change_theme_action.dart';
import 'package:redux/redux.dart';

final changeThemeReducer = combineReducers<int>([
    TypedReducer<int, ChangeThemeAction>(_changeThemeReducer),
]);

int _changeThemeReducer(int id, ChangeThemeAction action) {
    return action.themeId;
}