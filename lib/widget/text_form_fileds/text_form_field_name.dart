import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../responsive/responsive.dart';
import '../style_color.dart';
class TextFormFieldNameWidget extends StatelessWidget {
  final TextInputType keyboardType;
  final int maxLength;
  final int minLine;
  final int maxLine;
  final String labelText;
  final IconData iconData;
  final FormFieldValidator validator;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextEditingController textEditingController;

  const TextFormFieldNameWidget({
    Key? key,
    required this.keyboardType,
    required this.maxLength,
    required this.minLine,
    required this.maxLine,
    required this.labelText,
    required this.iconData,
    required this.validator,
    required this.textInputAction,
    required this.floatingLabelBehavior,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.005),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: TextFormField(
        style: Responsive.isMobile(context)
            ? bodyBlackMobileStyle
            : bodyBlackTabletStyle,
        inputFormatters: [
          FilteringTextInputFormatter.deny(
              // RegExp("[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]+"),
              // RegExp(r"^[[A-Z]|[a-z]][[A-Z]|[a-z]|\\d|[_]]$^[[A-Z]|[a-z]]"),
              RegExp(
                  r'[!@#<>?":_`;،,.$%^&*«»ًٌٍَُِّ؛؟)(_+|{}":؟><ء[\]\\|=+)(/*&^%-0]')),
        ],
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        maxLength: maxLength,
        minLines: minLine,
        maxLines: maxLine,
        controller: textEditingController,
        decoration: InputDecoration(
          counter: const SizedBox.shrink(),
          prefixIcon: Icon(iconData, color: iconColor),
          labelText: labelText,
          labelStyle: Responsive.isMobile(context)
              ? bodyBlackMobileStyle
              : bodyBlackTabletStyle,
          filled: true,
          fillColor: Colors.white,
          floatingLabelBehavior: floatingLabelBehavior,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: backGroundColor, width: 2),
            borderRadius: BorderRadius.circular(width * 0.03),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: backGroundColor, width: 2),
            borderRadius: BorderRadius.circular(width * 0.03),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(width * 0.03),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: backGroundColor, width: 2),
            borderRadius: BorderRadius.circular(width * 0.03),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
