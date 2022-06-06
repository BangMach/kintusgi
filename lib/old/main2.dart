import 'package:flutter/material.dart';
import 'package:kintsugi/screens/ListSearch.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  GlobalKey _scaffoldState = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text("Voice Recognizer"),
        ),
        body: Container(
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ignore: deprecated_member_use
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: RaisedButton(
                      onPressed: () {
                        HapticFeedback.vibrate();
                        Navigator.push(
                            _scaffoldState.currentContext ?? "default values",
                            MaterialPageRoute(builder: (context) {
                          return VoiceHome();
                        }));
                      },
                      child: Text(
                        "Start a new recording" ?? "default values",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Color.fromRGBO(255, 210, 51, 1)),
                ),

                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                      onPressed: () {
                        HapticFeedback.vibrate();
                        Navigator.push(_scaffoldState.currentContext,
                            MaterialPageRoute(builder: (context) {
                          return ListSearch();
                        }));
                      },
                      child: Text(
                        "View note list" ?? "some default value",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Color.fromRGBO(255, 210, 51, 1)),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: RaisedButton(
                      onPressed: () {
                        HapticFeedback.vibrate();
                        Navigator.push(
                            _scaffoldState.currentContext ?? "default values",
                            MaterialPageRoute(builder: (context) {
                          return Flashcard();
                        }));
                      },
                      child: Text(
                        "Flash Cards " ?? "default values",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Color.fromRGBO(255, 210, 51, 1)),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: RaisedButton(
                      onPressed: () {
                        HapticFeedback.vibrate();
                        Navigator.push(
                            _scaffoldState.currentContext ?? "default values",
                            MaterialPageRoute(builder: (context) {
                          return VoiceHome();
                        }));
                      },
                      child: Text(
                        "Reminder" ?? "default values",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Color.fromRGBO(255, 210, 51, 1)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpeachRecognize extends StatefulWidget {
  @override
  _SpeachRecognizeState createState() => _SpeachRecognizeState();
}

class _SpeachRecognizeState extends State {
  SpeechRecognition _speech;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';

  @override
  void initState() {
    super.initState();
    activateSpeechRecognizer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.yellow),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Speech To Text'),
          centerTitle: true,
          actions: [
            _buildVoiceInput(
              onPressed: _speechRecognitionAvailable && !_isListening
                  ? () => start()
                  : () => stop(),
              label: _isListening ? 'Listening...' : '',
            ),
          ],
        ),
        body: Center(
          child: Text(
            (transcription.isEmpty)
                ? "Speak to Record"
                : "Your text is \n\n$transcription",
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Color.fromRGBO(255, 210, 51, 1), fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildVoiceInput({String label, VoidCallback onPressed}) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            FlatButton(
              onPressed: () {},
              child: Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: onPressed,
            ),
          ],
        ));
  }

  void activateSpeechRecognizer() {
    requestPermission();

    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler((result) {
      setState(() {
        _speechRecognitionAvailable = result;
      });
    });
    _speech.setAvailabilityHandler(
        (bool result) => setState(() => _speechRecognitionAvailable = result));
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  void start() {
    _speech.listen(locale: 'en_US').then((result) {
      print('Started listening => result $result');
    });
  }

  void cancel() {
    _speech.cancel().then((result) {
      setState(() {
        _isListening = result;
      });
    });
  }

  void stop() {
    _speech.stop().then((result) {
      setState(() {
        _isListening = result;
      });
    });
  }

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) =>
      setState(() => print("current locale: $locale"));

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) {
    setState(() {
      transcription = text;
    });
  }

  void onRecognitionComplete() => setState(() => _isListening = false);

  void requestPermission() async {
    if (await Permission.microphone.request().isGranted) {
      print("there is no microphone permission");
    } else {
      print("still waiting for permission");
    }
  }
}

class VoiceHome extends StatefulWidget {
  @override
  _VoiceHomeState createState() => _VoiceHomeState();
}

class _VoiceHomeState extends State<VoiceHome> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false; // if we are available to interact with it
  bool _isListening = false; // is the mircophone being used
  String _currentLocale = "";
  String resultText = "";

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
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              child: SafeArea(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    Text(' New Note',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SingleChildScrollView(
                        reverse: true,
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(
                                30.0, 30.0, 30.0, 150.0),
                            child: GestureDetector(
                                onDoubleTap: () {
                                  print("double press clicked");
                                },
                                child: Text(resultText,
                                    // words: _highlights,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ))))),
                  ])),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              SizedBox(
                height: 100.0,
                width: 100.0,
                child: FittedBox(
                  child: FloatingActionButton(
                      child: Icon(Icons.cancel),
                      mini: true,
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        if (_isListening)
                          _speechRecognition.cancel().then(
                                (result) => setState(() {
                                  _isListening = result;
                                  resultText = "";
                                }),
                              );
                      }),
                ),
              ),
              SizedBox(
                height: 125.0,
                width: 125.0,
                child: FittedBox(
                  child: FloatingActionButton(
                      child: Icon(Icons.mic),
                      onPressed: () {
                        if (_isAvailable && !_isListening)
                          _speechRecognition
                              .listen(locale: "en_US")
                              .then((result) => print('$result'));
                      }),
                ),
              ),
              SizedBox(
                height: 100.0,
                width: 100.0,
                child: FittedBox(
                  child: FloatingActionButton(
                      child: Icon(Icons.stop),
                      mini: true,
                      backgroundColor: Colors.red,
                      onPressed: () {
                        if (_isListening)
                          _speechRecognition.stop().then(
                                (result) =>
                                    setState(() => _isListening = result),
                              );
                      }),
                ),
              ),
            ]),
          ],
        ),
      )),
    );
    // throw UnimplementedError();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler(
        (bool result) => setState(() => _isAvailable = result));

    _speechRecognition.setRecognitionStartedHandler(
        () => setState(() => _isListening = true));

    _speechRecognition.setRecognitionResultHandler(
        (String speech) async => setState(() => resultText = speech));

    _speechRecognition.setRecognitionCompleteHandler(
        () => setState(() => _isListening = false));

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
    _speechRecognition.setCurrentLocaleHandler(
        (String locale) => setState(() => _currentLocale = locale));
  }
}
