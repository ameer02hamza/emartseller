import 'package:emartseller/const/const.dart';

Widget authFormField({
  required String title,
  required String hintText,
  icon,
  isPswd = false,
  controller,
}) {
  return TextFormField(
    style:
        const TextStyle(color: primaryColor, decoration: TextDecoration.none),
    maxLength: 40,
    controller: controller,
    obscureText: isPswd,
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: primaryColor,
        ),
        counterText: "",
        hintStyle: const TextStyle(
          color: textfieldGrey,
          
        ),
        hintText: hintText,
        isDense: true,
        fillColor: lightGrey,
        filled: true,
        border: InputBorder.none,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        ),
    validator: (value) {
      if (value!.isEmpty) {
        return "Please enter  $title.";
      }
      if (isPswd && value.length < 6) {
        return "Password must be at least 6 characters long.";
      }
      return null;
    },
  );
}
