import 'package:flutter/material.dart';
import 'package:flutter_sqflite_example/widget/navigator/navigator.dart';
import 'package:provider/provider.dart';
import '../../../widget/border.dart';
import '../../../widget/buttons/small_white_elevation_button.dart';
import '../../provider/product.dart';
import '../../widget/buttons/small_red_elevation_button.dart';
import '../../widget/dismiss_back_ground/delete_dismiss_container.dart';
import '../../widget/dismiss_back_ground/update_dismiss_container.dart';
import '../../widget/responsive/responsive.dart';
import '../../widget/snack_bar/snack_bar_widget.dart';
import '../../widget/style_color.dart';
import '../../widget/text_widget.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';
import 'image_screen.dart';

class ShowProductScreen extends StatefulWidget {
  const ShowProductScreen({Key? key}) : super(key: key);

  @override
  _ShowProductScreenState createState() => _ShowProductScreenState();
}

class _ShowProductScreenState extends State<ShowProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //add product
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: primaryColor,
        onPressed: () {
          navigatorPushWidget(context, const AddProductScreen());
        },
      ),
      appBar: AppBar(
        title: Text(
          'Products',
          style: Responsive.isMobile(context)
              ? titleWhiteMobileStyle
              : titleWhiteTabletStyle,
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<ProductProvider>(context, listen: false)
            .selectProducts(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<ProductProvider>(
                child: Center(
                  child: Text(
                    'No products added',
                    textAlign: TextAlign.center,
                    style: Responsive.isMobile(context)
                        ? titleBigBlackMobileStyle
                        : titleBigBlackTabletStyle,
                  ),
                ),
                builder: (context, productProvider, child) => productProvider
                        .item.isEmpty
                    ? child!
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: productProvider.item.length,
                        itemBuilder: (context, index) => Dismissible(
                          key: ValueKey(productProvider.item[index].id),
                          child: MainBody(
                            productProvider: productProvider,
                            index: index,
                          ),
                          background: const DeleteDismiss(verticalMargin: 0.03),
                          secondaryBackground:
                              const EditDismiss(verticalMargin: 0.03),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              //delete
                              return showModalBottomSheet(
                                shape: bottomSheetborderWidget(context),
                                backgroundColor: backGroundColor,
                                context: context,
                                builder: (context) => DeleteProductBottomSheet(
                                  index: index,
                                  productProvider: productProvider,
                                ),
                              );
                            } else {
                              //edit product
                              var helperVar = productProvider.item[index];
                              navigatorPushWidget(
                                context,
                                EditProductScreen(
                                  id: helperVar.id,
                                  productName: helperVar.productName,
                                  productPrice: helperVar.productPrice,
                                  productImage: helperVar.productImage,
                                  index: index,
                                ),
                              );
                            }
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}

class DeleteProductBottomSheet extends StatelessWidget {
  const DeleteProductBottomSheet({
    Key? key,
    required this.productProvider,
    required this.index,
  }) : super(key: key);
  final ProductProvider productProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var helper = productProvider.item[index];
    return Container(
      width: width,
      height: height * 0.23,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Do you want to delete the ${helper.productName}?',
            maxLines: 2,
            style: Responsive.isMobile(context)
                ? bodyBoldBlackMobileStyle
                : bodyBoldBlackTabletStyle,
          ),
          Row(
            children: [
              Expanded(
                child: SmallRedElevationButton(
                  text: 'Delete it',
                  onPress: () async {
                    productProvider.deleteProductById(helper.id);
                    productProvider.item.removeAt(index);
                    snackBarSuccessWidget(context, 'Product removed');
                    navigatorPopWidget(context);
                  },
                ),
              ),
              Expanded(
                child: SmallWhiteElevationButton(
                  text: 'Return',
                  onPress: () {
                    navigatorPopWidget(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    Key? key,
    required this.productProvider,
    required this.index,
  }) : super(key: key);
  final ProductProvider productProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var helper = productProvider.item[index];
    return Card(
      elevation: 3,
      shape: shapeWidget(context),
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.01),
      shadowColor: shadowColor,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  getBodyBoldText(context, 'product name: ', helper.productName,),
                  SizedBox(height: height * 0.02),
                  getPriceText(context, 'Price: ', helper.productPrice),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                helper.productImage.path != '0'
                    ? ClipRRect(
                        borderRadius: borderWidget(context),
                        child: GestureDetector(
                          onTap: () {
                            navigatorPushWidget(
                              context,
                              ImageScreen(
                                image: helper.productImage,
                                heroTag: 'flutterLogo$index',
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'flutterLogo$index',
                            child: FadeInImage(
                              placeholder: const AssetImage('loading.gif'),
                              image: FileImage(helper.productImage),
                              width: width * 0.25,
                              height: height * 0.17,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              placeholderFit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    : Image.asset(
                        'no_image.png',
                        height: width * 0.27,
                        width: width * 0.2,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
