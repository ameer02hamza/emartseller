import 'package:emartseller/widgets/customFormField.widget.dart';
import 'package:emartseller/widgets/cutomTextArea.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';

import '../../const/const.dart';

class ShopSettingScreen extends StatelessWidget {
  const ShopSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        title: boldText(text: shopSettings, size: 18),
        actions: [
          TextButton(onPressed: () {}, child: generalText(text: save, size: 18))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              customFormField(title: shopName, hintText: shopNameHint),
              10.heightBox,
              customFormField(title: shopAddress, hintText: shopAddressHint),
              10.heightBox,
              customFormField(title: shopMobile, hintText: shopMobileHint),
              10.heightBox,
              customFormField(title: shopWebHint, hintText: shopWebHint),
              10.heightBox,
              customTextArea(title: shopDesc, hintText: shopDescHint),
            ],
          ),
        ),
      ),
    );
  }
}
