import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class ShowProfile extends StatefulWidget {
  Map data = {};
  ShowProfile({this.data});
  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  void _launchURL(BuildContext context, String url) async {
    try {
      await launch(
        url,
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn(),
          // or user defined animation.
          // animation: new CustomTabsAnimation(
          //   startEnter: 'slide_up',
          //   startExit: 'android:anim/fade_out',
          //   endEnter: 'android:anim/fade_in',
          //   endExit: 'slide_down',
          // ),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // get data from first page
    widget.data = ModalRoute.of(context).settings.arguments;

    if (widget.data == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                  floating: true,
                  expandedHeight: 350.0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.all(5.0),
                    title: Text(widget.data["companyName"]),
                    background: new Image.network(widget.data["companyimage"],
                        fit: BoxFit.cover),
                  ),
                ),
              ];
            },
            body: ListView(children: <Widget>[
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "Description :" + "\n" + "\n" + widget.data["description"],
                    style: TextStyle(
                        fontSize: 20, color: Colors.black, wordSpacing: 3.0),
                  )),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "CEO :" + "\n" + "\n" + widget.data["ceo"],
                    style: TextStyle(
                        fontSize: 20, color: Colors.black, wordSpacing: 3.0),
                  )),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "Sector :" + "\n" + "\n" + widget.data["sector"],
                    style: TextStyle(
                        fontSize: 20, color: Colors.black, wordSpacing: 3.0),
                  )),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "Market Cap. :" +
                        "\n" +
                        "\n" +
                        widget.data["mktcap"] +
                        "Cr.",
                    style: TextStyle(
                        fontSize: 20, color: Colors.black, wordSpacing: 3.0),
                  )),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(8.0),
                child: Text(
                  "Visit Site :" + "\n",
                  style: TextStyle(
                      fontSize: 20, color: Colors.black, wordSpacing: 3.0),
                ),
              ),
              FlatButton(
                  onPressed: () {
                    //_launchURL(context, widget.data["website"]);
                    Navigator.pushNamed(context, '/web', arguments: {
                      'name':widget.data["companyName"] ,
                      'urls': widget.data["website"]
                    });
                  },
                  child: Text(
                    widget.data["website"],
                    style: TextStyle(
                        fontSize: 20, color: Colors.blue, wordSpacing: 3.0),
                  )),
            ])),
      );
    }
  }
}
