import 'dart:io';

import 'package:course_project/auth/fire_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key});

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String profilePicLink = " ";
  Image? profilePic;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: getUserImage(),
      builder: (context, snapshot){
        return SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                child: Center(
                      child: profilePic == null ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/images/NoProfileImage.png",
                          fit: BoxFit.cover,
                        ),
                      ) : ClipRRect(

                        borderRadius: BorderRadius.circular(100),
                        child: Image(image: profilePic!.image, fit: BoxFit.cover, height: 115,
                        width: 115,),
                      ),
                ),
              ),
              Positioned(
                right: -16,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.white),
                      ),
                      primary: Colors.white,
                      backgroundColor: Color(0xFFF5F6F9),
                    ),
                    onPressed: () {
                      pickUploadProfilePic();
                    },
                    child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 115,
      maxWidth: 115,
      imageQuality: 90,
    );
    if(image != null){
      var user = FireAuth.getCurrentUser();
      Reference ref = FirebaseStorage.instance
          .ref().child("profile-pic-id-${user.uid}.jpg");
      await ref.putFile(File(image!.path));
      String profilePicLink = await ref.getDownloadURL();
      setState(() {
        profilePic = Image.network(profilePicLink);
      });
    }
  }

  Future getUserImage() async {
    var user = FireAuth.getCurrentUser();
    try{
      Reference ref = FirebaseStorage.instance
          .ref().child("profile-pic-id-${user.uid}.jpg");
      String profilePicLink = await ref.getDownloadURL().catchError(print);
      setState(() {
        profilePic = Image.network(profilePicLink);
      });
    }
    catch(e){
      print("No profile pic found");
    }
  }
}
