import 'package:emartseller/screens/products/components/productDropDown.component.dart';
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
        title: boldText(text: "Add New Product", color: fontGrey),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              customFormField(title: "Name", hintText: "e.g Apple"),
              customFormField(title: "Price", hintText: "e.g \$200"),
              customFormField(title: "Quantity", hintText: "e.g 20"),
              10.heightBox,
              productDropdown(title: "Choose category"),
              10.heightBox,
              productDropdown(title: "Choose sub category"),
            ],
          ),
        ),
      ),
    );
  }
}
