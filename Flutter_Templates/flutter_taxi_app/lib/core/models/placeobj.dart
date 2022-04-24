class FarPlaceObj {
  int id;
  String name;
  String address;
  double lng;
  double lat;
  int type;
  int customerid;

  FarPlaceObj(
      {this.id,
        this.name,
        this.address,
        this.lng,
        this.lat,
        this.type,
        this.customerid});

  FarPlaceObj.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    lng = json['lng'];
    lat = json['lat'];
    type = json['type'];
    customerid = json['customerid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['type'] = this.type;
    data['customerid'] = this.customerid;
    return data;
  }
}
