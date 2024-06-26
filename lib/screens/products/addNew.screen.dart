import 'package:emartseller/screens/products/components/productDropDown.component.dart';
import 'package:emartseller/screens/products/components/productImage.component.dart';
import 'package:emartseller/widgets/customFormField.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';

import '../../const/const.dart';

class AddNewProduct extends StatelessWidget {
  const AddNewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        title: boldText(text: "Add New Product", color: white),
        actions: [
          TextButton(
              onPressed: () {}, child: generalText(text: "Save", color: white))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customFormField(title: "Name", hintText: "e.g Apple"),
              10.heightBox,
              customFormField(title: "Price", hintText: "e.g \$200"),
              10.heightBox,
              customFormField(title: "Quantity", hintText: "e.g 20"),
              10.heightBox,
              productDropdown(title: "Choose category"),
              10.heightBox,
              productDropdown(title: "Choose sub category"),
              const Divider(),
              generalText(
                  text: "Choose Product Images", color: lightGrey, size: 18),
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    3,
                    (index) => productImages(
                        label: "Image ${index + 1}", onPress: () {})),
              ),
              5.heightBox,
              generalText(
                  text: "Thumbnail will be the first Image",
                  color: lightGrey,
                  size: 12),
              Wrap(
                spacing: 4.0,
                runSpacing: 4.0,
                children: List.generate(
                    14,
                    (index) => Stack(
                          alignment: Alignment.center,
                          children: [
                            VxBox()
                                .color(Vx.randomPrimaryColor)
                                .roundedFull
                                .size(50, 50)
                                .make(),
                            const Visibility(
                                visible: true,
                                child: Icon(
                                  Icons.check,
                                  color: white,
                                ))
                          ],
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
