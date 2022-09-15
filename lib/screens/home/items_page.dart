import 'package:dangma/constraints/common_size.dart';
import 'package:dangma/data/item_model.dart';
import 'package:dangma/repo/user_service.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../repo/item_service.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        final imgSize = size.width / 4;
        return FutureBuilder<List<ItemModel>>(
          future: ItemService().getItems(),
          builder: (context, snapshot) {
            return AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: (snapshot.hasData && snapshot.data!.isNotEmpty)
                    ? _listView(imgSize,snapshot.data!)
                    : _shimmerlistView(imgSize));
          },
        );
      },
    );
  }

  ListView _listView(double imgSize,List<ItemModel> items) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            height: common_padding * 2,
            thickness: 1,
            color: Colors.grey[250],
          );
        },
        padding: EdgeInsets.all(common_padding),
        itemCount: items.length,
        itemBuilder: (context, index) {
          ItemModel item = items[index];
          return InkWell(
            onTap: () {},
            child: SizedBox(
              height: imgSize,
              child: Row(
                children: [
                  SizedBox(
                    height: imgSize,
                    width: imgSize,
                    child: ExtendedImage.network(
                      items[index].imageDownLoadUrls[0],
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  SizedBox(
                    width: common_sm_padding,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        '53일전',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text('${item.price.toString()}원'),
                      Expanded(child: Container()),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        SizedBox(
                          height: 14,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.chat_bubble_2,
                                  color: Colors.grey,
                                ),
                                Text(
                                  '23',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Icon(
                                  CupertinoIcons.heart,
                                  color: Colors.grey,
                                ),
                                Text(
                                  '30',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ])
                    ],
                  ))
                ],
              ),
            ),
          );
        });
  }

  Widget _shimmerlistView(double imgSize) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              height: common_padding * 2,
              thickness: 1,
              color: Colors.white,
            );
          },
          padding: EdgeInsets.all(common_padding),
          itemCount: 10,
          itemBuilder: (context, index) {
            return SizedBox(
              height: imgSize,
              child: Row(
                children: [
                  Container(
                    height: imgSize,
                    width: imgSize,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  SizedBox(
                    width: common_sm_padding,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        height: 12,
                        width: 180,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        height: 14,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      Expanded(child: Container()),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Container(
                            height: 14,
                            width: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3))),
                      ])
                    ],
                  ))
                ],
              ),
            );
          }),
    );
  }
}
