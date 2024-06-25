import 'package:emartseller/const/const.dart';
import 'package:emartseller/const/images.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: "Product Details", color: fontGrey),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
              aspectRatio: 16 / 9,
              height: 300,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Image.asset(
                  imgProduct,
                  fit: BoxFit.fill,
                  width: double.infinity,
                )
                    .box
                    // .rounded
                    // .clip(Clip.antiAlias)
                    // .margin(const EdgeInsets.symmetric(horizontal: 8))
                    .make();
              },
            ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(text: "Title", size: 16, color: fontGrey),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    // maxRating: 5,
                    count: 5, //int.parse(itemData['p_rating']),
                    size: 25,
                    // stepInt: true,
                  ),
                  10.heightBox,
                  boldText(text: " \$2000", size: 16, color: red),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      boldText(text: "Colors: ", size: 16, color: fontGrey),
                      Row(
                        children: List.generate(3, (index) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              VxBox()
                                  .roundedFull
                                  .color(Vx.randomColor
                                      // Color(
                                      //   int.parse(itemData["p_colors"][index]))
                                      )
                                  .size(40, 40)
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .make()
                                  .onTap(() {
                                // controller.colorIndex.value = index;
                              }),
                              // const Visibility(
                              //     visible:
                              //         true, //index == controller.colorIndex.value,
                              //     child: const Icon(
                              //       Icons.check,
                              //       color: white,
                              //     ))
                            ],
                          );
                        }),
                      ),
                    ],
                  ).box.padding(const EdgeInsets.all(8)).make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      boldText(text: "Quantity: ", size: 16, color: fontGrey),
                      10.widthBox,
                      semiBoldText(
                        text: "10",
                        color: fontGrey,
                      )
                    ],
                  ).box.padding(const EdgeInsets.all(8)).make(),
                 const Divider(),
                  boldText(text: "Description", size: 16, color: fontGrey),
                  10.heightBox,
                  generalText(
                      text:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                          color: fontGrey
                          ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
