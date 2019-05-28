import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_grains_app/base_bloc/base_bloc_provider.dart';
import 'package:flutter_grains_app/common_component/circular_image_card.dart';
import 'package:flutter_grains_app/common_component/pager_background.dart';
import 'package:flutter_grains_app/model/grain_model.dart';
import 'package:flutter_grains_app/screens/home/bloc/home_bloc.dart';
import 'package:flutter_grains_app/utils/constants.dart';
import 'package:flutter_grains_app/utils/text_constant.dart';

const SCALE_FRACTION = 0.7;
const FULL_SCALE = 1.0;

class GrainsPager extends StatelessWidget {
  GrainsPager()
      : pageController = PageController(initialPage: 0, viewportFraction: 0.5),
        grainList = listOfGrains;

  final List<GrainsModel> grainList;
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
        _labelText(context),
        _seeMoreLabel(context),
      ],
    );
  }

  Widget _seeMoreLabel(BuildContext context) {
    return Text(
      SEE_STORY_LABEL,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .subtitle
          .copyWith(color: Colors.deepOrange, fontWeight: FontWeight.w500),
    );
  }

  Widget _pager(BuildContext context) {
    final bloc = BaseBlocProvider.of<HomeBloc>(context);
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * 0.3,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollUpdateNotification) {
            bloc.focusedGrainPageSink.add(pageController.page);
          }
        },
        child: StreamBuilder<double>(
            stream: bloc.focusedGrainPageStream,
            builder:
                (BuildContext buildContext, AsyncSnapshot<double> snapshot) {
              double pageOffset = snapshot.hasData ? snapshot.data : 0.0;
              return PageView.builder(
                onPageChanged: (pos) {
                  bloc.focusedGrainSink.add(grainList[pos]);
                },
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemCount: grainList.length,
                itemBuilder: (context, index) {
                  final scale = max(SCALE_FRACTION,
                      (FULL_SCALE - (index - pageOffset).abs()) + 0.5);
                  return circleImage(
                      grainList.elementAt(index).grainImage, scale);
                },
              );
            }),
      ),
    );
  }

  Widget _labelText(BuildContext context) {
    final bloc = BaseBlocProvider.of<HomeBloc>(context);
    return StreamBuilder<GrainsModel>(
        stream: bloc.focusedGrainStream,
        builder:
            (BuildContext buildContext, AsyncSnapshot<GrainsModel> snapshot) {
          String name = snapshot.hasData
              ? snapshot.data.grainName
              : grainList[0].grainName;
          return Text(
            name,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
          );
        });
  }

  Widget circleImage(String image, double scale) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CircularImageCard(image: image, scale: scale),
    );
  }
}
