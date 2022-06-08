import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kintsugi/screens/editors/edit_flashcard_screen.dart';
import 'package:kintsugi/services/resource_manager.dart';
import 'package:kintsugi/widgets/flashcards/flashcard_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FlashcardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final resourceManager = Provider.of<ResourceManager>(
      context,
      listen: false,
    );

    final _flashcards = resourceManager.flashcards;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Flashcards"),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_flashcards.length > 0)
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: FlipCard(
                    front: FlashcardView(
                        flashcard: _flashcards[_currentIndex],
                        resourceManager: resourceManager,
                        isFront: true,
                        index: _currentIndex,
                        onDelete: () {
                          setState(() {
                            if (_currentIndex > 0) _currentIndex--;
                          });
                        }),
                    back: FlashcardView(
                      flashcard: _flashcards[_currentIndex],
                      resourceManager: resourceManager,
                      isFront: false,
                      index: _currentIndex,
                    ),
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).noFlashcardsYet,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _currentIndex > 0
                              ? () {
                                  setState(() {
                                    _currentIndex--;
                                  });
                                }
                              : null,
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
                                  AppLocalizations.of(context).previousBtn,
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
                            backgroundColor: MaterialStateProperty.all(
                              _currentIndex > 0 ? Colors.indigo : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _currentIndex < _flashcards.length - 1
                              ? () {
                                  setState(() {
                                    _currentIndex++;
                                  });
                                }
                              : null,
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
                                  AppLocalizations.of(context).nextBtn,
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
                            backgroundColor: MaterialStateProperty.all(
                              _currentIndex < _flashcards.length - 1
                                  ? Colors.indigo
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => EditFlashcardScreen(
                            flashcard: null,
                            resourceManager: resourceManager,
                            onDelete: null,
                          ),
                          fullscreenDialog: true,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          AppLocalizations.of(context).createNewFlashcard,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.indigo,
                        ),
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
}
