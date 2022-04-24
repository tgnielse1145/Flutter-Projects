import 'package:scoped_model/scoped_model.dart';

class PaymentScopedModel extends Model {
  bool value = true;
  double opacity = 1;
  bool changedValue() {
    value = !value;
    notifyListeners();
    return value;
  }

  double changeOpacity() {
    if (opacity == 1) {
      opacity = .3;
    } else {
      opacity = 1;
    }
    notifyListeners();
    return opacity;
  }
}

PaymentScopedModel paymentScopedModel = PaymentScopedModel();
