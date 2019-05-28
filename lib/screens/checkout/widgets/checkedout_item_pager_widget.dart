import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_grains_app/base_bloc/base_bloc_provider.dart';
import 'package:flutter_grains_app/common_component/circular_image_card.dart';
import 'package:flutter_grains_app/common_component/pager_background.dart';
import 'package:flutter_grains_app/model/grain_model.dart';
import 'package:flutter_grains_app/screens/home/bloc/home_bloc.dart';
import 'package:flutter_grains_app/utils/constants.dart';
import 'package:flutter_grains_app/utils/text_constant.dart';

class CartGrainsPager extends StatelessWidget {
  CartGrainsPager({this.grainList})
      : pageController = PageController(initialPage: 0, viewportFraction: 1);

  final Map<GrainsModel, int> grainList;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PagerBackground(
      child: _pagerContainer(context),
    );
  }

  Widget _pagerContainer(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.2),
      child: _pagerList(context),
    );
  }

  Widget _pagerList(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _pager(context),
      ],
    );
  }

  Widget _pager(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * 0.2,
      padding: EdgeInsets.all(8),
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: pageController,
        itemCount: grainList.length,
        itemBuilder: (context, index) {
          return pagerItem(context, grainList.keys.elementAt(index), grainList.values.toList().elementAt(index));
        },
      ),
    );
  }

  Widget pagerItem(BuildContext context, GrainsModel grainsModel, int weight) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        circleImage(grainsModel.grainImage),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              grainsModel.grainName,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.black87, letterSpacing: 1.2),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "$weight kg",
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(color: Colors.black87, letterSpacing: 1.2),
            )
          ],
        )
      ],
    );
  }

  Widget circleImage(String image) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CircularImageCard(image: image, scale: 1),
    );
  }
}
