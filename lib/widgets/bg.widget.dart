import 'package:emartseller/const/const.dart';
import 'package:emartseller/const/images.dart';

Widget bgWidget({child, required height}) {
  return Container(
    height: height,
    decoration: const BoxDecoration(
        image: DecorationImage(
      image: AssetImage(
        imgLogin,
      ),
      // fit: BoxFit.cover,
      scale: 0.06,
    )),
    child: child,
  );
}
