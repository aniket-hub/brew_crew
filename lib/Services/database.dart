import 'package:brew_crew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService{
  final String uid;
  DataBaseService({this.uid});
  //collection reference
  final CollectionReference brewCollection=Firestore.instance.collection('brews');
  Future updateUserData(String sugar, String name, int data)async{
    return await brewCollection.document(uid).setData(
      {
        'sugars':sugar,
        'name':name,
        'data':data
      }
    );
  }
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name:doc.data['name']??'',
        sugars: doc.data['sugars']??'',
        strength: doc.data['strength']??0,
      );

    }).toList();
  }
  Stream<QuerySnapshot> get brews{
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);
  }
}