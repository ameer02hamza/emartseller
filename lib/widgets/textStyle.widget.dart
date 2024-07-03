import 'package:emartseller/const/const.dart';

Widget generalText({text, color = Colors.white, double size = 14.0}) {
  return "$text"
      .text
      .color(color)
      .size(size)
      .overflow(TextOverflow.ellipsis)
      .maxLines(2)
      .make();
}

Widget boldText({text, color = Colors.white, double size = 14.0}) {
  return "$text"
      .text
      .bold
      .color(color)
      .size(size)
      .overflow(TextOverflow.ellipsis)
      .maxLines(2)
      .make();
}

Widget semiBoldText({text, color = Colors.white, double size = 14.0}) {
  return "$text"
      .text
      .semiBold
      .color(color)
      .size(size)
      .overflow(TextOverflow.ellipsis)
      .maxLines(2)
      .make();
}

Widget linkText({text, color = linkColor, double size = 14.0}) {
  return "$text"
      .text
      .color(color)
      .underline
      .lowercase
      .size(size)
      .overflow(TextOverflow.ellipsis)
      .maxLines(2)
      .make();
}
