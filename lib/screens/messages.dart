import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_app/constants/colors.dart';
import 'package:sales_app/controllers/addController.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/controllers/chatController.dart';
import 'package:sales_app/functions/function.dart';
import 'package:sales_app/models/chat.dart';
import 'package:sales_app/screens/chat.dart';
import 'package:sales_app/screens/contacts.dart';

class Messages extends StatelessWidget {
  Messages({super.key});
  // User? user = FirebaseAuth.instance.currentUser;
  AddController addController = Get.find<AddController>();
  ChatController chatController = Get.find<ChatController>();
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await authController.fetchAllUsers();
                Get.to(Contacts());
              },
              child: Icon(Icons.message),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: CustomColors().primary,
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 18.0),
                            child: Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        Center(
                            child: Text(
                          "My Chats",
                          style: GoogleFonts.lato(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 6, 14, 18)),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Text("")
                    //  ListView.builder(
                    //     itemCount: chatController.chatList.length,
                    //     shrinkWrap: true,
                    //     // physics: const ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    //     itemBuilder: (context, index) {
                    //       ChatModel chat =
                    //           chatController.chatList.elementAt(index);
                    //       return InkWell(
                    //         onTap: () {
                    //           Get.to(Chat(
                    //             index: index,
                    //           ));
                    //         },
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(bottom: 10.0),
                    //           child: ListTile(
                    //             title: Text("${chat.recieverName}"),
                    //             autofocus: true,
                    //             subtitle: Text("${chat.Message}"),
                    //             trailing: Text(chat.Time.toString()),
                    //             leading: CircleAvatar(
                    //                 backgroundImage:
                    //                     NetworkImage("${chat.recieverImg}")),
                    //           ),
                    //         ),
                    //       );
                    //     }),
               
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                  ),
                ],
              ),
            )));
  }
}
