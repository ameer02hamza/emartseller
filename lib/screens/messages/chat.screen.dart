import 'package:emartseller/screens/messages/component/chatBubble.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: primaryColor,
      appBar: AppBar(
          title: "Ameer Hamza".text.color(white).make(),
          centerTitle: true,
          leading: IconButton(
            color: white,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
          )),
      body: Container(
        // color: primaryColor,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child: Container(
                    // color: white,
                    child: ListView(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: chatBubble("hi i am sender and you", true),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: chatBubble("Hi i am receiver and you", false),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: chatBubble("Hi i am receiver and you", false),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: chatBubble("Hi i am receiver and you", false),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: chatBubble("hi i am sender and you", true),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: chatBubble("hi i am sender and you", true),
                      ),
                    ]))),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                     style:const TextStyle(color: textfieldGrey),
                    decoration: const InputDecoration(
                        hintText: "Typing ..........",
                        hintStyle: TextStyle(color: textfieldGrey),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: textfieldGrey,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: textfieldGrey,
                        ))),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      color: textfieldGrey,
                      size: 30,
                    ))
              ],
            )
                .box
                .height(70)
                .padding(const EdgeInsets.all(10))
                .margin(const EdgeInsets.only(bottom: 10))
                .make()
          ],
        ),
      ),
    );
  }
}
