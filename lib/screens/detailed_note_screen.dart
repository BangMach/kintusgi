import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kintsugi/data/highlighting_list.dart';
import 'package:kintsugi/models/note_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailedNoteScreen extends StatelessWidget {
  final Note note;

  const DetailedNoteScreen({
    Key key,
    @required this.note,
  }) : super(key: key);

  bool highlightable(String text) {
    // Check if the text is a number
    if (text.isNotEmpty && text.contains(RegExp(r'[0-9]'))) {
      return true;
    }

    // Check if the text is a float
    if (text.isNotEmpty && text.contains(RegExp(r'[0-9]*\.[0-9]'))) {
      return true;
    }

    // Check if the text is a date (dd-mm-yyyy) or (dd/mm/yyyy)
    if (text.isNotEmpty &&
            text.contains(RegExp(r'[0-9]{2}-[0-9]{2}-[0-9]{4}')) ||
        text.contains(RegExp(r'[0-9]{2}/[0-9]{2}/[0-9]{4}'))) {
      return true;
    }

    // Check if the text is a time
    if (text.isNotEmpty &&
        text.contains(RegExp(r'[0-9]{2}:[0-9]{2}:[0-9]{2}'))) {
      return true;
    }

    // Check if the text is any number represented in *st, *nd, *rd, *th
    if (text.isNotEmpty && text.contains(RegExp(r'[0-9]{1,2}(st|nd|rd|th)'))) {
      return true;
    }

    // Check if the text is 'first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh', 'eighth', 'ninth'
    if (text.isNotEmpty &&
        text.contains(RegExp(
            r'(?:first|second|third|fourth|fifth|sixth|seventh|eighth|ninth)'))) {
      return true;
    }

    // Check if the text has 'hundred', 'thousand', 'million', 'billion', 'trillion'
    if (text.isNotEmpty &&
        text.contains(
            RegExp(r'(?:hundred|thousand|million|billion|trillion)'))) {
      return true;
    }

    // Check if the text is 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'
    if (text.isNotEmpty &&
        text.contains(
            RegExp(r'(?:one|two|three|four|five|six|seven|eight|nine)'))) {
      return true;
    }

    // Check if the text is 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen'
    if (text.isNotEmpty &&
        text.contains(RegExp(
            r'(?:ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen)'))) {
      return true;
    }

    // Check if the text is 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'
    if (text.isNotEmpty &&
        text.contains(RegExp(
            r'(?:twenty|thirty|forty|fifty|sixty|seventy|eighty|ninety)'))) {
      return true;
    }

    // Check from highlighting list
    if (HighlightingList.checkIfHighlightable(text)) {
      return true;
    }

    return false;
  }

  Color generateRandomColor() {
    final random = Random();

    final List<Color> colors = [
      Colors.red[900],
      Colors.pink[900],
      Colors.purple[900],
      Colors.blue[900],
      Colors.cyan[900],
      Colors.lightGreen[900],
      Colors.orange[900],
    ];

    return colors[random.nextInt(colors.length)];
  }

  Widget _generateContentWithHighlights(
    BuildContext context,
    String content,
  ) {
    final List<String> words = content.split(' ');

    return Text.rich(
      TextSpan(
        children: words.map((String word) {
          if (highlightable(word)) {
            return TextSpan(
              text: word + ' ',
              style: TextStyle(
                color: generateRandomColor(),
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            );
          } else {
            return TextSpan(
              text: word + ' ',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
              ),
            );
          }
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).detailedNote),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
              textAlign: TextAlign.center,
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            SizedBox(height: 16.0),
            _generateContentWithHighlights(
              context,
              note.content,
            ),
          ],
        ),
      ),
    );
  }
}
