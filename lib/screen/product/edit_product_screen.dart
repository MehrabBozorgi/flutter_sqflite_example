import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite_example/widget/navigator/navigator.dart';
import 'package:provider/provider.dart';
import '../../provider/product.dart';
import '../../widget/alert_dialog/awesome_alert.dart';
import '../../widget/buttons/red_elevation_button.dart';
import '../../widget/responsive/responsive.dart';
import '../../widget/snack_bar/snack_bar_widget.dart';
import '../../widget/style_color.dart';
import '../../widget/text_form_fileds/text_form_field_name.dart';
import '../../widget/text_form_fileds/text_form_filed_money.dart';
import 'widget/container_widget.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({
    Key? key,
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.index,
  }) : super(key: key);
  final String id;
  final String productName;
  final String productPrice;
  final File productImage;
  final int index;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.productName;
    _priceController.text = widget.productPrice;

    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    if (productProvider.image != null) {
      productProvider.deleteImage();
    }

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    //
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Edit Product',
          style: Responsive.isMobile(context)
              ? titleWhiteMobileStyle
              : titleWhiteMobileStyle,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () {
            if (productProvider.image != null) {
              productProvider.deleteImage();
            }

            navigatorPopWidget(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(height: height * 0.02),

              FadeIn(
                delay: 3.0,
                from: SlideFrom.LEFT,
                fade: true,
                child: Consumer<ProductProvider>(
                  builder: (context, productP, child) => ContainerWidget(
                    widget: widget.productImage.path == '0' &&
                            productP.image == null
                        ? FadeInImage(
                            placeholder: const AssetImage('loading.gif'),
                            image: const AssetImage('no_image.png'),
                            height: width * 0.27,
                            width: width * 0.25,
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            placeholderFit: BoxFit.contain,
                          ):

                         productP.image != null &&
                                widget.productImage.path == '0'
                            ? Stack(
                                children: [
                                  FadeInImage(
                                    placeholder:
                                        const AssetImage('loading.gif'),
                                    image: FileImage(productP.showImage!),
                                    width: width,
                                    height: height,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                    placeholderFit: BoxFit.contain,
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: primaryColor,
                                    ),
                                    onPressed: () {
                                      productP.deleteImage();
                                    },
                                  ),
                                ],
                              )
                            : productP.image == null
                                ? FadeInImage(
                                  placeholder:
                                      const AssetImage('loading.gif'),
                                  image: FileImage(widget.productImage),
                                  height: width,
                                  width: width,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  placeholderFit: BoxFit.contain,
                                )
                                : Stack(
                                    children: [
                                      FadeInImage(
                                        placeholder:
                                            const AssetImage('loading.gif'),
                                        image: FileImage(productP.showImage!),
                                        width: width,
                                        height: height,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                        placeholderFit: BoxFit.contain,
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete_forever,
                                          color: primaryColor,
                                        ),
                                        onPressed: () {
                                          productP.deleteImage();
                                        },
                                      ),
                                    ],
                                  ),
                    callback: () {
                      productP.pickImage();
                    },
                  ),
                ),
              ),

              //name
              FadeIn(
                delay: 3.0,
                from: SlideFrom.LEFT,
                fade: true,
                child: TextFormFieldNameWidget(
                  textEditingController: _nameController,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  maxLength: 500,
                  minLine: 1,
                  maxLine: 1,
                  labelText: 'Product name',
                  iconData: Icons.edit_outlined,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Product name is empty';
                    }
                  },
                ),
              ),
              //product price
              FadeIn(
                delay: 3.0,
                from: SlideFrom.RIGHT,
                fade: true,
                child: TextFormFieldMoneyWidget(
                  textEditingController: _priceController,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  maxLength: 50,
                  minLine: 1,
                  maxLine: 1,
                  labelText: 'Product price',
                  iconData: Icons.money_rounded,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Product price is empty';
                    }
                  },
                ),
              ),

              ElevationButtonWidget(
                text: 'Edit Product',
                onPress: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  var helperVar = productProvider.item[widget.index];
                  var item = productProvider.item
                      .firstWhere((element) => element.id == helperVar.id);

                  if (!_key.currentState!.validate()) {
                    alertDialogWarning(
                        context, 'Error', 'Input values are invalid');
                  } else {
                    _key.currentState!.save();
                    if (productProvider.image != null) {
                      if (productProvider.fileType != 'png' &&
                          productProvider.fileType != 'jpg' &&
                          productProvider.fileType != 'jpeg') {
                        alertDialogError(context, 'Error',
                            'The selected file format is incorrect');
                      } else {
                        if (double.parse(productProvider.fileSize.toString()) >=
                            double.parse('10.00')) {
                          alertDialogError(context, 'Error',
                              'The selected image size is large');
                        } else {
                          productProvider.updateProductNameById(
                            helperVar.id,
                            _nameController.text,
                          );
                          item.productName = _nameController.text;

                          productProvider.updatePriceById(
                            helperVar.id,
                            _priceController.text.replaceAll(',', ''),
                          );
                          item.productPrice =
                              _priceController.text.replaceAll(',', '');

                          //
                          if (productProvider.image == null &&
                              widget.productImage.path == '0') {
                            productProvider.updateProductImageById(
                              helperVar.id,
                              '0',
                            );
                            item.productImage = File('0');
                          } else {
                            productProvider.updateProductImageById(
                              helperVar.id,
                              productProvider.image,
                            );
                            item.productImage = productProvider.showImage!;
                          }

                          snackBarSuccessWidget(context, 'Editing done');
                          _priceController.clear();
                          _nameController.clear();
                          //
                          navigatorPopWidget(context);
                        }
                      }
                    }
                    //With out Image
                    //
                    //
                    //
                    //
                    //
                    else {
                      productProvider.updateProductNameById(
                        helperVar.id,
                        _nameController.text,
                      );
                      item.productName = _nameController.text;

                      productProvider.updatePriceById(
                        helperVar.id,
                        _priceController.text.replaceAll(',', ''),
                      );
                      item.productPrice =
                          _priceController.text.replaceAll(',', '');
                      //

                      snackBarSuccessWidget(context, 'Editing done');
                      _priceController.clear();
                      _nameController.clear();
                      //
                      navigatorPopWidget(context);
                    }
                  }
                },
                minSizeW: width * 0.5,
              ),
              SizedBox(height: height * 0.06),
            ],
          ),
        ),
      ),
    );
  }
}
