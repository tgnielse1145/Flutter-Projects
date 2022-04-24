import 'package:uguard_app/models/nearby_available_contacts.dart';

class NearbyAvailableContactsController{
static List<NearbyAvailableContacts> nearByAvailableContactsList = [];

  static void removeContactFromList(String key)
  {
    int index = nearByAvailableContactsList.indexWhere((element) => element.key == key);
    print("HERE IS INT INDEX "+ index.toString());
    nearByAvailableContactsList.removeAt(index);
  }

  static void updateContactNearbyLocation(NearbyAvailableContacts contacts)
  {
    int index = nearByAvailableContactsList.indexWhere((element) => element.key == contacts.key);

    nearByAvailableContactsList[index].latitude = contacts.latitude;
    nearByAvailableContactsList[index].longitude = contacts.longitude;
  }
}