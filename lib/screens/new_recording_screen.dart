import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kintsugi/models/note_model.dart';
import 'package:kintsugi/screens/editors/edit_note_screen.dart';
import 'package:kintsugi/services/resource_manager.dart';
import 'package:kintsugi/widgets/custom/show_exception_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewRecordingScreen extends StatefulWidget {
  @override
  _NewRecordingScreenState createState() => _NewRecordingScreenState();
}

class _NewRecordingScreenState extends State<NewRecordingScreen> {
  SpeechRecognition _speechRecognition;

  bool _hasError = false;
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
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        _isListening ? Colors.blue : Colors.grey,
                      ),
                    ),
                    onPressed: _isListening
                        ? () => _speechRecognition.cancel().then(
                              (result) => setState(() {
                                _isListening = result;
                                resultText = "";
                              }),
                            )
                        : null,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                      child: Icon(
                        Icons.cancel,
                        size: 28.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        (_isAvailable && !_isListening)
                            ? Colors.indigo
                            : Colors.grey,
                      ),
                    ),
                    onPressed: (_isAvailable && !_isListening)
                        ? () {
                            _speechRecognition.listen(locale: "en_US").then(
                                  (result) => print('$result'),
                                );
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20.0,
                      ),
                      child: Icon(
                        Icons.mic,
                        size: 40.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        _isListening ? Colors.red : Colors.grey,
                      ),
                    ),
                    onPressed: _isListening
                        ? () => _speechRecognition.stop().then(
                              (result) => setState(
                                () => _isListening = result,
                              ),
                            )
                        : null,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                      child: Icon(
                        Icons.stop,
                        size: 28.0,
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

  void handleAvailability(bool result) async {
    setState(() {
      _isAvailable = result;
    });

    if (!result && (resultText == null || resultText.isEmpty)) {
      if (_hasError) return;
      await _speechRecognition.stop();
      setState(() {
        _hasError = true;
        _isListening = false;
      });
      await showExceptionAlertDialog(
        context,
        exception: Exception(
          'Speech recognition not available',
        ),
      );
    }
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler(handleAvailability);

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(
        () => _isListening = true,
      ),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) async => setState(
        () => resultText = speech,
      ),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () {
        _speechRecognition.stop();
        setState(() => _isListening = false);
        if (resultText == null || resultText.isEmpty) return;

        final resourceManager = Provider.of<ResourceManager>(context);
        final newNote = Note(
          id: resourceManager.getNextNoteId(),
          title: "",
          content: resultText,
          createdAt: DateTime.now(),
        );

        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => EditNoteScreen(
              note: newNote,
              resourceManager: resourceManager,
              onDelete: () {},
            ),
          ),
        );

        resultText = "";
      },
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }
}
