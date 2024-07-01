import 'package:emartseller/const/const.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';

Widget customTextArea({
  required String title,
  required String hintText,
  isReq = false,
  controller,
}) {
  return TextFormField(
    style:
        const TextStyle(color: textfieldGrey, decoration: TextDecoration.none),
    maxLines: 5,
    controller: controller,
    decoration: InputDecoration(
      counterText: "",
      label: boldText(text: title, color: textfieldGrey),
 
      hintStyle: const TextStyle(
        color: textfieldGrey,
      ),
      hintText: hintText,
      isDense: true,
      fillColor: lightGrey,
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
      if (value!.isEmpty && isReq) {
        return "Please enter  $title.";
      }
      return null;
    },
  );
}
