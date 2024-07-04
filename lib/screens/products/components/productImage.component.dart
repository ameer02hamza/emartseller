import 'package:emartseller/const/const.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';

Widget productImages({required label, required onPress}) {
  return label
      .toString()
      .text
      .textStyle(TextStyle(
        color: textfieldGrey,
      ))
      .bold
      .makeCentered()
      .box
      .color(lightPrimary)
      .size(100, 100)
      .roundedSM
      .make();
}
