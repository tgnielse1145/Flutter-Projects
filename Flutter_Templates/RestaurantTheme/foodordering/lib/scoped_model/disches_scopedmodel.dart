import 'package:foodordering/utils/constants/string_names.dart';
import 'package:scoped_model/scoped_model.dart';

class DisheScopedModel extends Model {
  bool color = true;
  List item = [
    [StringNames.RECOMMENDED, '20', true],
    [StringNames.SOUTH_INDIAN, '40', true],
    [StringNames.COMBO, '1', true],
    [StringNames.DESERTS, '2', true],
    [StringNames.QUICK_BITES, '15', true],
    [StringNames.SOUPS, '9', true],
    [StringNames.STARTERS, '8', true],
    [StringNames.SALAD, '8', true]
  ];
  bool colorStatus(String dishName) {
    print(dishName);
    // if (item[]){}
    color = !color;
    notifyListeners();
    return color;
  }
}

DisheScopedModel disheScopedModel = DisheScopedModel();
