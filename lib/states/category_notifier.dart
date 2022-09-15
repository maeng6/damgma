import 'package:dangma/screens/input/category_input_screen.dart';
import 'package:flutter/material.dart';

CategoryNotifier categoryNotifier = CategoryNotifier();

class CategoryNotifier extends ChangeNotifier{

  String _selectedCategoryInEng = 'none';

  String get currenCategoryInEng => _selectedCategoryInEng;
  String get currenCategoryInKor => categoriesEngToKor[_selectedCategoryInEng]!;

  void setNewCategoryWithEng(String newCategory){
    if(categoriesEngToKor.keys.contains(newCategory)){
      _selectedCategoryInEng = newCategory;
      notifyListeners();
    }
  }

  void setNewCategoryWithKor(String newCategory){
    if(categoriesKorToEng.keys.contains(newCategory)){
      _selectedCategoryInEng = categoriesKorToEng[newCategory]!;
      notifyListeners();
    }
  }
}

const Map<String, String> categoriesEngToKor = {
  'none':'선택',
  'furniture':'가구',
  'electronics':'전자기기',
  'kids':'유아동',
  'sports':'스포츠',
  'woman':'여성',
  'man':'남성',
  'makeup':'메이크업',
  'snowboard':'스노우보드'
};

const Map<String, String> categoriesKorToEng = {
  '선택':'none',
  '가구':'furniture',
  '전자기기':'electronics',
  '유아동':'kids',
  '스포츠':'sports',
  '여성':'woman',
  '남성':'man',
  '메이크업':'makeup',
  '스노우보드':'snowboard'
};