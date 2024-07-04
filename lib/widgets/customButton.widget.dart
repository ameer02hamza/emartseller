import 'package:emartseller/const/const.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';

Widget customButton({
  required String title,
  onPressed,
  bgColor,
  textColor,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: boldText(text: title, color: textColor),
  );
}
