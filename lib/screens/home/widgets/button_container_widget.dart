import 'package:flutter/material.dart';
import 'package:flutter_grains_app/base_bloc/base_bloc_provider.dart';
import 'package:flutter_grains_app/common_component/rectangular_button.dart';
import 'package:flutter_grains_app/model/grain_model.dart';
import 'package:flutter_grains_app/screens/home/bloc/home_bloc.dart';
import 'package:flutter_grains_app/utils/color_utility.dart';
import 'package:flutter_grains_app/utils/text_constant.dart';

class ButtonContainerWidget extends StatelessWidget {
  final Function onAddToCart;
  final Function onBuyNow;
  final CartContainerEnterAnimation enterAnimation;

  ButtonContainerWidget(
      {@required this.onAddToCart,
      @required this.onBuyNow,
      @required AnimationController controller})
      : enterAnimation = CartContainerEnterAnimation(controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _spacingSizeBox(),
            _buttonBuyNow(context),
            _spacingSizeBox(),
            _buttonAddRemoveCart(context),
            _spacingSizeBox(),
          ],
        ),
      ),
    );
  }

  _spacingSizeBox() {
    return SizedBox(
      width: 16,
    );
  }

  _buttonBuyNow(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BaseBlocProvider.of<HomeBloc>(context);
    return StreamBuilder<Map<GrainsModel, int>>(
        stream: bloc.selectedItemStream,
        builder: (BuildContext buildContext,
            AsyncSnapshot<Map<GrainsModel, int>> snapshot) {
          int cartListCount = snapshot.hasData ? snapshot.data.length : 0;
          return Expanded(
            flex: 1,
            child: Transform(
              transform: Matrix4.translationValues(
                  - enterAnimation.translationRight.value * 250, 0.0, 0.0),
              child: RoundedRectangleButton(
                onPress: onBuyNow,
                label: BUY_NOW_LABEL,
                color: BLACK,
                highlightColor: Colors.red,
                isEnabled: cartListCount > 0,
              ),
            ),
          );
        });
  }

  _buttonAddRemoveCart(BuildContext context) {
    final bloc = BaseBlocProvider.of<HomeBloc>(context);
    return StreamBuilder<int>(
        stream: bloc.addToCartButtonLabelStream,
        builder: (BuildContext buildContext, AsyncSnapshot<int> snapshot) {
          int buttonStatus = snapshot.hasData ? snapshot.data : 0;
          // buttonStatus == 0 means item is not present in cart list
          // buttonStatus == 1 means item is present in cart list
          String label =
              buttonStatus == 0 ? ADD_TO_CART_LABEL : REMOVE_FROM_CART_LABEL;
          return Expanded(
            flex: 1,
            child: Transform(
              transform: Matrix4.translationValues(enterAnimation.translationRight.value * 250, 0.0, 0.0),
              child: RoundedRectangleButton(
                onPress: onAddToCart,
                label: label,
                color: buttonStatus == 0 ? PRIMARY_COLOR : REMOVE_ITEM_COLOR,
                highlightColor: Colors.red,
              ),
            ),
          );
        });
  }
}

class CartContainerEnterAnimation {
  CartContainerEnterAnimation(this.controller)
      : translationRight = new Tween(begin: 1.0, end: 0.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0,
              1,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        translationLeft = new Tween(begin: 1.0, end: 0.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.0,
              1,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        );

  final AnimationController controller;
  final Animation<double> translationRight;
  final Animation<double> translationLeft;
}
