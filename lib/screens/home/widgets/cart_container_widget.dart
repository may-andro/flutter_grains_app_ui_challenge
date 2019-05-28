import 'package:flutter/material.dart';
import 'package:flutter_grains_app/base_bloc/base_bloc_provider.dart';
import 'package:flutter_grains_app/model/grain_model.dart';
import 'package:flutter_grains_app/screens/home/bloc/home_bloc.dart';
import 'package:flutter_grains_app/utils/color_utility.dart';

class CartContainer extends StatelessWidget {
  final CartContainerEnterAnimation enterAnimation;

  CartContainer({@required AnimationController controller})
      : enterAnimation = new CartContainerEnterAnimation(controller);

  @override
  Widget build(BuildContext context) {
    final bloc = BaseBlocProvider.of<HomeBloc>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.height * 0.15,
      child: StreamBuilder<Map<GrainsModel, int>>(
          stream: bloc.selectedItemStream,
          builder: (BuildContext buildContext,
              AsyncSnapshot<Map<GrainsModel, int>> snapshot) {
            int count = snapshot.hasData ? snapshot.data.length : 0;
            return Stack(
              children: <Widget>[
                _cartIcon(context, count),
                _circleCount(context, count)
              ],
            );
          }),
    );
  }

  Widget _cartIcon(BuildContext context, int count) {
    return Positioned(
        top: 24,
        right: 24,
        child: Transform(
            transform: Matrix4.translationValues(enterAnimation.translationTop.value * 100, 0.0, 0.0),
          child: Icon(
            Icons.shopping_cart,
            size: MediaQuery.of(context).size.height * 0.05,
            color: count > 0
                ? Color(getColorHexFromStr(PRIMARY_COLOR))
                : Colors.grey,
          ),
        ));
  }

  Widget _circleCount(BuildContext context, int count) {
    return Positioned(
        top: 20,
        right: 24,
        child: count > 0
            ? Container(
                width: MediaQuery.of(context).size.height * 0.025,
                height: MediaQuery.of(context).size.height * 0.025,
                margin: EdgeInsets.only(left: 80.0),
                child: Center(
                  child: Text(count.toString(),
                      style: new TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                ),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromRGBO(80, 210, 194, 1.0),
                ))
            : Offstage());
  }
}

class CartContainerEnterAnimation {
  CartContainerEnterAnimation(this.controller)
      : translationTop = new Tween(begin: 1.0, end: 0.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.1,
              0.5,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        );

  final AnimationController controller;
  final Animation<double> translationTop;
}
