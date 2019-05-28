import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_grains_app/redux/state/app_state.dart';
import 'package:flutter_grains_app/redux/store/redux_store.dart';
import 'package:flutter_grains_app/screens/checkout/checkout_page.dart';
import 'package:flutter_grains_app/screens/home/home_page.dart';
import 'package:flutter_grains_app/screens/order/order_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() => run();

Future run() async {
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  var store = await createStore();
  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, appState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                  primarySwatch: Colors.deepPurple,
                  canvasColor: Colors.transparent,
                  backgroundColor: Colors.white),
              initialRoute: '/',
              routes: <String, WidgetBuilder>{
                '/home': (BuildContext context) => HmePage(),
                '/checkout': (BuildContext context) => CheckoutPage(),
                '/order': (BuildContext context) => OrderPage(),
              },
              home: HmePage(),
            );
          },
        ));
  }
}
