import 'package:flutter/material.dart';
import 'package:listedcompany/API/companyname.dart';
import 'package:listedcompany/API/companyprofile.dart';
import 'package:listedcompany/Pages/co_profile.dart';



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

  void showdata(index, BuildContext context) async {
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
        appBar: AppBar(actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: CompanySearch(
                        companyname: data,
                        ));
              })
        ], centerTitle: true, title: Text('Listed Company In Market')),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    data[index]["name"],
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  subtitle:Text( symbol[index]),
                  onTap: () {
                    showdata(index, context);
                  },
                ),
              );
            }),
      );
    }
  }
}

class CompanySearch extends SearchDelegate<String> {
  List companyname;
 
  CompanySearch({this.companyname});

  void showdata(BuildContext context,String sym) async {
    // Get Company Profiles from API
    FetchProfile companyProfile = FetchProfile(sym);
    await companyProfile.getProfile();

    // Route and send data to second page
    Navigator.of(context).pushNamed('/second', arguments: {
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
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return ListTile(
      title: Text("No Record Found"+" "+"$query"),
      onTap: () {
       // showdata(index, context);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionCompany = query.isEmpty? companyname:
        companyname.where((p) => p["name"].toString().startsWith(query)).toList();
    return ListView.builder(
        itemCount: suggestionCompany.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: RichText(
                  text: TextSpan(
                      text: suggestionCompany[index]["name"].substring(0, query.length),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      children: [
                    TextSpan(
                        text: suggestionCompany[index]["name"].substring(query.length),
                        style: TextStyle(color: Colors.grey))
                  ])),
                  subtitle: Text(suggestionCompany[index]["symbol"]),
              onTap: () {
                showdata(context,suggestionCompany[index]["symbol"]);
              },
            ),
          );
        });
  }
}


