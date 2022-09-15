import 'package:beamer/beamer.dart';
import 'package:dangma/states/category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryInputScreen extends StatelessWidget {
  const CategoryInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('카테고리 선택',
        style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index){
            return ListTile(
              onTap: (){
                context.read<CategoryNotifier>()
                    .setNewCategoryWithKor(categoriesEngToKor.values.elementAt(index));
                print(categoriesEngToKor.values.elementAt(index));
                Beamer.of(context).beamBack();
              },
              title: Text(categoriesEngToKor.values.elementAt(index),
              style: TextStyle(
                color: context.read<CategoryNotifier>()
                    .currenCategoryInKor==categoriesEngToKor
                    .values.elementAt(index)
                    ?Theme.of(context).primaryColor
                    :Colors.black87
              ),
              ),
              );
          },
          separatorBuilder: (context, index){
            return Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
            );
          },
          itemCount: categoriesKor.length
      )
    );
  }
}

const List<String> categoriesKor = [
  '선택',
  '가구',
  '전자기기',
  '유아동',
  '스포츠',
  '여성',
  '남성',
  '메이크업',
  '스노우보드'
];