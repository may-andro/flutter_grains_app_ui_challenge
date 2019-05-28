import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  AnimationController animationController;
  OrderEnterAnimation orderEnterAnimation;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    orderEnterAnimation = OrderEnterAnimation(animationController);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Stack(
      children: <Widget>[_buildDoneIcon(), _buildDoneLabel()],
    );
  }

  _buildDoneIcon() {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.5,
      left: 0,
      right: 0,
      child: ScaleTransition(
        scale: orderEnterAnimation.animationRotate,
        child: Icon(
          Icons.check_circle_outline,
          size: MediaQuery.of(context).size.height * 0.2,
        ),
      ),
    );
  }

  _buildDoneLabel() {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.2,
      left: 0,
      right: 0,
      child: Text(
        "Done",
        style: Theme.of(context)
            .textTheme
            .headline
            .copyWith(color: Colors.black87, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class OrderEnterAnimation {
  OrderEnterAnimation(this.controller)
      : animationRotate = Tween(begin: 1.0, end: 2.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0,
              1,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        );

  final AnimationController controller;
  Animation<double> animationRotate;
}
