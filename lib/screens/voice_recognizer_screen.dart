import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kintsugi/screens/flashcard_screen.dart';
import 'package:kintsugi/screens/note_list_screen.dart';
import 'package:kintsugi/services/resource_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VoiceRecognizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accessibilityModes =
        Provider.of<ResourceManager>(context).accessibilityModes;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).home),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (accessibilityModes.contains(AccessibilityMode.VISUAL) ||
                  accessibilityModes.contains(AccessibilityMode.HEARING) ||
                  accessibilityModes.isEmpty) ...[
                ElevatedButton(
                  onPressed: () {
                    HapticFeedback.vibrate();
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return VoiceHome();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      AppLocalizations.of(context).startaNewRecording,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                ),
                SizedBox(height: 32.0),
              ],
              if (accessibilityModes.contains(AccessibilityMode.VISUAL) ||
                  accessibilityModes.contains(AccessibilityMode.HEARING) ||
                  accessibilityModes.isEmpty) ...[
                ElevatedButton(
                  onPressed: () {
                    HapticFeedback.vibrate();
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return NoteListScreen();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      AppLocalizations.of(context).viewNoteList,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                ),
                SizedBox(height: 32.0),
              ],
              if (accessibilityModes.contains(AccessibilityMode.ADHD) ||
                  accessibilityModes.isEmpty)
                ElevatedButton(
                  onPressed: () {
                    HapticFeedback.vibrate();
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return FlashcardScreen();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      AppLocalizations.of(context).viewFlashCards,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                ),
              // SizedBox(height: 32.0),
              // ElevatedButton(
              //   onPressed: () {
              //     HapticFeedback.vibrate();
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return VoiceHome();
              //     }));
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 16.0),
              //     child: Text(
              //       "Reminder",
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 24.0,
              //       ),
              //     ),
              //   ),
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(Colors.indigo),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpeechRecognize extends StatefulWidget {
  @override
  _SpeechRecognizeState createState() => _SpeechRecognizeState();
}

class _SpeechRecognizeState extends State {
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
                : "Your text is\n\n$transcription",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(255, 210, 51, 1),
              fontSize: 20,
            ),
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
            TextButton(
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
  String resultText = "";

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).startaNewRecording),
        backgroundColor: Colors.indigo,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 28.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 15.0,
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).newNote,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SingleChildScrollView(
                        reverse: true,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(
                            30.0,
                            30.0,
                            30.0,
                            150.0,
                          ),
                          child: GestureDetector(
                            onDoubleTap: () {
                              print("double press clicked");
                            },
                            child: Text(
                              resultText,
                              // words: _highlights,
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100.0,
                    width: 100.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        child: Icon(Icons.cancel),
                        mini: true,
                        backgroundColor:
                            _isListening ? Colors.blue : Colors.grey,
                        onPressed: _isListening
                            ? () => _speechRecognition.cancel().then(
                                  (result) => setState(() {
                                    _isListening = result;
                                    resultText = "";
                                  }),
                                )
                            : null,
                      ),
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
                            _speechRecognition.listen(locale: "en_US").then(
                                  (result) => print('$result'),
                                );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100.0,
                    width: 100.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        child: Icon(Icons.stop),
                        mini: true,
                        backgroundColor:
                            _isListening ? Colors.red : Colors.grey,
                        onPressed: _isListening
                            ? () => _speechRecognition.stop().then(
                                  (result) => setState(
                                    () => _isListening = result,
                                  ),
                                )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
  }
}
