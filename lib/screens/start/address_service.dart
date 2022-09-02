import 'package:dangma/data/Address_Model.dart';
import 'package:dio/dio.dart';
import '../../constraints/keys.dart';
import '../../data/Address_Model2.dart';
import '../../utils/logger.dart';

class AddressService{
  
  Future<AddressModel> searchAddressByStr(String text) async{

    final formData = {
      'key' : VWORLD_KEY,
      'request' : 'search',
      'type' : 'ADDRESS',
      'category' : 'ROAD',
      'query' : text,
      'size' : 30,
    };

    final response = await Dio()
        .get('http://api.vworld.kr/req/search',queryParameters: formData)
        .catchError((e){
    });

    AddressModel addressModel = AddressModel.fromJson(response.data['response']);
    logger.d(addressModel);
    return addressModel;
  }

  Future<List<AddressModel2>> findAddressBycoordinate({required lon,required lat}) async{

    final List<Map<String, dynamic>> formDatas = <Map<String, dynamic>>[];

    formDatas.add( {
      'key' : VWORLD_KEY,
      'service':'address',
      'request' : 'GetAddress',
      'type':'PARCEL',
      'point' : '${lon},${lat}'
    });
    formDatas.add( {
      'key' : VWORLD_KEY,
      'service':'address',
      'request' : 'GetAddress',
      'type':'PARCEL',
      'point' : '${lon-0.01},${lat}'
    });
    formDatas.add( {
      'key' : VWORLD_KEY,
      'service':'address',
      'request' : 'GetAddress',
      'type':'PARCEL',
      'point' : '${lon+0.01},${lat}'
    });
    formDatas.add( {
      'key' : VWORLD_KEY,
      'service':'address',
      'request' : 'GetAddress',
      'type':'PARCEL',
      'point' : '${lon},${lat-0.01}'
    });
    formDatas.add( {
      'key' : VWORLD_KEY,
      'service':'address',
      'request' : 'GetAddress',
      'type':'PARCEL',
      'point' : '${lon},${lat+0.01}'
    });

    List<AddressModel2> addresses = [];

    for(Map<String,dynamic> formData in formDatas){
      final response = await Dio()
          .get('http://api.vworld.kr/req/address',queryParameters: formData)
          .catchError((e){
      });

      AddressModel2 addressModel = AddressModel2.fromJson(response.data['response']);

      if(addressModel.status =='OK')
      addresses.add(addressModel);

    }

    return addresses;
  }
}

