import 'dart:async';
import 'dart:collection';
import 'package:flutter_grains_app/base_bloc/base_bloc_provider.dart';
import 'package:flutter_grains_app/model/grain_model.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc implements BlocBase {

    int cartCount = 0;
    int selectedWeight;
    GrainsModel focusedGrainsModel;
    Map<GrainsModel, int> selectedList = HashMap();

    final _addToCartBehaviorSubject = BehaviorSubject<int>();
    // retrieve cart count stream
    Stream<int> get addToCartStream => _addToCartBehaviorSubject.stream;
    // add cart count to stream
    Sink<int> get addToCartSink => _addToCartBehaviorSubject.sink;

    final _focusedGrainBehaviorSubject = BehaviorSubject<GrainsModel>();
    // retrieve focused grain stream
    Stream<GrainsModel> get focusedGrainStream =>
        _focusedGrainBehaviorSubject.stream;
    // add focused grain to stream
    Sink<GrainsModel> get focusedGrainSink => _focusedGrainBehaviorSubject.sink;

    final _focusedGrainPageBehaviorSubject = BehaviorSubject<double>();
    // retrieve focused grain stream
    Stream<double> get focusedGrainPageStream =>
        _focusedGrainPageBehaviorSubject.stream;
    // add focused grain to stream
    Sink<double> get focusedGrainPageSink =>
        _focusedGrainPageBehaviorSubject.sink;

    final _selectedItemBehaviorSubject = BehaviorSubject<Map<GrainsModel, int>>();
    // retrieve cart count stream
    Stream<Map<GrainsModel, int>> get selectedItemStream =>
        _selectedItemBehaviorSubject.stream;
    // add cart count to stream
    Sink<Map<GrainsModel, int>> get selectedItemSink =>
        _selectedItemBehaviorSubject.sink;


    final _addToCartButtonLabelBehaviorSubject = BehaviorSubject<int>();
    // retrieve label stream
    Stream<int> get addToCartButtonLabelStream => _addToCartButtonLabelBehaviorSubject.stream;
    // add label to stream
    Sink<int> get addToCartButtonLabelSink => _addToCartButtonLabelBehaviorSubject.sink;

    final _selectedWeightBehaviorSubject = BehaviorSubject<int>();
    // retrieve label stream
    Stream<int> get selectedWeightStream => _selectedWeightBehaviorSubject.stream;
    // add label to stream
    Sink<int> get selectedWeightSink => _selectedWeightBehaviorSubject.sink;


    HomeBloc() {
        addToCartStream.listen(_addToCart);
        focusedGrainStream.listen(_setFocusedGrainModel);
        selectedWeightStream.listen(_setSelectedWeight);
        addToCartButtonLabelSink.add(0);
    }

    @override
    void dispose() {
        _addToCartBehaviorSubject.close();
        _focusedGrainBehaviorSubject.close();
        _focusedGrainPageBehaviorSubject.close();
        _selectedItemBehaviorSubject.close();
        _addToCartButtonLabelBehaviorSubject.close();
        _selectedWeightBehaviorSubject.close();
    }

    _addToCart(int eventWeight) {
        if(selectedList.containsKey(focusedGrainsModel)) {
            selectedList.remove(focusedGrainsModel);
        } else {
            selectedList.putIfAbsent(focusedGrainsModel, () => eventWeight);
        }
        _setAddToCartLabel();
        selectedItemSink.add(selectedList);
    }

    _setFocusedGrainModel(GrainsModel event) {
        focusedGrainsModel = event;
        setSelectedGrainModelWeightIfExists();
        _setAddToCartLabel();
    }

    _setAddToCartLabel() {
        if(selectedList.containsKey(focusedGrainsModel)) {
            addToCartButtonLabelSink.add(1);
        } else {
            addToCartButtonLabelSink.add(0);
        }
    }

    setSelectedGrainModelWeightIfExists() {
        if(selectedList.containsKey(focusedGrainsModel)) {
            selectedWeightSink.add(selectedList[focusedGrainsModel]);
        } else {
            selectedWeightSink.add(5);
        }
    }

    _setSelectedWeight(int event) {
        selectedWeight = event;
    }
}