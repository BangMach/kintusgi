import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_recognition/speech_recognition.dart';

class ListSearch extends StatefulWidget {
  @override
  State createState() {
    return ListSearchState();
  }
}

class ListSearchState extends State {
  List _listWidgets = [];
  List _listSearchWidgets = [];
  SpeechRecognition _speech;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  bool _isSearch = false;

  String transcription = '';

  @override
  void initState() {
    super.initState();
    _listWidgets.add("khiếm thị giác");
    _listWidgets.add("một ghi chú thật là dài");
    _listWidgets.add("tìm kiếm bằng giọng nói");
    _listWidgets.add("danh sách đi chợ");
    _listWidgets.add("bài giảng môn tiếng anh");
    _listWidgets.add("bài giảng môn tiếng hoa");
    _listWidgets.add("bài giảng môn tiếng Đức");
    _listWidgets.add("ghi chú ngày hôm nay ");
    _listWidgets.add("danh sách bài hát yêu  ");
    _listWidgets.add("Lecture note number two");
    _listWidgets.add("Lecture note number one");
    _listWidgets.add("A very Long Note");

    _listSearchWidgets.addAll(_listWidgets);
    activateSpeechRecognizer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search notes'),
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
          itemCount: _listSearchWidgets.length,
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
                child: ListTile(
                  leading: Icon(
                    Icons.description,
                    color: Colors.indigo,
                    size: 32,
                  ),
                  title: Text(
                    "${_listSearchWidgets[pos]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildVoiceInput({String label, VoidCallback onPressed}) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                print("button pressed");
              },
              child: Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: onPressed,
            ),
            (_isSearch)
                ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _isSearch = false;
                        _listSearchWidgets.clear();
                        _listSearchWidgets.addAll(_listWidgets);
                      });
                    },
                  )
                : Text(""),
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
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  void start() {
    _isSearch = true;
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
      _listSearchWidgets.clear();
      for (String k in _listWidgets) {
        if (k.toUpperCase().contains(text.toUpperCase()))
          _listSearchWidgets.add(k);
      }
      //stop(); //stop listening now
    });
  }

  void onRecognitionComplete() => setState(() => _isListening = false);

  void requestPermission() async {
    if (await Permission.microphone.request().isGranted) {
      print("hello permission microphone is granted ");
    }
    //   PermissionStatus permission = await PermissionHandler()
    //     .checkPermissionStatus(PermissionGroup.microphone);
    //
    // if (permission != PermissionStatus.granted) {
    //   await PermissionHandler()
    //       .requestPermissions([PermissionGroup.microphone]);
    // }
  }
}
