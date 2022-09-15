import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageNotifier extends ChangeNotifier{
  List<Uint8List> _images = [];

  Future setNewImages(List<XFile>? newImages) async{
    if(newImages != null && newImages.isNotEmpty){
      _images.clear();
      // newImages.forEach((xfile) async {
      //   _images.add(await xfile.readAsBytes());
      // });
      //
      for(int index=0; index < newImages.length;index++){
        _images.add(await newImages[index].readAsBytes());
        print('_images.add(await xfile.readAsBytes());');
      }
      print('setNewUmages notifyListners!');
      notifyListeners();
    }
  }

  void removeImage(int index){
    if(_images.length >= index){
      _images.removeAt(index);
      notifyListeners();
    }
  }

  List<Uint8List> get images => _images;
}