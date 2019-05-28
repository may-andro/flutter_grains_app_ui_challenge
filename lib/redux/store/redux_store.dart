import 'dart:async';
import 'package:flutter_grains_app/redux/state/app_state.dart';
import 'package:flutter_grains_app/redux/reducer/app_reducer.dart';
import 'package:redux/redux.dart';

Future<Store<AppState>> createStore() async {
    return Store<AppState>(
        appReducer, // new
        initialState: AppState.initial(),
        distinct: true,
    );
}