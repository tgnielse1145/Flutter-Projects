import 'package:scoped_model/scoped_model.dart';

class DeliveryLocation extends Model {
  bool address = false;
  bool coupon = true;
  int clicks = 1;

  bool confirmAddress() {
    address = true;
    clicks++;
    notifyListeners();
    return address;
  }

  bool removeCoupon() {
    coupon = false;
    notifyListeners();
    return coupon;
  }
}

DeliveryLocation deliveryLocation = DeliveryLocation();
