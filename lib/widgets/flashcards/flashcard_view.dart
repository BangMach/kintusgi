import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kintsugi/models/flashcard_model.dart';
import 'package:kintsugi/screens/editors/edit_flashcard_screen.dart';
import 'package:kintsugi/services/resource_manager.dart';

class FlashcardView extends StatelessWidget {
  final Flashcard flashcard;
  final ResourceManager resourceManager;
  final bool isFront;
  final int index;
  final Function onDelete;

  FlashcardView({
    Key key,
    @required this.flashcard,
    @required this.resourceManager,
    this.isFront = true,
    @required this.index,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
        side: BorderSide(
          color: Colors.grey,
          width: 2.0,
        ),
      ),
      color: isFront ? Colors.indigoAccent : Colors.green[700],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.edit,
                      color: Colors.transparent,
                    ),
                  ),
                  Text(
                    'Flashcard #${index + 1}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => EditFlashcardScreen(
                            flashcard: flashcard,
                            resourceManager: resourceManager,
                            onDelete: onDelete,
                          ),
                        )),
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                isFront ? flashcard.front : flashcard.back,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              Opacity(
                opacity: 0,
                child: Text(
                  'Flashcard #${index + 1}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
