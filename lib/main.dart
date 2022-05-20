import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(){
  runApp(
    MaterialApp(
    title: "Weather App",
    home: Home(),
  ));
}
class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var temp;
  var description;
  var current;
  var humidity;
  var windSpeed;
  var country;
  var division;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=sylhet&appid=0dd63a91865963b51df0326fd40caa75"));
    var results = jsonDecode(response.body); 
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results["weather"][0]["description"];
      this.current = results["weather"][0]["main"];
      this.humidity = results["main"]["humidity"];
      this.windSpeed = results["wind"]["speed"];
      this.country = results["sys"]["country"];
      this.division = results["name"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:EdgeInsets.all(10.0),
                  child: Text(
                    "Currently in Sylhet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                   ),
                   Text(
                     temp != null ? temp.toString()+"\u00B0" : "Loading",
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 40.00,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                   Padding(
                  padding:EdgeInsets.all(10.0),
                  child: Text(
                    current != null? current.toString():"Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                   ),
              ],
    
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text(temp != null ? temp.toString()+"\u00B0" : "Loading",),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(description != null ? description.toString():"Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("TemperaHumidityture"),
                    trailing: Text(humidity != null ? humidity.toString():"Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(windSpeed != null ? windSpeed.toString():"Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.flag),
                    title: Text(country != null ? country.toString() : "Loading"),
                    trailing: Text(division != null ? division.toString():"Loading"),
                  ),
                ],
              ),
              ),
              ),
        ],
        
      )
      ),
    );
  }
}