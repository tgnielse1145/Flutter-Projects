class Geoobj {
  String status;
  PlusCodeBean plusCode;
  List<ResultsListBean> results;

  Geoobj({this.status, this.plusCode, this.results});

  Geoobj.fromJson(Map<String, dynamic> json) {
    this.status = json['status'];
    this.plusCode = json['plus_code'] != null ? PlusCodeBean.fromJson(json['plus_code']) : null;
    this.results = (json['results'] as List)!=null?(json['results'] as List).map((i) => ResultsListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.plusCode != null) {
      data['plus_code'] = this.plusCode.toJson();
    }
    data['results'] = this.results != null?this.results.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class PlusCodeBean {
  String compoundCode;
  String globalCode;

  PlusCodeBean({this.compoundCode, this.globalCode});

  PlusCodeBean.fromJson(Map<String, dynamic> json) {
    this.compoundCode = json['compound_code'];
    this.globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compound_code'] = this.compoundCode;
    data['global_code'] = this.globalCode;
    return data;
  }
}

class ResultsListBean {
  String formattedAddress;
  String placeId;
  GeometryBean geometry;
  PlusCodeBean plusCode;
  List<String> types;
  List<AddressComponentsListBean> addressComponents;

  ResultsListBean({this.formattedAddress, this.placeId, this.geometry, this.plusCode, this.addressComponents, this.types});

  ResultsListBean.fromJson(Map<String, dynamic> json) {
    this.formattedAddress = json['formatted_address'];
    this.placeId = json['place_id'];
    this.geometry = json['geometry'] != null ? GeometryBean.fromJson(json['geometry']) : null;
    this.plusCode = json['plus_code'] != null ? PlusCodeBean.fromJson(json['plus_code']) : null;
    this.addressComponents = (json['address_components'] as List)!=null?(json['address_components'] as List).map((i) => AddressComponentsListBean.fromJson(i)).toList():null;

    List<dynamic> typesList = json['types'];
    this.types = new List();
    this.types.addAll(typesList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formatted_address'] = this.formattedAddress;
    data['place_id'] = this.placeId;
    if (this.geometry != null) {
      data['geometry'] = this.geometry.toJson();
    }
    if (this.plusCode != null) {
      data['plus_code'] = this.plusCode.toJson();
    }
    data['address_components'] = this.addressComponents != null?this.addressComponents.map((i) => i.toJson()).toList():null;
    data['types'] = this.types;
    return data;
  }
}

class GeometryBean {
  String locationType;
  LocationBean location;
  ViewportBean viewport;

  GeometryBean({this.locationType, this.location, this.viewport});

  GeometryBean.fromJson(Map<String, dynamic> json) {
    this.locationType = json['location_type'];
    this.location = json['location'] != null ? LocationBean.fromJson(json['location']) : null;
    this.viewport = json['viewport'] != null ? ViewportBean.fromJson(json['viewport']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_type'] = this.locationType;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.viewport != null) {
      data['viewport'] = this.viewport.toJson();
    }
    return data;
  }
}

class AddressComponentsListBean {
  String longName;
  String shortName;
  List<String> types;

  AddressComponentsListBean({this.longName, this.shortName, this.types});

  AddressComponentsListBean.fromJson(Map<String, dynamic> json) {
    this.longName = json['long_name'];
    this.shortName = json['short_name'];

    List<dynamic> typesList = json['types'];
    this.types = new List();
    this.types.addAll(typesList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long_name'] = this.longName;
    data['short_name'] = this.shortName;
    data['types'] = this.types;
    return data;
  }
}

class LocationBean {
  double lat;
  double lng;

  LocationBean({this.lat, this.lng});

  LocationBean.fromJson(Map<String, dynamic> json) {
    this.lat = json['lat'];
    this.lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class ViewportBean {
  NortheastBean northeast;
  SouthwestBean southwest;

  ViewportBean({this.northeast, this.southwest});

  ViewportBean.fromJson(Map<String, dynamic> json) {
    this.northeast = json['northeast'] != null ? NortheastBean.fromJson(json['northeast']) : null;
    this.southwest = json['southwest'] != null ? SouthwestBean.fromJson(json['southwest']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.northeast != null) {
      data['northeast'] = this.northeast.toJson();
    }
    if (this.southwest != null) {
      data['southwest'] = this.southwest.toJson();
    }
    return data;
  }
}

class NortheastBean {
  double lat;
  double lng;

  NortheastBean({this.lat, this.lng});

  NortheastBean.fromJson(Map<String, dynamic> json) {
    this.lat = json['lat'];
    this.lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class SouthwestBean {
  double lat;
  double lng;

  SouthwestBean({this.lat, this.lng});

  SouthwestBean.fromJson(Map<String, dynamic> json) {
    this.lat = json['lat'];
    this.lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
