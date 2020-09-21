import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:weather/services/admobservice.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController state = TextEditingController();
  String sim_url =
      "http://api.openweathermap.org/data/2.5/weather?appid=ce92ed9fc19218fe2d3abb57ef42410b&q=";
  String temp = "";
  var tocelsius;
  String city = "";
  String condition = "";
  String feels = "";
  var tolike;
  String pressure = "";
  String humidity = "";
  var visi;
  String visibility = "";
  final ams = AdMobService();

  @override
  void initState() {
    super.initState();
    Admob.initialize(ams.getAdMobAppId());
  }

  Future<String> getJson() async {
    String url = sim_url + state.text;
    try {
      var response = await http
          .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
      setState(() {
        var convert = jsonDecode(response.body);
        tocelsius = convert['main']['temp'] - 273.15;
        temp = tocelsius.toStringAsFixed(1);
        city = state.text;
        condition = convert['weather'][0]['description'];
        tolike = convert['main']['feels_like'] - 273.15;
        feels = tolike.toStringAsFixed(2);
        pressure = convert['main']['pressure'].toString();
        humidity = convert['main']['humidity'].toString();
        visi = convert['visibility'] / 1000;
        visibility = visi.toStringAsFixed(1);
        state.text = "";
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("No Connection"),
              content: Text(
                  "Internet Connection not avalable\nor you entered wrong state name"),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.cloud,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Weather",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 5,
            ),
            Text("Dexa°A",
                style: GoogleFonts.pacifico(
                    textStyle: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue))),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              color: Colors.indigo,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 180,
                              child: TextField(
                                controller: state,
                                style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.cloud_circle),
                                  hintText: "Enter City Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 120,
                              child: RaisedButton(
                                onPressed: () {
                                  getJson();
                                },
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.search),
                                    Text("Search"),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      city,
                      style: TextStyle(letterSpacing: 2, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      temp + "°c",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(condition,
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: 2,
                                fontSize: 18)))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(WeatherIcons.thermometer),
                      title: Text("Feels_like"),
                      trailing: Text(feels + "°c"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: Icon(WeatherIcons.cloud),
                      title: Text("Pressure"),
                      trailing: Text(pressure + "mBar"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: Icon(WeatherIcons.humidity),
                      title: Text("Humidity"),
                      trailing: Text(humidity + "%"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: Icon(Icons.remove_red_eye),
                      title: Text("Visibility"),
                      trailing: Text(visibility + "Km"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),
          //ad here
          AdmobBanner(
            adUnitId: ams.getBannerAdId(),
            adSize: AdmobBannerSize.BANNER,
          ),
        ],
      ),
    );
  }
}
