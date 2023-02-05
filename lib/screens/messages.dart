import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_app/controllers/addController.dart';
import 'package:sales_app/screens/chat.dart';

class Messages extends StatelessWidget {
  Messages({super.key});
  User? user = FirebaseAuth.instance.currentUser;
  AddController addController = Get.find<AddController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {
            
          },child: Icon(Icons.message),),
            body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.tealAccent,
            width: MediaQuery.of(context).size.width * 1.0,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Center(
                child: Text(
              "My Chats",
              style: GoogleFonts.lato(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 6, 14, 18)),
            )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: ListView.builder(
                itemCount: 20,
                shrinkWrap: true,
                // physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  return InkWell(onTap: () {
                    Get.to(Chat(index: index,));
                  },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text("Dennis Muhia $index"),
                        autofocus: true,
                        subtitle: Text("Today message $index"),
                        trailing: Text("Now"),
                        leading: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/profile.png")),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    )));
  }
}
