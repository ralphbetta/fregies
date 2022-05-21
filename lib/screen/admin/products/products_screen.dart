import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fregies/config/route_config.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/models/product_model.dart';
import 'package:fregies/provider/application_state.dart';
import 'package:fregies/provider/product_provider.dart';
import 'package:fregies/widgets/alertBox/alert_box.dart';
import 'package:fregies/widgets/custom_input/universal_custom_input.dart';
import 'package:fregies/widgets/text_btn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Body();
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(child: Text("Fruits"), value: "Fruits"),
      DropdownMenuItem(child: Text("Vegetables"), value: "Vegetables"),
      DropdownMenuItem(child: Text("Drieds"), value: "Drieds"),
      DropdownMenuItem(child: Text("Others"), value: "Others"),
    ];
    return menuItems;
  }

  String selectedValue = 'Others';

  bool val = false;

  File? imageFile;
  XFile? xImageFile;
  String imageState = "";

  _pickedFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 500,
        maxWidth: 500,
        imageQuality: 50);
    if (pickedFile != null) {
      print(pickedFile.name.toString());
      return pickedFile;
    } else {
      return null;
    }
  }

  TextEditingController _productController = TextEditingController();
  TextEditingController _discriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _discountController = TextEditingController();
  TextEditingController _unitController = TextEditingController();
  TextEditingController _rateController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print("stream value printed from product_screen.dart");
    print(context.watch<List<ProductModel>>().toList().length);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Center(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(7)),
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: getPercentageWidth(1),
                      horizontal: getPercentageWidth(2)),
                  child: const Text("Total Product",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: white)),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: lightPrimary,
                      ),
                      color: lightPrimary,
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(20))),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: getPercentageWidth(1),
                      horizontal: getPercentageWidth(2)),
                  child: Text(context
                      .watch<List<ProductModel>>()
                      .toList()
                      .length
                      .toString()),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: lightPrimary),
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(20))),
                )
              ],
            ),
            SizedBox(
              height: getPercentageHeight(3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: getPercentageWidth(30),
                  height: getPercentageWidth(30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      // color: kTextColor,
                      border: Border.all(width: 2, color: lightPrimary)),
                  child: imageFile != null
                      ? Image.file(imageFile!, fit: BoxFit.contain)
                      : const Text(''),
                ),
                SizedBox(
                  width: getPercentageWidth(5),
                ),
                GestureDetector(
                  onTap: () async {
                    XFile? pickedImage = await _pickedFile();
                    if (pickedImage != null) {
                      print(pickedImage);
                      setState(() {
                        imageFile = File(pickedImage.path);
                        xImageFile = pickedImage;
                        imageState = "set";
                      });
                    }
                  },
                  child: Container(
                    width: getPercentageWidth(10),
                    height: getPercentageWidth(10),
                    child: const Icon(
                      Icons.add_a_photo,
                      color: white,
                      size: 15,
                    ),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: lightPrimary),
                  ),
                )
              ],
            ),
            SizedBox(
              height: getPercentageWidth(10),
            ),
            customFormField(context, _productController,
                ApplicationUpdateState.username, "Enter Product Name", 1),
            Container(
              height: getPercentageHeight(5),
              width: getPercentageWidth(100),
              padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(2)),
              margin: EdgeInsets.only(bottom: getPercentageHeight(1)),
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButton(
                  icon: Icon(Icons.arrow_drop_down_sharp),
                  underline: SizedBox(),
                  isExpanded: true,
                  value: selectedValue,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).hintColor),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: dropdownItems),
            ),
            customFormField(
                context,
                _unitController,
                ApplicationUpdateState.username,
                "E.g: Kg, cup, bag, pieces etc...",
                1),
            Padding(
              padding: EdgeInsets.only(left: getPercentageWidth(1)),
              child: Text("Special Offer?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).hintColor)),
            ),
            Container(
              width: getPercentageWidth(100),
              height: getPercentageHeight(6) + 4,
              margin: EdgeInsets.only(bottom: getPercentageHeight(1)),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Theme.of(context).backgroundColor,
                      child: Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value!;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getPercentageWidth(10)),
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Theme.of(context).backgroundColor,
                      child: Row(
                        children: [
                          Radio<bool>(
                            value: false,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value!;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getPercentageWidth(10)),
                            child: const Text("No"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            customFormField(context, _priceController,
                ApplicationUpdateState.phone, "product Price (\$)", 1),
            val
                ? customFormField(context, _discountController,
                    ApplicationUpdateState.phone, "Discount Price (\$)", 1)
                : Container(),
            customFormField(context, _discriptionController,
                ApplicationUpdateState.username, "product Description", 3),
            customFormField(context, _quantityController,
                ApplicationUpdateState.phone, "Available Quantity", 1),
            TextBtn(
              vertical: 4,
              horizontal: 0,
              title: "Post",
              load: isLoading,
              action: () {
                print("product List");
                // context.read<ProductNotifier>().fetchDoc();
                print(context.read<ProductNotifier>().productList.length);
                print("next");

                // final productList =
                //     Provider.of<List<ProductModel>>(context, listen: false);
                // print(productList);

                if (_productController.text.isNotEmpty &&
                    _priceController.text.isNotEmpty &&
                    _quantityController.text.isNotEmpty &&
                    _discriptionController.text.isNotEmpty &&
                    _unitController.text.isNotEmpty &&
                    imageState.isNotEmpty) {
                  setState(() {
                    isLoading = true;
                  });
                  ProductModel product = ProductModel(
                      id: context.read<ProductNotifier>().productList.length +
                          1,
                      product: _productController.text,
                      category: selectedValue,
                      price: double.parse(_priceController.text),
                      discountPrice: _discountController.text.isNotEmpty
                          ? double.parse(_discountController.text)
                          : double.parse(_priceController.text),
                      favourite: false,
                      image: imageFile!.path,
                      rating: 5.0,
                      quantity: int.parse(_quantityController.text),
                      discription: _discriptionController.text,
                      unit: "\$",
                      rate: _unitController.text,
                      specialOffer: val);

                  // print(product.toJson());
                  // print("wow");

                  context
                      .read<ProductNotifier>()
                      .addProduct(product, xImageFile, (sucess) {
                    !sucess
                        ? popUp(context, "Error Alert",
                            <Widget>[const Text("Unable to post")])
                        : popUp(context, "Success", <Widget>[
                            const Text(
                              "Product Post Completed!",
                              textAlign: TextAlign.center,
                            )
                          ]);

                    setState(() {
                      isLoading = false;
                    });
                    // Navigator.popUntil(context, (route) => route.isFirst);
                    //const PostAlert();
                    // reversibleNavigation(context, ProductScreen());
                  });
                } else {
                  print("fields still empty");
                }
              },
            )
          ],
        ),
      ))),
    );
  }
}

class PostAlert extends StatelessWidget {
  const PostAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return popUp(context, "Success Alert", <Widget>[
      Container(
        width: getPercentageWidth(100),
        height: getPercentageWidth(50),
        //color: Colors.red,
        child: const Image(
          image: AssetImage("assets/gif/screen-3.gif"),
        ),
      ),
      Text(
        "Post Successful",
        style: productNameStyle(size: 20),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: getPercentageWidth(2),
      ),
      TextBtn(
        vertical: 3,
        horizontal: 1,
        title: "done",
        action: () {
          Navigator.pop(context);
        },
      )
    ]);
  }
}
