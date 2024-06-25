import 'package:emartseller/const/const.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';

Widget customFormField({
  required String title,
  required String hintText,
  icon,
  isPswd = false,
  controller,
}) {
  return TextFormField(
    style:
        const TextStyle(color: textfieldGrey, decoration: TextDecoration.none),
    maxLength: 40,
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
      border: InputBorder.none,
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
        return "Please enter  $title.";
      }
      if (isPswd && value.length < 6) {
        return "Password must be at least 6 characters long.";
      }
      return null;
    },
  );
}
