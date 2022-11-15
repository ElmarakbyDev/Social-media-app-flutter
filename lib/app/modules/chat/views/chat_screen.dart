import 'package:flutter/material.dart';
import 'package:future_chat/core/resourses/styles_manger.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../../core/resourses/color_manger.dart';
import '../../../../core/resourses/font_manger.dart';
import '../../../../core/services/chat/private/private_chat.dart';
import '../../../data/models/private_chat_message.dart';
import 'widgets/attachment.dart';
import 'widgets/build_msg.dart';

class ChatScreen extends StatelessWidget {
  String myId, hisId, hisName, hisImage, myName, myImage;

  ChatScreen(
      {super.key,
      this.myId = '',
      this.hisId = '',
      this.hisName = '',
      this.hisImage = '',
      this.myImage = '',
      this.myName = ''});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PrivateMessage>>.value(
      value: PrivateChatService(
        hisId: hisId,
        myId: myId,
      ).getLivePrivateMessage,
      initialData: const [],
      child: ChatScreenX(
        myId: myId,
        hisId: hisId,
        hisName: hisName,
        myImage: myImage,
        myName: myName,
        hisImage: hisImage,
      ),
    );
  }
}

class ChatScreenX extends StatelessWidget {
  String myId, hisId, hisName, hisImage, myName, myImage;

  ChatScreenX(
      {this.myId = '',
      this.hisId = '',
      this.hisName = '',
      this.hisImage = '',
      this.myImage = '',
      this.myName = ''});

  @override
  Widget build(BuildContext context) {
    final getFluffs = Provider.of<List<PrivateMessage>>(context);
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(.1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Iconsax.video,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Iconsax.call,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text('View Contact'),
                ),
                const PopupMenuItem(
                  child: Text('Wallpaper'),
                ),
                const PopupMenuItem(
                  child: Text('Report'),
                ),
                const PopupMenuItem(
                  child: Text('Clear Chat'),
                ),
              ];
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
        title: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              child: Image.network(
                hisImage,
                fit: BoxFit.cover,
                height: 50,
                width: 50,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Iconsax.user,
                  color: ColorsManger.black,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              hisName == "" ? "no name" : hisName,
              style: getMediumTextStyle(
//fontSize: Dimensions.getDesirableWidth(5),
                fontSize: FontSize.xlarge,
                color: ColorsManger.black,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: getFluffs != null ? getFluffs.length : 0,
                  padding: const EdgeInsets.only(
                      //  bottom: Dimensions.getDesirableHeight(2.2),
                      //  right: Dimensions.getDesirableHeight(1.2),
                      // left: Dimensions.getDesirableHeight(1.2),
                      // top: Dimensions.getDesirableHeight(2.2)),
                      ),
                  itemBuilder: (context, index) {
                    final PrivateMessage? old = index != getFluffs.length - 1
                        ? getFluffs[index + 1]
                        : null;
                    final PrivateMessage msg = getFluffs[index];
                    bool isMe = msg.sender == myId;
                    return Column(
                      children: [
                        if (((old != null) &&
                                (msg.time?.day != old.time?.day ||
                                    msg.time?.month != old.time?.month)) ||
                            (index == getFluffs.length - 1))
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Card(
                                color: ColorsManger.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Text(
                                    '${msg.time?.day}/${msg.time?.month}/${msg.time?.year}',
                                    style: const TextStyle(
                                        color: ColorsManger.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                          )
                        else
                          const SizedBox(),
                        MessageBuilder(
                          msg: msg,
                          isMe: isMe,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Attachment(
                myId: myId,
                hisId: hisId,
                hisName: hisName,
                hisImage: hisImage,
                myImage: myImage,
                myName: myName,
              ).messageComposer(context),
            ],
          ),
        ),
      ),
    );
  }
}
