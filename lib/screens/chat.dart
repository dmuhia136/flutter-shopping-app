import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales_app/controllers/chatController.dart';
import 'package:sales_app/functions/function.dart';
import 'package:sales_app/models/user.dart';

// ignore: must_be_immutable
class Chat extends StatelessWidget {
  int index;
  bool? sent = true;
  UserModel? user;
  Chat({super.key, required this.index, this.user});
  ChatController chatController = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Row(children: [TextField()],),

      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user!.profileimage.toString()),
            ),
            SizedBox(
              width: 20,
            ),
            Text("${user!.firstname} ${user!.lastname}"),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black12,
              child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (contex, index) {
                    index % 2 == 0 ? sent = true : sent = false;
                    return Align(
                        alignment: sent == true
                            ? Alignment.bottomRight
                            : Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 100,
                            decoration: BoxDecoration(
                                color:
                                    sent == true ? Colors.blue : Colors.yellow,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: sent == true
                                        ? Radius.circular(10)
                                        : Radius.circular(0),
                                    topRight: sent == true
                                        ? Radius.circular(0)
                                        : Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello $sent $index",
                                    maxLines: 4,
                                    style: TextStyle(wordSpacing: 0.5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: chatController.messageController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 8.0),
                    hintText: 'Enter message here',
                    filled: true,
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    XFile? data = await chatController.picker
                        .pickImage(source: ImageSource.gallery);
                    chatController.imageUrl =
                        await Functions().uploadImage(data!.path, data.name);
                  },
                  icon: Icon(Icons.image)),
              InkWell(
                onTap: () {
                  chatController.sendMessage(user);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[500],
                      borderRadius: BorderRadius.circular(20)),
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: chatController.isSending.value == true
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : const Text("Send"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
