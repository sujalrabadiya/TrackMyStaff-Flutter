import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:track_my_staff/Staff/screens/profileStaff.dart';
import 'package:track_my_staff/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      child: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: kGradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight))),
          ),
          Positioned(
            top: 90,
            bottom: -10,
            right: 30,
            left: 30,
            child: Card(
              elevation: 8,
              color: kBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                padding: const EdgeInsets.only(
                  top: 40,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text("TrackMyStaff",
                            style:
                                TextStyle(fontSize: 18, color: kPrimaryColor)),
                      ),
                      Text(
                        "App",
                        style: TextStyle(color: kSecondaryColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: () => UrlLaunch("https://play.google.com/store/apps/dev?id=8681532115153356174"), icon: FaIcon(FontAwesomeIcons.googlePlay),),
                          IconButton(onPressed: () => UrlLaunch("https://www.linkedin.com/in/sujal-rabadiya-0a173126a/"), icon: FaIcon(FontAwesomeIcons.linkedinIn),),
                          IconButton(onPressed: () => UrlLaunch("https://github.com/sujalrabadiya"), icon: FaIcon(FontAwesomeIcons.github)),
                        ],
                      ),
                      const Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Divider(
                          thickness: 0.5,
                          color: kDarkGreyColor,
                        ),
                      ),
                      ListTile(
                        subtitle: Text("Sujal Rabadiya (Apps by S)"),
                        title: Text(
                          "Developed by : ",
                          style: TextStyle(fontSize: 14, color: kPrimaryColor),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => UrlLaunch('mailto:developer.bys7@gmail.com?subject=About TrackMyStaff&body=Hi Apps by S,'),
                        child: ListTile(
                          title: Text(
                            "developer.bys7@gmail.com",
                            style: listTileText,
                          ),
                          leading: Icon(
                            Icons.email_outlined,
                            color: kPrimaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Share.share(
                              'Ease your field staff tracking with TrackMyStaff\nhttps://play.google.com/store/apps/details?id=developer.bys7.ToWhats1');
                        },
                        child: ListTile(
                          title: Text(
                            "Share App",
                            style: listTileText,
                          ),
                          leading: Icon(
                            Icons.share_outlined,
                            color: kPrimaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => UrlLaunch('https://play.google.com/store/apps/dev?id=8681532115153356174'),
                        child: ListTile(
                          title: Text(
                            "More Apps",
                            style: listTileText,
                          ),
                          leading: Icon(
                            Icons.apps_outlined,
                            color: kPrimaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => UrlLaunch('https://play.google.com/store/apps/details?id=developer.bys7.ToWhats1'),
                        child: ListTile(
                          title: Text(
                            "Rate App",
                            style: listTileText,
                          ),
                          leading: Icon(
                            Icons.star_outline,
                            color: kPrimaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width / 2 - 60,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  // "https://th.bing.com/th/id/OIP.5GNo3kfrO1-4sNfWUHLCSwHaHa?rs=1&pid=ImgDetMain",
                  "assets/images/app_icon.jpg",
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                )),
          )
        ],
      ),
    );
  }

  Future<void> UrlLaunch(String urlstring) async {
    final Uri _url = Uri.parse(urlstring);
    await launchUrl(_url, mode: LaunchMode.externalNonBrowserApplication);
  }
}
