import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite_example/widget/border.dart';
import 'package:flutter_sqflite_example/widget/text_form_fileds/text_form_field_name.dart';
import 'package:provider/provider.dart';
import '../../../widget/navigator/navigator.dart';
import '../../provider/product.dart';
import '../../widget/alert_dialog/awesome_alert.dart';
import '../../widget/buttons/red_elevation_button.dart';
import '../../widget/responsive/responsive.dart';
import '../../widget/snack_bar/snack_bar_widget.dart';
import '../../widget/style_color.dart';
import '../../widget/text_form_fileds/text_form_filed_money.dart';
import 'widget/container_widget.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
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
          'Add product',
          style: Responsive.isMobile(context)
              ? titleWhiteMobileStyle
              : titleWhiteTabletStyle,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                  builder: (context, value, child) {
                    return value.image == null
                        ? ContainerWidget(
                            widget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Pick Image',
                                  style: Responsive.isMobile(context)
                                      ? bodyBlackMobileStyle
                                      : bodyBlackTabletStyle,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(width * 0.02),
                                  child: Icon(
                                    Icons.image,
                                    size: width * 0.07,
                                  ),
                                ),
                              ],
                            ),
                            callback: () {
                              productProvider.pickImage();
                            },
                          )
                        : ContainerWidget(
                            widget: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: borderWidget(context),
                                  child: FadeInImage(
                                    placeholder:
                                        const AssetImage('loading.gif'),
                                    image: FileImage(value.showImage!),
                                    width: width,
                                    height: height,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                    placeholderFit: BoxFit.contain,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: primaryColor,
                                  ),
                                  onPressed: () {
                                    value.deleteImage();
                                  },
                                ),
                              ],
                            ),
                            callback: () {
                              value.pickImage();
                            },
                          );
                  },
                ),
              ),

              //product name
              FadeIn(
                delay: 3.0,
                from: SlideFrom.RIGHT,
                fade: true,
                child: TextFormFieldNameWidget(
                  textEditingController: _nameController,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  maxLength: 500,
                  minLine: 1,
                  maxLine: 1,
                  labelText: 'Product Name',
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
                from: SlideFrom.LEFT,
                fade: true,
                child: TextFormFieldMoneyWidget(
                  textEditingController: _priceController,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  maxLength: 50,
                  minLine: 1,
                  maxLine: 1,
                  labelText: 'price product',
                  iconData: Icons.money_rounded,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Product price is empty';
                    }
                  },
                ),
              ),

              ElevationButtonWidget(
                text: 'Product registration',
                onPress: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (!_key.currentState!.validate()) {
                    alertDialogWarning(
                        context, 'Error', 'Problem with entered values');
                  } else {
                    if (productProvider.fileSize != null &&
                        double.parse(productProvider.fileSize.toString()) >=
                            double.parse('10.00')) {
                      alertDialogError(
                          context, 'Error', 'The selected image size is large');
                    } else {
                      if (productProvider.image != null &&
                          productProvider.fileType != 'png' &&
                          productProvider.fileType != 'jpg' &&
                          productProvider.fileType != 'jpeg') {
                        alertDialogError(context, 'Error',
                            'The selected file format is incorrect');
                      } else {
                        await productProvider.insertDatabase(
                          _nameController.text,
                          _priceController.text.replaceAll(',', ''),
                          productProvider.showImage??File('0'),
                        );
                        _priceController.clear();
                        _nameController.clear();
                        productProvider.deleteImage();
                        snackBarSuccessWidget(context, 'Product added');
                        navigatorPopWidget(context);
                      }
                    }
                  }
                },
                minSizeW: width * 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
