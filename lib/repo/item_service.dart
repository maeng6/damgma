import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangma/constraints/data_keys.dart';
import 'package:dangma/data/item_model.dart';

class ItemService {
  static final ItemService _itemService = ItemService._internal();
  factory ItemService() => _itemService;
  ItemService._internal();

  Future createNewItem(
      ItemModel itemModel,
      String itemKey,
      String userKey) async {
    DocumentReference<Map<String, dynamic>> itemDocReference =
    FirebaseFirestore.instance.collection(COL_ITEMS).doc(itemKey);
    DocumentReference<Map<String, dynamic>> userItemDocReference =
    FirebaseFirestore.instance.collection(COL_USERS).doc(userKey).collection(COL_USER_ITEMS).doc(itemKey);
    final DocumentSnapshot documentSnapshot = await itemDocReference.get();

    if(!documentSnapshot.exists){
     await FirebaseFirestore.instance.runTransaction((transaction) async{
        transaction.set(itemDocReference, itemModel.toJson());
        transaction.set(userItemDocReference, itemModel.toMinJson());
      });
    }
  }

  Future<ItemModel> getItem(String itemKey) async {
    print(itemKey);
    DocumentReference<Map<String, dynamic>> documentReference =
    FirebaseFirestore.instance.collection(COL_ITEMS).doc(itemKey);
    print(documentReference);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentReference.get();
    print(documentSnapshot.data());
    ItemModel itemModel = ItemModel.fromSnapshot(documentSnapshot);
    return itemModel;
  }

  Future<List<ItemModel>> getItems() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
    FirebaseFirestore.instance.collection(COL_ITEMS);
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await collectionReference.get();

    List<ItemModel> items = [];

    for(int i = 0; i<snapshot.size; i++){
      ItemModel itemModel = ItemModel.fromQuerySnapshot(snapshot.docs[i]);
      items.add(itemModel);
    }

    return items;
  }

  Future<List<ItemModel>> getUserItems(String userKey, {String? itemKey}) async {
    CollectionReference<Map<String, dynamic>> collectionReference =
    FirebaseFirestore.instance.collection(COL_USERS).doc(userKey).collection(COL_USER_ITEMS);
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await collectionReference.get();

    List<ItemModel> items = [];

    for(int i = 0; i<snapshot.size; i++){
      ItemModel itemModel = ItemModel.fromQuerySnapshot(snapshot.docs[i]);
      if(!(itemKey!= null && itemKey == itemModel.itemKey))
      items.add(itemModel);
    }

    return items;
  }
}