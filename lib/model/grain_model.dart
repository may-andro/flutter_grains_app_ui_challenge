import 'package:meta/meta.dart';

class GrainsModel {
    GrainsModel({
        @required this.grainImage,
        @required this.grainName,
        @required this.id,
        @required this.weight
    });

    final String grainImage;
    final String grainName;
    final int id;
    int weight;
}
