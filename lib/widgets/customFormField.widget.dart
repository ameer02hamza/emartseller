import 'package:emartseller/const/const.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:flutter/services.dart';

Widget customFormField(
    {required String title,
    required String hintText,
    icon,
    isPswd = false,
    controller,
    isNumeric = false}) {
  return TextFormField(
    style:
        const TextStyle(color: textfieldGrey, decoration: TextDecoration.none),
    maxLength: 40,
    inputFormatters: isNumeric
        ? [FilteringTextInputFormatter.allow(RegExp("[0-9]"))]
        : [],
    keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
    controller: controller,
    obscureText: isPswd,
    decoration: InputDecoration(
      counterText: "",
      label: generalText(text: title, color: textfieldGrey),
      hintStyle: const TextStyle(
        color: textfieldGrey,
      ),
      hintText: hintText,
      isDense: true,
      fillColor: lightGrey,
      // filled: true,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: white,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: white,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: white,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: red,
        ),
      ),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return "Please enter  ${title.toString().toLowerCase()}.";
      }
      if (isPswd && value.length < 6) {
        return "Password must be at least 6 characters long.";
      }
      return null;
    },
  );
}
