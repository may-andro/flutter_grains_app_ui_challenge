import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_grains_app/base_bloc/base_bloc_provider.dart';
import 'package:flutter_grains_app/redux/actions/cart_action.dart';
import 'package:flutter_grains_app/redux/state/app_state.dart';
import 'package:flutter_grains_app/screens/home/widgets/button_container_widget.dart';
import 'package:flutter_grains_app/screens/home/widgets/cart_container_widget.dart';
import 'package:flutter_grains_app/screens/home/widgets/grain_pager_widget.dart';
import 'package:flutter_grains_app/screens/home/widgets/selected_weight_widget.dart';
import 'package:flutter_grains_app/screens/home/widgets/sub_title_widget.dart';
import 'package:flutter_grains_app/common_component/title_widget.dart';
import 'package:flutter_grains_app/utils/constants.dart';
import 'package:flutter_grains_app/utils/text_constant.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'bloc/home_bloc.dart';

class HmePage extends StatefulWidget {
  const HmePage();

  @override
  _HmePageState createState() => _HmePageState();
}

class _HmePageState extends State<HmePage> with TickerProviderStateMixin {
  AnimationController animationController;

  HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animationController.forward();
    homeBloc = HomeBloc();
    homeBloc.focusedGrainSink.add(listOfGrains[0]);
  }

  @override
  void dispose() {
    animationController.dispose();
    homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BaseBlocProvider(
      bloc: homeBloc,
      child: Scaffold(
        body: _buildBody(size, Theme.of(context).textTheme),
      ),
    );
  }

  Widget _buildBody(Size size, TextTheme textTheme) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: Stack(fit: StackFit.expand, children: <Widget>[
                _buildTitleContainer(),
                _buildSubTitleContainer(),
                _buildPagerContainer(),
                _buildSizeBarContainer(),
                _buildButtonsContainer(),
                _buildCartIconContainer()
              ]),
            ),
          );
        });
  }

  Widget _buildTitleContainer() {
    return Positioned(
        left: 0, right: 0, top: 0, child: TitleWidget(label: HOME_TITLE));
  }

  Widget _buildSubTitleContainer() {
    return Positioned(
        left: 0,
        right: 0,
        top: MediaQuery.of(context).size.height * 0.05,
        child: SubTitleWidget(label: HOME_SUBTITLE));
  }

  Widget _buildPagerContainer() {
    return Positioned(
      left: 0,
      right: 0,
      top: MediaQuery.of(context).size.height * 0.15,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Center(child: GrainsPager())),
    );
  }

  Widget _buildSizeBarContainer() {
    return Positioned(
      left: 0,
      right: 0,
      top: MediaQuery.of(context).size.height * 0.6,
      child: SelectedWeightWidget(),
    );
  }

  Widget _buildButtonsContainer() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: ButtonContainerWidget(
        onAddToCart: () {
          homeBloc.addToCartSink.add(homeBloc.selectedWeight);
        },
        onBuyNow: () {
          Navigator.of(context).pushNamed('/checkout');
          var store = StoreProvider.of<AppState>(context);
          store.dispatch(SetCartListAction(itemList: homeBloc.selectedList));
        },
          controller: animationController
      ),
    );
  }

  Widget _buildCartIconContainer() {
    return Positioned(
      right: 0,
      top: 0,
      child: CartContainer(controller: animationController),
    );
  }
}


