import 'package:dangma/data/AddressModel.dart';
import 'package:dio/dio.dart';
import '../../constraints/keys.dart';
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
  
}