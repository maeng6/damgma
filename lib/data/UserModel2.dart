/// userKey : "userKey"
/// phoneNumber : "phoneNumber"
/// address : "address"
/// lat : 123
/// lon : 123
/// geoFirePoint : "geoFirePoint"
/// createdDate : "createdDate"
/// reference : "reference"

class UserModelTemp {
  UserModelTemp({
      this.userKey, 
      this.phoneNumber, 
      this.address, 
      this.lat, 
      this.lon, 
      this.geoFirePoint, 
      this.createdDate, 
      this.reference,});

  UserModelTemp.fromJson(dynamic json) {
    userKey = json['userKey'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    lat = json['lat'];
    lon = json['lon'];
    geoFirePoint = json['geoFirePoint'];
    createdDate = json['createdDate'];
    reference = json['reference'];
  }
  String? userKey;
  String? phoneNumber;
  String? address;
  num? lat;
  num? lon;
  String? geoFirePoint;
  String? createdDate;
  String? reference;
UserModelTemp copyWith({  String? userKey,
  String? phoneNumber,
  String? address,
  num? lat,
  num? lon,
  String? geoFirePoint,
  String? createdDate,
  String? reference,
}) => UserModelTemp(  userKey: userKey ?? this.userKey,
  phoneNumber: phoneNumber ?? this.phoneNumber,
  address: address ?? this.address,
  lat: lat ?? this.lat,
  lon: lon ?? this.lon,
  geoFirePoint: geoFirePoint ?? this.geoFirePoint,
  createdDate: createdDate ?? this.createdDate,
  reference: reference ?? this.reference,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userKey'] = userKey;
    map['phoneNumber'] = phoneNumber;
    map['address'] = address;
    map['lat'] = lat;
    map['lon'] = lon;
    map['geoFirePoint'] = geoFirePoint;
    map['createdDate'] = createdDate;
    map['reference'] = reference;
    return map;
  }

}