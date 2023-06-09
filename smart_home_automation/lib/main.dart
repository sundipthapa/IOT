import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'FanControl.dart';
// import 'LightControl.dart';
// import 'SensorControl.dart';
// import 'apptheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> images = [
    "assets/1.jpg",
    "assets/2.jpg",
    "assets/2.jpg",
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            widget.title,
            style: AppTheme.myGlobalTextStyle,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications_active,
                  color: Color(0xFF7a6bbc)),
              tooltip: 'Notifications',
              onPressed: () {},
            ), //IconButton
            //IconButton
          ],
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color(0xFF7a6bbc),
            ),
            tooltip: 'Home',
            onPressed: () {},
          )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 150,
                    initialPage: 0,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.95,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: images.map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(image),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: images.asMap().entries.map((entry) {
                    int index = entry.key;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      child: Container(
                        width: 10,
                        height: 10,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(int index) {
    // Placeholder data for the cards (You can replace this with your own data)
    List<String> images = [
      'assets/light_black.jpg',
      'assets/fan_black.jpg',
      'assets/thermometer.webp',
      'assets/flame_black.jpg',
      'assets/gas_black.jpg',
      'assets/1.jpg',
    ];
    List<String> headings = [
      'Lights',
      'Fans',
      'DHT22 Sensor',
      'Flame Sensor',
      'Gas Sensor',
      'PIR Sensor',
    ];
    List<String> subheadings = [
      'Total Number : 1',
      'Total Number : 2',
      'Total Number : 3',
      'Total Number : 4',
      'Total Number : 5',
      'Total Number : 6',
    ];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(images[index], height: 80, width: 100),
          SizedBox(height: 10),
          Text(
            headings[index],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(subheadings[index]),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
