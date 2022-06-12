import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kintsugi/models/note_model.dart';
import 'package:kintsugi/screens/detailed_note_screen.dart';
import 'package:kintsugi/screens/editors/edit_note_screen.dart';
import 'package:kintsugi/services/resource_manager.dart';
import 'package:kintsugi/widgets/custom/show_exception_alert_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/locale_provider.dart';

class NoteListScreen extends StatefulWidget {
  @override
  State createState() {
    return NoteListScreenState();
  }
}

class NoteListScreenState extends State {
  bool _hasError = false;

  List<Note> _allNotes = [];
  List<Note> _filteredNotes = [];

  SpeechRecognition _speech;
  bool _speechRecognitionAvailable = false;

  bool _isListening = false;
  bool _isSearching = false;

  String transcription = '';

  @override
  void initState() {
    super.initState();
    final resourceManager = Provider.of<ResourceManager>(
      context,
      listen: false,
    );

    final _allNotes = resourceManager.notes;
    setState(() {
      _filteredNotes = _allNotes;
    });

    activateSpeechRecognizer();
  }

  @override
  Widget build(BuildContext context) {
    final resourceManager = Provider.of<ResourceManager>(
      context,
      listen: false,
    );

    final notes = resourceManager.notes;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).noteList),
        backgroundColor: Colors.indigo,
        actions: [
          _buildVoiceInput(
            onPressed: _speechRecognitionAvailable && !_isListening
                ? () => start()
                : () => stop(),
            label: _isListening ? 'Listening...' : '',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        physics: BouncingScrollPhysics(),
        itemCount: _isSearching ? _filteredNotes.length : notes.length,
        itemBuilder: (ctx, pos) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
                side: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (ctx) => DetailedNoteScreen(
                      note: _isSearching ? _filteredNotes[pos] : notes[pos],
                    ),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.description,
                    color: Colors.indigo,
                    size: 32,
                  ),
                  title: Text(
                    "${_filteredNotes[pos].title}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.indigo,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNoteScreen(
                            note: _filteredNotes[pos],
                            resourceManager: resourceManager,
                            onDelete: () {
                              setState(() {
                                _allNotes = notes;
                                _filteredNotes = notes;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => EditNoteScreen(
              note: null,
              resourceManager: resourceManager,
              onDelete: null,
            ),
            fullscreenDialog: true,
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildVoiceInput({String label, VoidCallback onPressed}) {
    final resourceManager = Provider.of<ResourceManager>(
      context,
      listen: false,
    );

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: IconButton(
        icon: Icon(_hasError
            ? Icons.warning
            : _isSearching
                ? Icons.clear
                : Icons.mic),
        onPressed: _hasError
            ? null
            : _isSearching
                ? () {
                    setState(() {
                      _speech.cancel();

                      _isSearching = false;
                      _isSearching = false;

                      _filteredNotes = resourceManager.notes;
                    });
                  }
                : onPressed,
      ),
    );
  }

  void activateSpeechRecognizer() {
    requestPermission();

    _speech = new SpeechRecognition();
    final _localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    _speech.setAvailabilityHandler(handleAvailability);

    _speech.setCurrentLocaleHandler((locale) {
      print('setCurrentLocaleHandler: $locale');
      setState(() {
        // locale is a string of the form 'en_US'
        // we need to split it into a language and a country
        final newLocale = Locale(locale.split('_')[0], locale.split('_')[1]);
        _localeProvider.setLocale(context, newLocale);
      });
    });
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  void start() {
    _isSearching = true;

    _speech.listen(locale: 'en_US').then((result) {
      print('Started listening => result $result');
    });
  }

  void cancel() {
    _speech.cancel().then((result) {
      setState(() {
        _isListening = false;
      });
    });
  }

  void stop() {
    _speech.stop().then((result) {
      setState(() {
        _isListening = false;
      });
    });
  }

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) {
    setState(() {
      transcription = text;
      _filteredNotes.clear();
      for (Note note in _allNotes) {
        if (note.title.toUpperCase().contains(text.toUpperCase()) ||
            note.content.toUpperCase().contains(text.toUpperCase()))
          _filteredNotes.add(note);
      }
      //stop(); //stop listening now
    });
  }

  void onRecognitionComplete() => setState(() => _isListening = false);

  void requestPermission() async {
    if (await Permission.microphone.request().isGranted) {
      print("hello permission microphone is granted.");
    }
  }

  void handleAvailability(bool result) async {
    setState(() {
      _speechRecognitionAvailable = result;
    });

    if (!result) {
      if (_hasError) return;
      await _speech.stop();
      setState(() {
        _hasError = true;
      });
      await showExceptionAlertDialog(
        context,
        exception: Exception(
          'Speech recognition not available',
        ),
      );
    }
  }
}
