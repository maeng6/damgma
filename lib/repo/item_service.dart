import 'package:cloud_firestore/cloud_firestore.dart';

import '../constraints/data_keys.dart';
import '../data/item_model.dart';

class ItemService{
  static final ItemService _itemService = ItemService._internal();
  factory ItemService() => _itemService;
  ItemService._internal();

  Future createNewItem(Map<String, dynamic> json, String itemKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
    FirebaseFirestore.instance.collection(COL_ITEMS).doc(itemKey);
    final DocumentSnapshot documentSnapshot = await documentReference.get();

    if(!documentSnapshot.exists){
      await documentReference.set(json);
    }
  }

  Future<List<ItemModel>> getItems() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
    FirebaseFirestore.instance.collection(COL_ITEMS);
    QuerySnapshot<Map<String, dynamic>> snapshots =
    await collectionReference.get();

    List<ItemModel> items = [];

    for(int i=0; i<snapshots.size;i++){
      ItemModel itemModel = ItemModel.fromQuerySnapshot(snapshots.docs[i]);
      items.add(itemModel);
    }
    return items;
  }

}