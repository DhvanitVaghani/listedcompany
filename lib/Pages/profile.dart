import 'package:flutter/material.dart';
import 'package:listedcompany/API/companyname.dart';
import 'package:listedcompany/API/companyprofile.dart';
import 'co_profile.dart';

class CompanyProfile extends StatefulWidget {
  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  List data;
  List<String> symbol;

  // Get name of companies from API
  void getData() async {
    GetCompanyName companyname = GetCompanyName();
    await companyname.getCompanyname();
    setState(() {
      data = companyname.data;
      symbol = companyname.symbol;
    });
  }

  void showdata(index) async {

    // Get Company Profiles from API
    FetchProfile companyProfile = FetchProfile(symbol[index]);
    await companyProfile.getProfile();
    
    // Route and send data to second page
    Navigator.pushNamed(context, '/second', arguments: {
      'companyName': companyProfile.data["companyName"],
      'description': companyProfile.data["description"],
      'companyimage': companyProfile.data["image"],
      'ceo': companyProfile.data["ceo"],
      'website': companyProfile.data["website"],
      'sector': companyProfile.data["sector"],
      'mktcap': companyProfile.data["mktCap"],
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        appBar: AppBar(centerTitle: true,title: Text('Listed Company In Market')),
        body: ListView.builder(itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              
              title: Text(
                data[index]["name"],
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
              subtitle: Text(symbol[index]),
              onTap: () {
                showdata(index);
              },
            ),
          );
        }),
      );
    }
  }
}
