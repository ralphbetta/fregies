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

class ProductEditScreen extends StatelessWidget {
  const ProductEditScreen(
      {Key? key, required this.product, required this.index})
      : super(key: key);
  final ProductModel product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Body(productModel: product, index: index);
  }
}

class Body extends StatefulWidget {
  const Body({Key? key, required this.productModel, required this.index})
      : super(key: key);
  final ProductModel productModel;
  final int index;

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
                      : Image(
                          image: NetworkImage(widget.productModel.image),
                        ),
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
            productEditField("Enter Product Name"),
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
                  value: widget.productModel.category,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).hintColor),
                  onChanged: (String? newValue) {
                    setState(() {
                      widget.productModel.category = newValue!;
                    });
                  },
                  items: dropdownItems),
            ),
            rateEditField("E.g: Kg, cup, bag, pieces etc..."),
            Padding(
              padding: EdgeInsets.only(left: getPercentageWidth(1)),
              child: Text("Special Offer?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).hintColor)),
            ),
            Container(
              width: getPercentageWidth(100),
              height: getPercentageHeight(6) + 3,
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
                            groupValue: widget.productModel.specialOffer,
                            onChanged: (value) {
                              setState(() {
                                widget.productModel.specialOffer = value!;
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
                            groupValue: widget.productModel.specialOffer,
                            onChanged: (value) {
                              setState(() {
                                widget.productModel.specialOffer = value!;
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
            priceEditField("Discount Price (\$)"),
            widget.productModel.specialOffer
                ? discountEditField("Discount Price (\$)")
                : Container(),
            descriptionEditField("product Description", maxline: 3),
            quantityEditField("Available Quantity"),
            TextBtn(
              vertical: 4,
              horizontal: 0,
              title: "Post",
              load: isLoading,
              action: () {
                print("this is the products");
                // print(widget.productModel.product);
                // print(widget.productModel.category);
                // print(widget.productModel.rate);
                // print(widget.productModel.specialOffer);
                // print(widget.productModel.price);
                // print(widget.productModel.discountPrice);
                // print(widget.productModel.discription);
                // print(widget.productModel.quantity);

                if (widget.productModel.product.isNotEmpty &&
                    widget.productModel.category.isNotEmpty &&
                    widget.productModel.rate.isNotEmpty &&
                    widget.productModel.price.toString().isNotEmpty &&
                    widget.productModel.quantity.toString().isNotEmpty) {
                  setState(() {
                    isLoading = true;
                  });
                  ProductModel product = ProductModel(
                      id: context.read<ProductNotifier>().productList.length +
                          1,
                      product: widget.productModel.product,
                      category: widget.productModel.category,
                      price: widget.productModel.price,
                      discountPrice: widget.productModel.discountPrice
                              .toString()
                              .isNotEmpty
                          ? widget.productModel.discountPrice
                          : widget.productModel.price,
                      favourite: widget.productModel.favourite,
                      image: imageState.isNotEmpty
                          ? ""
                          : widget.productModel.image,
                      rating: widget.productModel.rating,
                      quantity: widget.productModel.quantity,
                      discription: widget.productModel.discription,
                      unit: "\$",
                      rate: widget.productModel.rate,
                      specialOffer: widget.productModel.specialOffer);

                  print("wow");

                  context.read<ProductNotifier>().updateProduct(
                      product, widget.index, xImageFile, (sucess) {
                    !sucess
                        ? popUp(context, "Error Alert",
                            <Widget>[const Text("Not updated")])
                        : popUp(context, "Success",
                            <Widget>[const Text("Update Completed")]);

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

  productEditField(String hintText, {int maxline = 1}) {
    return Container(
      height: getPercentageHeight(5) * 1,
      padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(2)),
      margin: EdgeInsets.only(bottom: getPercentageHeight(1)),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        child: TextFormField(
          initialValue: widget.productModel.product,
          keyboardType: TextInputType.text,
          maxLines: maxline,
          onChanged: (value) {
            setState(() {
              widget.productModel.product = value;
            });
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: productNameStyle()),
        ),
      ),
    );
  }

  rateEditField(String hintText, {int maxline = 1}) {
    return Container(
      height: getPercentageHeight(5) * 1,
      padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(2)),
      margin: EdgeInsets.only(bottom: getPercentageHeight(1)),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        child: TextFormField(
          initialValue: widget.productModel.rate,
          keyboardType: TextInputType.text,
          maxLines: maxline,
          onChanged: (value) {
            setState(() {
              widget.productModel.rate = value;
            });
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: productNameStyle()),
        ),
      ),
    );
  }

  categoryEditField(String hintText, {int maxline = 1}) {
    return Container(
      height: getPercentageHeight(5) * 1,
      padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(2)),
      margin: EdgeInsets.only(bottom: getPercentageHeight(1)),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        child: TextFormField(
          initialValue: widget.productModel.category,
          keyboardType: TextInputType.text,
          maxLines: maxline,
          onChanged: (value) {
            setState(() {
              widget.productModel.category = value;
            });
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: productNameStyle()),
        ),
      ),
    );
  }

  priceEditField(String hintText, {int maxline = 1}) {
    return Container(
      height: getPercentageHeight(5) * 1,
      padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(2)),
      margin: EdgeInsets.only(bottom: getPercentageHeight(1)),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        child: TextFormField(
          initialValue: widget.productModel.price.toString().isNotEmpty
              ? widget.productModel.price.toString()
              : "0.00",
          keyboardType: TextInputType.number,
          maxLines: maxline,
          onChanged: (value) {
            setState(() {
              widget.productModel.price = double.tryParse(value) ?? 0.00;
            });
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: productNameStyle()),
        ),
      ),
    );
  }

  discountEditField(String hintText, {int maxline = 1}) {
    return Container(
      height: getPercentageHeight(5) * 1,
      padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(2)),
      margin: EdgeInsets.only(bottom: getPercentageHeight(1)),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        child: TextFormField(
          initialValue: widget.productModel.discountPrice.toString().isNotEmpty
              ? widget.productModel.discountPrice.toString()
              : "0.00",
          keyboardType: TextInputType.number,
          maxLines: maxline,
          onChanged: (value) {
            setState(() {
              widget.productModel.discountPrice =
                  double.tryParse(value) ?? 0.00;
            });
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: productNameStyle()),
        ),
      ),
    );
  }

  descriptionEditField(String hintText, {int maxline = 3}) {
    return Container(
      height: getPercentageHeight(5) * 3,
      padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(2)),
      margin: EdgeInsets.only(bottom: getPercentageHeight(1)),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        child: TextFormField(
          initialValue: widget.productModel.discription,
          keyboardType: TextInputType.multiline,
          maxLines: maxline,
          onChanged: (value) {
            setState(() {
              widget.productModel.discription = value;
            });
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: productNameStyle()),
        ),
      ),
    );
  }

  quantityEditField(String hintText, {int maxline = 1}) {
    return Container(
      height: getPercentageHeight(5) * 1,
      padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(2)),
      margin: EdgeInsets.only(bottom: getPercentageHeight(1)),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        child: TextFormField(
          initialValue: widget.productModel.quantity.toString().isNotEmpty
              ? widget.productModel.quantity.toString()
              : "0",
          keyboardType: TextInputType.number,
          maxLines: maxline,
          onChanged: (value) {
            setState(() {
              widget.productModel.quantity = int.tryParse(value) ?? 0;
            });
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: productNameStyle()),
        ),
      ),
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

String productHolder = "";
String categoryHolder = "";
String rateHolder = "";
String specialOfferHolder = "";
String priceHolder = "";
String discountPricetHolder = "";
String descriptionHolder = "";
String quantityHolder = "";
