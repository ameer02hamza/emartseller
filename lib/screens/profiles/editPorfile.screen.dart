import 'package:emartseller/const/const.dart';
import 'package:emartseller/const/images.dart';
import 'package:emartseller/widgets/customFormField.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        title: boldText(text: "$edit Profile", size: 18),
        actions: [
          TextButton(onPressed: () {}, child: generalText(text: save, size: 18))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(
              imgProduct,
              width: 150,
            ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: generalText(text: "Change Image", color: primaryColor),
            ),
            const Divider(),
            customFormField(
              hintText: nameHint,
              title: name,
            ),
            10.heightBox,
            customFormField(
              hintText: passwordHint,
              title: password,
              isPswd: true,
            ),
            10.heightBox,
            customFormField(
              hintText: confirmPasswordHint,
              title: confirmPassword,
              isPswd: true,
            ),
            10.heightBox,
          ],
        ),
      ),
    );
  }
}
