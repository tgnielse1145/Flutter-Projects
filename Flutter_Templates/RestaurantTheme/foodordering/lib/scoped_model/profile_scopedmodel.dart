import 'package:scoped_model/scoped_model.dart';

class ProfileScopedModel extends Model {
  bool edit = true;
  bool editProfile() {
    edit = !edit;
    notifyListeners();
    return edit;
  }
}

ProfileScopedModel profileScopedModel = ProfileScopedModel();
