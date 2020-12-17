import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/city.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/model/weather.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CityData> cities = [];
  List<WeatherData> weathers = [];
  bool isLoading = true;
  List<bool> isSelected;
  String selectedCity;
  String selectedProvince = "Province";
    
  String temp = "27";
  String date = "2020-12-17";
  String cuaca = "Berawan";
  String code = "5";

  WeatherData weatherData1;
  WeatherData weatherData2;
  WeatherData weatherData3;
  WeatherData weatherData4;

  loadCities() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get('https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json');
    if(response.statusCode == 200){
      var citiesResponse = json.decode(response.body);
      var items = citiesResponse as List;
      if (items.length > 0) {
        print("Success Get Cities");
        for(var i = 0; i < items.length; i++) {
          CityData city = CityData.fromJson(items[i]);
          cities.add(city);
        }
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  getWeather() async {
    final response = await http.get('https://ibnux.github.io/BMKG-importer/cuaca/'+selectedCity+'.json');
    if(response.statusCode == 200){
      var weatherResponse = json.decode(response.body);
      var items = weatherResponse as List;
      if (items.length > 0) {
        print("Success Get Weather");
        weathers.clear();
        for(var i = 0; i < items.length; i++) {
          WeatherData weather = WeatherData.fromJson(items[i]);
          weathers.add(weather);
        }
        setState(() {
          var currentweather = weathers[0];
          temp = currentweather.tempC;
          date = currentweather.jamCuaca.substring(0,10);
          cuaca = currentweather.cuaca;
          code = currentweather.kodeCuaca;

          if(isSelected[0]){
            weatherData1 = weathers[0];
            weatherData2 = weathers[1];
            weatherData3 = weathers[2];
            weatherData4 = weathers[3];
          } else{
            weatherData1 = weathers[4];
            weatherData2 = weathers[5];
            weatherData3 = weathers[6];
            weatherData4 = weathers[7];
          }

          isLoading = false;
        });
      }
    }

    
  }

  @override
  void initState() {
    super.initState();
    isSelected = [true, false];
    loadCities();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: DropdownButton(
                isExpanded: true,
                value: selectedCity,
                hint: Text("Select City"),
                onChanged: (newValue) {
                  setState(() {
                    selectedCity = newValue;
                    getWeather();               
                  });
                }, items: cities.map((CityData city){
                    return new DropdownMenuItem<String>(
                      value: city.id,
                      child: new Text(city.city),
                    );
                  }).toList(),
              )
            ),
            SizedBox(height: 50),
            Center(
              child: Column(
                children: [
                  Text(
                    '$temp\u2103',
                    style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$date',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$cuaca',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ),
            SizedBox(height: 10),
            Center(
              child: Image.network(
                "https://ibnux.github.io/BMKG-importer/icon/"+code+".png",
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Hari Ini',
                            style: TextStyle(fontSize: 16),
                        ),
                        ),
                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Besok',
                            style: TextStyle(fontSize: 16),
                        ),
                        ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected[buttonIndex] = !isSelected[buttonIndex];
                        } else {
                          isSelected[buttonIndex] = false;
                        }
                        
                      }
                      print(isSelected[0]);
                    });
                  },
                  isSelected: isSelected,
                ),
              ],
            ),
            SizedBox(height: 20),
            // Column(
            //   children: <Widget>[
            //     Expanded(
            //       flex: 1,
            //       child: Container(
            //         width: MediaQuery.of(context).size.width * 0.25,
            //         child: Center(child: Column(
            //           children:[
            //             Text("Oke")
            //           ]
            //         ),),
            //       ),
            //     ),
            //     Expanded(
            //       flex: 1,
            //       child: Container(
            //         width: MediaQuery.of(context).size.width * 0.25,
            //       ),
            //     ),
            //     Expanded(
            //       flex: 1,
            //       child: Container(
            //         width: MediaQuery.of(context).size.width * 0.25,
            //       ),
            //     ),
            //     Expanded(
            //       flex: 1,
            //       child: Container(
            //         width: MediaQuery.of(context).size.width * 0.25,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
