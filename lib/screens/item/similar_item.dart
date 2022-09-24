import 'package:dangma/constraints/common_size.dart';
import 'package:dangma/data/item_model.dart';
import 'package:dangma/screens/item/item_detail_screen.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class SimilarItem extends StatelessWidget {
  final ItemModel _itemModel;
  const SimilarItem(this._itemModel,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return ItemDetailScreen(_itemModel.itemKey);
        }));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AspectRatio(
            aspectRatio: 5/4,
            child: ExtendedImage.network(
              _itemModel.imageDownLoadUrls[0],
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle, //이걸 해야 보더 서큘러가 먹음
            ),
          ),
          Text(_itemModel.title,
            overflow: TextOverflow.ellipsis,
          maxLines: 1,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: common_sm_padding),
            child: Text('${_itemModel.price.toString()}원',
              style: Theme.of(context).textTheme.subtitle2,),
          ),
        ],
      ),
    );
  }
}
