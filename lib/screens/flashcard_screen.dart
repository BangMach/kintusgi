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
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: SizedBox(
                width: double.infinity,
                height: 250,
                child: FlipCard(
                  front: FlashcardView(
                    text: _flashcards[_currentIndex].question,
                    isFront: true,
                    index: _currentIndex,
                  ),
                  back: FlashcardView(
                    text: _flashcards[_currentIndex].answer,
                    isFront: false,
                    index: _currentIndex,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: showPreviousCard,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Previous',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            Icon(
                              Icons.chevron_left,
                              color: Colors.transparent,
                              size: 24.0,
                            ),
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: showNextCard,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.chevron_right,
                              color: Colors.transparent,
                              size: 24.0,
                            ),
                            Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 24.0,
                            ),
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                      ),
                    ),
                  ),
                ],
              ),
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
