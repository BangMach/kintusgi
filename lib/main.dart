import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:highlight_text/highlight_text.dart';
// import 'package:speech_recognition/speech_recognition.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VoiceHome(),
      // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class VoiceHome extends StatefulWidget {
  // @override
  // _SpeechScreenState createState() => _SpeechScreenState();

  @override
  _VoiceHomeState createState() => _VoiceHomeState();
    // TODO: implement createState
    // throw UnimplementedError();


}

class _VoiceHomeState extends State<VoiceHome> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false; // if we are available to interact with it
  bool _isListening = false; // is the mircophone being used
  String _currentLocale= "";
  String resultText=  "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechRecognizer();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:  CrossAxisAlignment.center,
          children: <Widget>[Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              FloatingActionButton(
                  child: Icon(Icons.cancel),
                  mini:true,
                  backgroundColor: Colors.deepOrange,
                  onPressed: (){
                    if (_isListening)
                      _speechRecognition.cancel().then(
                            (result) => setState(() {
                          _isListening = result;
                          resultText = "";
                        }),
                      );
                  }),
              FloatingActionButton(
                  child: Icon(Icons.mic),
                  onPressed: (){
                    if (_isAvailable && !_isListening)
                      _speechRecognition
                          .listen()
                          .then((result) => print('$result'));
                  }),
              FloatingActionButton(
                  child: Icon(Icons.stop),
                  mini:true,
                  backgroundColor: Colors.deepPurple,
                  onPressed: (){
                    if (_isListening)
                      _speechRecognition.stop().then(
                            (result) => setState(() => _isListening = result),
                      );                  }),
            ]
        ),
        Container(
            width: MediaQuery.of(context).size.width *0.6,
            decoration: BoxDecoration(
              color: Colors.cyanAccent[100],
              borderRadius: BorderRadius.circular((6.9))
            ),
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
            child: Text(resultText),)
          ],
          )
      ),
    );
    // throw UnimplementedError();
  }
  // Language selectedLang = languages.first;

  // void start() => _speechRecognition.activate(selectedLang.code).then((_) {
  //   return _speech.listen().then((result) {
  //     print('_MyAppState.start => result $result');
  //     setState(() {
  //       _isListening = result;
  //     });
  //   });
  // });

  // void onCurrentLocale(String locale) {
  //   print('_MyAppState.onCurrentLocale... $locale');
  //   setState(
  //           () => selectedLang = languages.firstWhere((l) => l.code == locale));
  // }

  void onSpeechAvailability(bool result) =>
      setState(() => _isAvailable = result);

  void onRecognitionComplete(String text) {
    print('_MyAppState.onRecognitionComplete... $text');
    setState(() => _isListening = false);
  }

  void onRecognitionStarted() {
    setState(() => _isListening = true);
  }

  void onRecognitionResult(String text) {
    print('_MyAppState.onRecognitionResult... $text');
    setState(() => resultText = text);
  }

  void errorHandler() => activateSpeechRecognizer();
  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler(onSpeechAvailability);
    _speechRecognition.setRecognitionStartedHandler(onRecognitionStarted);
    _speechRecognition.setRecognitionResultHandler(onRecognitionResult);
    _speechRecognition.setRecognitionCompleteHandler(onRecognitionComplete);
    _speechRecognition.setErrorHandler(errorHandler);
    _speechRecognition.activate('vi_VN').then((res) {
      setState(() => _isAvailable = res);
    });
  }
  void initSpeechRecognizer() {
    // _speechRecognition = SpeechRecognition();
    // _speechRecognition.setAvailabilityHandler((bool result) =>setState(() => _isAvailable = result));
    //
    // _speechRecognition.setRecognitionStartedHandler(() => setState(() => _isListening = true));
    //
    // _speechRecognition.setRecognitionResultHandler((String speech) async => setState(() => resultText = speech));
    //
    // _speechRecognition.setRecognitionCompleteHandler(onRecognitionComplete);

    // _speechRecognition.setRecognitionCompleteHandler(()=> setState(()=>_isListening =false));

    activateSpeechRecognizer();

    // _speechRecognition.activate().then((result) => setState(()=> _isAvailable = result),);
    // _speechRecognition.setCurrentLocaleHandler((String locale) =>
    //     setState(() => _currentLocale = locale));
  }


}


class SpeechScreen extends StatefulWidget{
  @override
  _SpeechScreenState createState() => _SpeechScreenState();

}

class _SpeechScreenState extends State<SpeechScreen>{
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight:  FontWeight.bold,
    ),
    ),
    'like': HighlightedWord(
      onTap: () => print('subcribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight:  FontWeight.bold,
      ),
    ),
    'accessibility': HighlightedWord(
      onTap: () => print('accessibility'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight:  FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Press the button and start speaking";
  double _cofidence = 1.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Confidence Level is: ${(_cofidence*100.0).toStringAsFixed(1)}%"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
       animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        child: FloatingActionButton(
          onPressed:_listen,
          child: Icon(_isListening ? Icons.mic: Icons.mic_none)
        )
    ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: GestureDetector(
            onDoubleTap: (){
              print("double press clicked");

            },
            child:Text(
              _text
            // words: _highlights,
            // textStyle: const TextStyle(
            //   fontSize: 32.0,
            //   color: Colors.black,
            //   fontWeight: FontWeight.w400,
          )

            ,
          )

          )
        )
      );

    // throw UnimplementedError();
  }


  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) =>
              setState(() {
                _text = val.recognizedWords;
                if (val.hasConfidenceRating && val.confidence > 0) {
                  _cofidence = val.confidence;
                }
              }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
