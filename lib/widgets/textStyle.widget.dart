import 'package:emartseller/const/const.dart';

Widget generalText({text, color = Colors.white, double size = 14.0}) {
  return "$text".text.color(color).size(size).make();
}

Widget boldText({text, color = Colors.white, double size = 14.0}) {
  return "$text".text.bold.color(color).size(size).make();
}

Widget semiBoldText({text, color = Colors.white, double size = 14.0}) {
  return "$text".text.semiBold.color(color).size(size).make();
}
