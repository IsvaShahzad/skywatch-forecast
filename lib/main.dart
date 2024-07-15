// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:video_player/video_player.dart';
// import 'weather_bloc.dart';
// import 'event.dart';
// import 'state.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: BlocProvider(
//         create: (context) => WeatherBloc(),
//         child: WeatherScreen(),
//       ),
//     );
//   }
// }
//
// class WeatherScreen extends StatefulWidget {
//   @override
//   _WeatherScreenState createState() => _WeatherScreenState();
// }
//
// class _WeatherScreenState extends State<WeatherScreen> {
//   final cityController = TextEditingController();
//   late VideoPlayerController _videoController;
//
//   @override
//   void initState() {
//     super.initState();
//     _videoController = VideoPlayerController.asset('assets/videos/3.mp4')
//       ..setLooping(true)
//       ..initialize().then((_) {
//         setState(() {
//           _videoController.play(); // Start playing the video
//           _videoController.setVolume(0.0); // Mute the video
//         });
//       }).catchError((error) {
//         print('Error initializing video player: $error');
//       });
//   }
//
//   @override
//   void dispose() {
//     _videoController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final weatherBloc = BlocProvider.of<WeatherBloc>(context);
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Fullscreen video background
//           Positioned.fill(
//             child: FittedBox(
//               fit: BoxFit.cover,
//               child: SizedBox(
//                 width: _videoController.value.size.width,
//                 height: _videoController.value.size.height,
//                 child: VideoPlayer(_videoController),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               children: <Widget>[
//                 SizedBox(height:40,),
//                     Text('Forecast Finder', style: TextStyle( fontFamily: 'Montserrat',
//                         fontSize: 30, color: Colors.white, fontWeight: FontWeight.w400),),
//                 SizedBox(height: 30),
//
//                 Padding(
//                   padding: const EdgeInsets.all(1.0),
//                   child: TextField(
//                     controller: cityController,
//                     style: TextStyle(
//                       fontFamily: 'Montserrat',
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                     decoration: InputDecoration(
//                       hintText: 'Enter city name',
//                       hintStyle: TextStyle(
//                         fontFamily: 'Montserrat',
//                         fontSize: 14,
//                         color: Colors.grey,
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(26.0),
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(26.0),
//                         borderSide: BorderSide(color: Colors.white, width: 2.0),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(26.0),
//                         borderSide: BorderSide(color: Colors.white, width: 1.0),
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(Icons.search, color: Colors.blue),
//                         onPressed: () {
//                           weatherBloc.add(FetchWeather(cityController.text));
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 70),
//                 BlocBuilder<WeatherBloc, WeatherState>(
//                   builder: (context, state) {
//                     if (state is WeatherInitial) {
//                       return Center(
//                         child: Text(
//                           'Looking for weather updates? We got you!',
//                           style: TextStyle(fontFamily: 'Montserrat', color: Colors.white),
//                         ),
//                       );
//                     } else if (state is WeatherLoading) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (state is WeatherLoaded) {
//                       String emoji;
//                       if (state.weather.temperature >= 30) {
//                         emoji = '☀️'; // Sun emoji
//                       } else {
//                         emoji = '☁️'; // Cloud emoji
//                       }
//
//                       return Column(
//                         children: [
//                           Text(
//
//                             'City: ${state.weather.cityName}',
//                             style: TextStyle(fontSize: 22, color: Colors.white,fontFamily: 'Montserrat'),
//                           ),
//                           Text(
//                             'Temperature: ${state.weather.temperature} °C $emoji',
//                             style: TextStyle(fontSize: 22,color: Colors.white, fontFamily: 'Montserrat'),
//                           ),
//                         ],
//                       );
//                     } else if (state is WeatherError) {
//                       return Center(child: Text(state.message));
//                     } else {
//                       return Container();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/weatherscreen.dart';
import 'weather_bloc.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Set the splash screen as the home
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => WeatherBloc(),
            child: WeatherScreen(),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Ensures the stack takes the full screen
        children: <Widget>[
          Image.asset(
            'assets/images/Walden.png',
            fit: BoxFit.cover, // Makes the image cover the whole screen
          ),

        ],
      ),
    );
  }
}

