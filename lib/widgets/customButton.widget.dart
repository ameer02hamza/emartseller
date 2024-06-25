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
      shape:const RoundedRectangleBorder(
        // borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: boldText(text: title, color: white),
  );
}
