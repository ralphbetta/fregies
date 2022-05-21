import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fregies/models/product_model.dart';

Stream<int> getSessionTime() {
  return Stream.periodic(
    Duration(seconds: 1),
    (sessionTime) => sessionTime++,
  );

  //////how to use it
  ///context.watch<int>().toString(),
  ///what to add at the main
  ///StreamProvider(create: (_) => getSessionTime(), initialData: 0, ),
}

Stream<List<ProductModel>> getAllProducts() {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  return _db.collection("products").snapshots().map((event) => event.docs
      .map((firestoreMap) => ProductModel(
          id: firestoreMap['id'],
          product: firestoreMap['product'],
          category: firestoreMap['category'],
          price: firestoreMap['price'],
          discountPrice: firestoreMap['discountPrice'],
          favourite: firestoreMap['favourite'],
          image: firestoreMap['image'],
          rating: firestoreMap['rating'],
          quantity: firestoreMap['quantity'],
          discription: firestoreMap['discription'],
          unit: firestoreMap['unit'],
          rate: firestoreMap['rate'],
          specialOffer: firestoreMap['specialOffer']))
      .toList());

  //context.watch<List<ProductModel>>().toList().length
}

List<ProductModel> myInitialData = [];



//another format to observe
///////////////////////////////////////////
// Stream<List<ProductModel>> getProducts() {
  //   final FirebaseFirestore _db = FirebaseFirestore.instance;
  //   return _db.collection("products").snapshots().map((event) => event.docs
  //       .map((firestoreMap) => ProductModel(
  //           id: firestoreMap['id'],
  //           product: firestoreMap['product'],
  //           category: firestoreMap['price'],
  //           price: firestoreMap['category'],
  //           discountPrice: firestoreMap['discountPrice'],
  //           favourite: firestoreMap['favourite'],
  //           image: firestoreMap['image'],
  //           rating: firestoreMap['rating'],
  //           quantity: firestoreMap['quantity'],
  //           discription: firestoreMap['discription'],
  //           unit: firestoreMap['unit'],
  //           rate: firestoreMap['rate'],
  //           specialOffer: firestoreMap['specialOffer']))
  //       .toList());

  // return _db.collection('Products').snapshots().map((snapshot) => snapshot
  //     .documents
  //     .map((document) => Product.fromFirestore(document.data))
  //     .toList());
  // }
