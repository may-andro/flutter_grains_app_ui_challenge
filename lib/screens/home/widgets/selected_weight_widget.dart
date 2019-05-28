import 'package:flutter/material.dart';
import 'package:flutter_grains_app/base_bloc/base_bloc_provider.dart';
import 'package:flutter_grains_app/common_component/polygon_clipper/polygon_border.dart';
import 'package:flutter_grains_app/screens/home/bloc/home_bloc.dart';
import 'package:flutter_grains_app/utils/color_utility.dart';
import 'package:flutter_grains_app/utils/text_constant.dart';

class SelectedWeightWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: _buildDataColumn(context),
    );
  }

  Widget _buildDataColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        _labelText(context),
        Expanded(flex: 1, child: _buildWeightRow(context))
      ],
    );
  }

  Widget _buildWeightRow(BuildContext context) {
    return Row(
      children: <Widget>[
        _weightBarContainer(context, 0.04, 5, 0.04),
        _weightBarContainer(context, 0.03, 10, 0.022),
        _weightBarContainer(context, 0.02, 15, 0.03),
      ],
    );
  }

  Widget _weightBarContainer(
      BuildContext context, double scale, int weight, double childScale) {
    final bloc = BaseBlocProvider.of<HomeBloc>(context);
    return Expanded(
      flex: 1,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if(bloc.selectedList.containsKey(bloc.focusedGrainsModel)) {
              return null;
            }
            bloc.selectedWeightSink.add(weight);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: _columnWeightBar(context, scale, weight, childScale),
          ),
        ),
      ),
    );
  }

  Widget _columnWeightBar(
      BuildContext context, double scale, int weight, double childScale) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _weightBar(context, scale, childScale, weight),
        _weightText(context, '$weight Kg')
      ],
    );
  }

  Widget _weightText(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .subtitle
            .copyWith(color: Colors.black87, fontWeight: FontWeight.w700),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _weightBar(BuildContext context, double scale, double childScale, int weight) {
    final bloc = BaseBlocProvider.of<HomeBloc>(context);
    return StreamBuilder<int>(
        stream: bloc.selectedWeightStream,
        builder: (BuildContext buildContext, AsyncSnapshot<int> snapshot) {
          int selectedWeight = snapshot.hasData ? snapshot.data : 5;
          return Expanded(
              flex: 1,
              child: _hexagonWeightBar(context, scale, childScale, selectedWeight == weight)
          );
        });
  }

  Widget _hexagonWeightBar(
      BuildContext context,
      double scale,
      double childScale,
      bool isSelected
      ) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(
          top: 2 * MediaQuery.of(context).size.width * scale,
          left: MediaQuery.of(context).size.width * scale,
          right: MediaQuery.of(context).size.width * scale),
      decoration: ShapeDecoration(
          color: Color(isSelected ? getColorHexFromStr(PRIMARY_COLOR): getColorHexFromStr(DISABLED_GREY)),
          shape: PolygonBorder(
            sides: 6,
            borderRadius: 4.0,
          )),
      child: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        decoration: ShapeDecoration(
          shape: CircleBorder(),
          color: Colors.white,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * (0.05),
              vertical: MediaQuery.of(context).size.width * (childScale)),
          color: Color(isSelected ? getColorHexFromStr(PRIMARY_COLOR): getColorHexFromStr(DISABLED_GREY)),
        ),
      ),
    );
  }

  Widget _labelText(BuildContext context) {
    return Text(
      SELECT_SIZE_LABEL,
      style: Theme.of(context)
          .textTheme
          .subtitle
          .copyWith(color: Colors.black87, fontWeight: FontWeight.w700),
      textAlign: TextAlign.left,
    );
  }
}
