import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fregies/models/product_model.dart';
import 'package:image_picker/image_picker.dart';

class ProductNotifier extends ChangeNotifier {
  ProductNotifier() {
    init();
  }

  List _productList = [];
  UnmodifiableListView get productList => UnmodifiableListView(_productList);

  Future<void> init() async {
    print("this is from the product provider init");
    await Firebase.initializeApp();
    // final FirebaseFirestore _db = FirebaseFirestore.instance;
    // QuerySnapshot querySnapshot = await _db.collection("products").get();
    // final allData = querySnapshot.docs.map((e) => e.data()).toList();
    // _productList = allData;

    notifyListeners();
  }

  void addProduct(ProductModel data, pickedFile, Function callback) async {
    ///////////////////////////////////////handle image download url
    final path = "products/${pickedFile!.name}";
    final file = File(pickedFile.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(
        file,
        SettableMetadata(customMetadata: {
          'uploaded_by': 'admin',
          'description': 'this section is not important'
        }));
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    //////////////////////////////////handle data to be submitted

    Map<String, dynamic> data2 = <String, dynamic>{
      "id": data.id,
      "product": data.product,
      "category": data.category,
      "price": data.price,
      "discountPrice": data.discountPrice,
      "favourite": data.favourite,
      "image": urlDownload,
      "rating": data.rating,
      "quantity": data.quantity,
      "discription": data.discription,
      "unit": data.unit,
      "rate": data.rate,
      "specialOffer": data.specialOffer,
      "date": DateTime.now(),
    };

    //////////////////////////////////handle data to be handle submission

    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference documentReferencer = _db.collection('products').doc();
    await documentReferencer.set(data2).whenComplete(() {
      callback(true);
      fetchDoc();
      notifyListeners();
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> fetchDoc() async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _db.collection("products").get();

    final allData = querySnapshot.docs.map((e) => e.data()).toList();
    // final allData2 = querySnapshot.docs.map((e) => e.id).toList().first;
    //to get the UID

    print(allData);
    _productList = allData;
    notifyListeners();
    print("submitted.... now fetchu=ing");
  }

  Future deleteProduct(int id) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _db.collection("products").get();
    final documentID = querySnapshot.docs.map((e) => e.id).toList()[id];
    print("from the delete product provider" + documentID);

    await _db
        .collection("products")
        .doc(documentID)
        .delete()
        .then((value) => print("deleted"))
        .catchError((error) => print("deletion faiild: $error"));
  }

  void updateProduct(
      ProductModel data, int index, pickedFile, Function callback) async {
    //this is to retrive the documument ID
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _db.collection("products").get();
    final documentID = querySnapshot.docs.map((e) => e.id).toList()[index];
    print("from the delete product provider" + documentID);

    var urlDownload = "";

    //this is to check if a new image has been updated or return the existing one.
    if (data.image.isEmpty) {
      final path = "products/${pickedFile!.name}";
      final file = File(pickedFile.path);
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(
          file,
          SettableMetadata(customMetadata: {
            'uploaded_by': 'admin',
            'description': 'this section is not important'
          }));
      final snapshot = await uploadTask.whenComplete(() {});
      urlDownload = await snapshot.ref.getDownloadURL();
    } else {
      urlDownload = data.image;
    }

    print("this is info from the update provider");
    print(urlDownload);
    print(data.toJson());
    print(pickedFile.toString());

    //////////////////////////////////handle data to be submitted

    Map<String, dynamic> data2 = <String, dynamic>{
      "id": data.id,
      "product": data.product,
      "category": data.category,
      "price": data.price,
      "discountPrice": data.discountPrice,
      "favourite": data.favourite,
      "image": urlDownload,
      "rating": data.rating,
      "quantity": data.quantity,
      "discription": data.discription,
      "unit": data.unit,
      "rate": data.rate,
      "specialOffer": data.specialOffer,
      "date": DateTime.now(),
    };

    //////////////////////////////////handle data to be handle submission

    final CollectionReference _mainCollection = _db.collection('products');
    DocumentReference documentReferencer = _mainCollection.doc(documentID);

    await documentReferencer.update(data2).whenComplete(() {
      callback(true);
    });
  }
}
