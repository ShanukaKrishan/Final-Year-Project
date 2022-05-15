import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ripple_animation/ripple_animation.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:watch_store/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static String routeName = '/chatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const SliverAppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              elevation: 0,
              centerTitle: true,
              title: Text(
                "CONTACT  US",
                style: kTextAppBarTitle,
              ),
            )
          ];
        },
        body: Column(
          children: [
            const SizedBox(height: 20),
            const Text("Come chat with us 24/7", style: kHeadingTitle),
            const SizedBox(height: 150),
            const RippleAnimation(
              repeat: true,
              color: kPrimaryColor,
              minRadius: 50,
              ripplesCount: 6,
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 130),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    final client =
                        StreamChatClient('buvy5dm8f6vj', logLevel: Level.INFO);
                    await client.connectUser(
                      User(id: 'shanuka'),
                      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoic2hhbnVrYSJ9.hXkgsTIXLwisbAMvHNOeNIWcMlCDv3GV-A-4BlV7JxM',
                    );
                    final channel =
                        client.channel('messaging', id: 'ecommerce');
                    channel.watch();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => StreamChat(
                            client: client,
                            child: StreamChannel(
                              //showLoading: false,
                              channel: channel,
                              child: ChannelPage(),
                            ))));
                  },
                  child: const Text(
                    "CHAT",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: ChannelHeader(
          title: const Text(
            "Customer Service",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            const Expanded(
              child: MessageListView(),
            ),
            MessageInput(
              onMessageSent: (message) => print("send"),
            )
          ],
        ),
      ),
    );
  }
}
// Center(
// child: FlatButton(
// onPressed: () async {
// final client =
// StreamChatClient('buvy5dm8f6vj', logLevel: Level.INFO);
// await client.connectUser(
// User(id: 'shanuka'),
// 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoic2hhbnVrYSJ9.hXkgsTIXLwisbAMvHNOeNIWcMlCDv3GV-A-4BlV7JxM',
// );
// final channel = client.channel('messaging', id: 'ecommerce');
// channel.watch();
// Navigator.of(context).push(MaterialPageRoute(
// builder: (_) => StreamChat(
// client: client,
// child: StreamChannel(
// channel: channel,
// child: ChannelPage(),
// ))));
// },
// child: Text("click")),
// ),
