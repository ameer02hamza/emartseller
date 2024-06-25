import 'package:emartseller/const/const.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:intl/intl.dart' as intl;
AppBar appBarWidget({required title}){
  return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: boldText(text: title, color: fontGrey),
        actions: [
          Center(
            child: boldText(
                text: intl.DateFormat.yMMMd().format(DateTime.now()),
                color: fontGrey),
          )
        ],
      );
}