import 'package:flutter_grains_app/model/grain_model.dart';
import 'package:meta/meta.dart';

class SetCartListAction {
    SetCartListAction({@required this.itemList});
    final Map<GrainsModel, int> itemList;
}
