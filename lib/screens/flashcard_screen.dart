import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:kintsugi/widgets/flashcards/flashcard.dart';
import 'package:kintsugi/widgets/flashcards/flashcard_view.dart';

class FlashcardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  List<Flashcard> _flashcards = [
    Flashcard(
      question: "Ẩn sau cái đẹp",
      answer: "Là sự thô bạo, tàn ác của cuộc sống",
    ),
    Flashcard(
      question: "Temperment",
      answer: "Emotional State of mind!",
    ),
    Flashcard(
      question: "Who teaches you how to write sexy code?",
      answer: "lo mao!",
    )
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Flash Cards"),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: FlipCard(
                front: FlashcardView(
                  text: _flashcards[_currentIndex].question,
                ),
                back: FlashcardView(
                  text: _flashcards[_currentIndex].answer,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // ignore: deprecated_member_use
                OutlinedButton.icon(
                  onPressed: showPreviousCard,
                  icon: Icon(Icons.chevron_left),
                  label: Text('Prev'),
                ),
                // ignore: deprecated_member_use
                OutlinedButton.icon(
                  onPressed: showNextCard,
                  icon: Icon(Icons.chevron_right),
                  label: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showNextCard() {
    setState(() {
      _currentIndex =
          (_currentIndex + 1 < _flashcards.length) ? _currentIndex + 1 : 0;
    });
  }

  void showPreviousCard() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 >= 0) ? _currentIndex - 1 : _flashcards.length - 1;
    });
  }
}
