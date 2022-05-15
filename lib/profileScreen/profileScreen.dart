import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:watch_store/constants.dart';
import 'package:path/path.dart';
import 'package:watch_store/orderHistoryScreen/orderHistoryScreen.dart';
import 'package:watch_store/profileScreen/passwordMangerScreen.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profileScreen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String email;
  File? image;
  late String name;
  late String imageUrl;
  late String phone;

  Future fetchUserData() async {
    final firebaseUer = await FirebaseAuth.instance.currentUser;
    if (firebaseUer != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUer.uid)
          .get()
          .then((user) {
        email = user.data()!['email'];
        imageUrl = user.data()!['userImageUrl'];
        name = user.data()!['username'];
        phone = user.data()!['phone'];
      }).catchError((e) {
        //print(e.toString());
      });
    }
  }

  Future updateUser() async {
    final firebaseUer = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUer?.uid)
        .update({
      'username': name,
      'userImageUrl': imageUrl,
    });
  }

  get _getAppDir async {
    final appDir = await getApplicationDocumentsDirectory();
    return appDir.path;
  }

  Future pickImage(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 60);
      if (image == null) return;
      // final String path = _getAppDir();
      final imageTemp = File(image.path);

      setState(() {
        this.image = imageTemp;
      });
      final ref = FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child(FirebaseAuth.instance.currentUser!.uid);
      await ref.putFile(imageTemp);
      imageUrl = await ref.getDownloadURL();
      updateUser();
      setState(() {
        imageUrl;
      });
    } on PlatformException catch (e) {
      print(e);
      // print('Failed to pick image: $e');
    }
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () => Navigator.of(context).pop(ImageSource.camera),
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Gallery'),
                  onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                )
              ],
            ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                "Profile",
                style: kTextAppBarTitle,
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: fetchUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    const SizedBox(height: 30),
                    Stack(
                      clipBehavior: Clip.antiAlias,
                      // overflow: Overflow.visible,
                      children: [
                        imageUrl.isNotEmpty
                            ? ClipOval(
                                child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ))
                            : ClipOval(
                                child: Image.asset(
                                'assets/images/armani-1.jpg',
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              )),
                        Positioned(
                            left: ScreenUtil().setWidth(70),
                            top: 67.h,
                            child: GestureDetector(
                              onTap: () async {
                                final source = await showImageSource(context);
                                if (source == null) return;

                                pickImage(source);
                              },
                              child: CircleAvatar(
                                  radius: (15),
                                  backgroundColor: kPrimaryColor,
                                  child: ClipRRect(
                                    child: Image.asset(
                                      "assets/images/camera-white.png",
                                      height: 16,
                                      width: 16,
                                    ),
                                  )),
                            ))
                      ],
                    ),
                    ListTile(
                      title: Center(
                        child: Text(
                          name,
                          style: kTextAppBarTitle,
                        ),
                      ),
                      subtitle: Center(child: Text(email)),
                    ),
                    const SizedBox(height: 15),
                    ListTile(
                      onTap: () => pushNewScreen(context,
                          screen: PasswordScreen(), withNavBar: false),
                      title: const Text(
                        "Password Manager",
                        style: kTextAppBarTitle,
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            pushNewScreen(context,
                                screen: PasswordScreen(), withNavBar: false);
                          },
                          icon: const Icon(Icons.arrow_forward_ios, size: 17)),
                    ),
                    ListTile(
                      title: const Text(
                        "My Addresses",
                        style: kTextAppBarTitle,
                      ),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios, size: 17)),
                    ),
                    ListTile(
                      onTap: () {
                        pushNewScreen(context,
                            screen: const OrderHistoryScreen(),
                            withNavBar: false);
                      },
                      title: const Text(
                        "My Orders",
                        style: kTextAppBarTitle,
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            pushNewScreen(context,
                                screen: const OrderHistoryScreen(),
                                withNavBar: false);
                          },
                          icon: const Icon(Icons.arrow_forward_ios, size: 17)),
                    ),
                    ListTile(
                      title: const Text(
                        "Articles",
                        style: kTextAppBarTitle,
                      ),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios, size: 17)),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  // Future<File> saveImagePermanently(String path) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(path);
  //   final image = File('${directory.path}/$name');
  //   return File(path).copy(image.path);
  // }
}
