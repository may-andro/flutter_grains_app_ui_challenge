import 'package:flutter/material.dart';
import 'package:flutter_grains_app/common_component/title_widget.dart';
import 'package:flutter_grains_app/model/grain_model.dart';
import 'package:flutter_grains_app/redux/state/app_state.dart';
import 'package:flutter_grains_app/screens/checkout/model/payment_card_model.dart';
import 'package:flutter_grains_app/screens/checkout/widgets/button_container_widget.dart';
import 'package:flutter_grains_app/screens/checkout/widgets/checkedout_item_pager_widget.dart';
import 'package:flutter_grains_app/utils/constants.dart';
import 'package:flutter_grains_app/utils/text_constant.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AnimationController animationController;
  List<PaymentCardModel<dynamic>> paymentCardModelList;
  Duration _duration = Duration(milliseconds: 300);
  CartCheckoutEnterAnimation cartCheckoutEnterAnimation;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    cartCheckoutEnterAnimation = CartCheckoutEnterAnimation(animationController);
    animationController.forward();
    paymentCardModelList = listOfCards;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CartViewModel>(
        converter: (Store<AppState> store) => CartViewModel.fromStore(store),
        builder: (BuildContext context, CartViewModel viewModel) {
          return AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context, Widget child) {
                return Scaffold(
                  key: _scaffoldKey,
                  body: _buildBody(viewModel),
                );
              });
        });
  }

  _buildBody(CartViewModel viewModel) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Stack(fit: StackFit.expand, children: <Widget>[
          _buildPaymentMethodsContainer(viewModel),
          _buildButtonsContainer()
        ]),
      ),
    );
  }

  _buildPaymentMethodsContainer(CartViewModel viewModel) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: MediaQuery.of(context).size.height * 0.1,
      child: _expandablePaymentListContainer(viewModel),
    );
  }

  Widget _expandablePaymentListContainer(CartViewModel viewModel) {
    /*return ListViewEffect(duration: _duration, children: [
      TitleWidget(label: CHECKOUT_TITLE),
      CartGrainsPager(grainList: viewModel.list),
      _expnadableListView(),
      _addMoreButton(),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
      )
    ]);*/

    return ListView(
      children: <Widget>[
        TitleWidget(label: CHECKOUT_TITLE),
        CartGrainsPager(grainList: viewModel.list),
        _expnadableListView(),
        _addMoreButton(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        )
      ],
    );
  }

  Widget _addMoreButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.075),
      child: SlideTransition(
        position: cartCheckoutEnterAnimation.addButtonOffset,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                side: BorderSide(
                    color: Colors.deepOrange,
                    width: 1,
                    style: BorderStyle.solid)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.add),
                Text(
                  "Add New",
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _expnadableListView() {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.075),
      child: SlideTransition(
        position: cartCheckoutEnterAnimation.expandableListOffset,
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              paymentCardModelList[index].isExpanded = !isExpanded;
            });
          },
          children: paymentCardModelList
              .map<ExpansionPanel>((PaymentCardModel<dynamic> item) {
            return ExpansionPanel(
              isExpanded: item.isExpanded,
              headerBuilder: item.headerBuilder,
              body: item.build(),
            );
          }).toList(),
        ),
      ),
    );
  }

  void close(PaymentCardModel<String> item) {
    setState(() {
      item.isExpanded = false;
    });
  }

  Widget _buildButtonsContainer() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: CheckoutButtonContainer(),
    );
  }
}

class CartViewModel {
  final Map<GrainsModel, int> list;

  CartViewModel({
    @required this.list,
  });

  static CartViewModel fromStore(Store<AppState> store) {
    return CartViewModel(list: store.state.cartList);
  }
}

class CartCheckoutEnterAnimation {
  CartCheckoutEnterAnimation(this.controller)
      : expandableListOffset =
            Tween<Offset>(begin: Offset(0, 300), end: Offset(0, 0)).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0,
              0.5,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        addButtonOffset =
            Tween<Offset>(begin: Offset(0, 300), end: Offset(0, 0)).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.3,
              1,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        );

  final AnimationController controller;
  final Animation<Offset> expandableListOffset;
  final Animation<Offset> addButtonOffset;
}
