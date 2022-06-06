import 'package:flutter/material.dart';
import 'package:kintsugi/views/register.dart';

import '../main2.dart';

void main() {
  runApp(const ButtonApp());
}

class ButtonApp extends StatelessWidget {
  const ButtonApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        // title: 'Button Types',
      ),
      home: const Scaffold(
        body: ButtonTypesExample(),
      ),
    );
  }
}

class ButtonTypesExample extends StatelessWidget {
  const ButtonTypesExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: const <Widget>[
          Spacer(),
          ButtonTypesGroup(enabled: true),
          //ButtonTypesGroup(enabled: false),
          Spacer(),
        ],
      ),
    );
  }
}

class ButtonTypesGroup extends StatelessWidget {
  const ButtonTypesGroup({Key key, this.enabled}) : super(key: key);

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    GlobalKey _LogInState = GlobalKey();

    final VoidCallback onPressed = enabled ? () {} : null;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        key: _LogInState,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
              child: Text(
                "Tạo Tài Khoản",
                style: TextStyle(
                    color: Color.fromRGBO(255, 210, 51, 1),
                    fontSize: 32,
                    height: 2),
              ),
            ),
          ),
          Text(
            "Tình Trạng của bạn là gì",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                // height: 4,
                fontWeight: FontWeight.w400),
          ),

          SizedBox(
            width: 300.0, // <-- match_parent
            height: 50, // <
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(_LogInState.currentContext,
                    MaterialPageRoute(builder: (context) {
                  return FormValidation();
                }));
              },
              child: const Text(
                'Khiếm thị',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            width: 300.0, // <-- match_parent
            height: 50, // <
            child: OutlinedButton(
                onPressed: () {
                  Navigator.push(_LogInState.currentContext,
                      MaterialPageRoute(builder: (context) {
                    return FormValidation();
                  }));
                },
                child: const Text('Khiếm thính',
                    style: TextStyle(color: Colors.black, fontSize: 20))),
          ),
          SizedBox(
            width: 300.0, // <-- match_parent
            height: 50, // <
            child: OutlinedButton(
                onPressed: () {
                  Navigator.push(_LogInState.currentContext,
                      MaterialPageRoute(builder: (context) {
                    return FormValidation();
                  }));
                },
                child: const Text('Rối loạn tăng động, giảm chú ý',
                    style: TextStyle(color: Colors.black, fontSize: 20))),
          ),
          SizedBox(
            width: 300.0, // <-- match_parent
            height: 50, // <
            child: OutlinedButton(
                onPressed: () {
                  Navigator.push(_LogInState.currentContext,
                      MaterialPageRoute(builder: (context) {
                    return FormValidation();
                  }));
                },
                child: const Text('Chứng khó đọc (đang phát triển',
                    style: TextStyle(color: Colors.black, fontSize: 20))),
          ),
          SizedBox(
            width: 300.0, // <-- match_parent
            height: 50, //
            child: OutlinedButton(
                onPressed: () {
                  Navigator.push(_LogInState.currentContext,
                      MaterialPageRoute(builder: (context) {
                    return FormValidation();
                  }));
                },
                child: const Text('Không có khiếm khuyết',
                    style: TextStyle(color: Colors.black, fontSize: 20))),
          ),

          // // Use an ElevatedButton with specific style to implement the
          // // 'Filled' type.
          // OutlinedButton(
          //   style: ElevatedButton.styleFrom(
          //     // Foreground color
          //     onPrimary: Theme.of(context).colorScheme.onPrimary,
          //     // Background color
          //     primary: Theme.of(context).colorScheme.primary,
          //   ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          //   onPressed: onPressed,
          //   child: const Text('Khiếm thính'),
          // ),

          // // Use an ElevatedButton with specific style to implement the
          // // 'Filled Tonal' type.
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     // Foreground color
          //     onPrimary: Theme.of(context).colorScheme.onSecondaryContainer,
          //     // Background color
          //     primary: Theme.of(context).colorScheme.secondaryContainer,
          //   ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          //   onPressed: onPressed,
          //   child: const Text('Rối loạn tăng động, giảm chú ý '),
          // ),

          // OutlinedButton(
          //     onPressed: onPressed,
          //     child: const Text('Chứng khó đọc (đang phát triển) ')),

          // OutlinedButton(
          //     onPressed: onPressed, child: const Text('Không có khuyết điểm')),
        ],
      ),
    );
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     const appTitle = "Tạo Tài Khoản";
//     return MaterialApp(
//       title: appTitle,
//       theme: ThemeData(colorSchemeSeed: const Color(0xff6750a4)),
//       home:
//           // FormValidation(),
//           const Scaffold(
//         body: MyHomePage(),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(132.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: const <Widget>[
//           Spacer(),
//           ButtonTypesGroup(enabled: true),
//           ButtonTypesGroup(enabled: false),
//           Spacer(),
//           Text(
//             "Tạo Tài Khoản",
//             style: TextStyle(color: Colors.yellow, fontSize: 32, height: 2),
//           ),
//           Text(
//             "Tình Trang của bạn là gì",
//             style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 24,
//                 height: 4,
//                 fontWeight: FontWeight.w400),
//           ),

         
//         ],
//       ),
    
//     );
//   }
// }

// class ButtonTypesGroup extends StatelessWidget {
//   const ButtonTypesGroup({Key? key, required this.enabled}) : super(key: key);
// }
//       // ElevatedButton(
//       //       onPressed: null,
//       //       child: Text("Khiem Thi"),
//       //       style: ButtonStyle(),
//       //     ),
//       //     ElevatedButton(
//       //       onPressed: null,
//       //       child: Text("Khiem Thính"),
//       //       style: ButtonStyle(),
//       //     ),
//       //     ElevatedButton(
//       //       onPressed: null,
//       //       child: Text("Rối loạn tăng động khó chú ý"),
//       //       style: ButtonStyle(),
//       //     ),
//       //     ElevatedButton(
//       //       onPressed: null,
//       //       child: Text("Chứng khó đọc (đang phát triển)"),
//       //       style: ButtonStyle(),
//       //     ),
//       //     ElevatedButton(
//       //       onPressed: null,
//       //       child: Text("Bình Thường"),
//       //       style: ButtonStyle(),
//       //     ),