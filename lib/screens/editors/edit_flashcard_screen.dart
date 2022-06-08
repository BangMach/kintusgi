import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kintsugi/models/flashcard_model.dart';
import 'package:kintsugi/services/resource_manager.dart';
import 'package:kintsugi/widgets/common/show_alert_dialog.dart';
import 'package:kintsugi/widgets/custom/show_exception_alert_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditFlashcardScreen extends StatefulWidget {
  EditFlashcardScreen({
    Key key,
    @required this.flashcard,
    @required this.resourceManager,
    @required this.onDelete,
  }) : super(key: key);

  final Flashcard flashcard;
  final ResourceManager resourceManager;
  final Function onDelete;

  static Future<void> show(
    BuildContext context, {
    @required ResourceManager resourceManager,
    Flashcard flashcard,
    Function onDelete,
  }) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditFlashcardScreen(
        flashcard: flashcard,
        resourceManager: resourceManager,
        onDelete: onDelete,
      ),
    ));
  }

  @override
  _EditFlashcardScreenState createState() => _EditFlashcardScreenState();
}

class _EditFlashcardScreenState extends State<EditFlashcardScreen> {
  String _front;
  String _back;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.flashcard != null) {
      _front = widget.flashcard?.front;
      _back = widget.flashcard?.back;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final flashcardId =
            widget.flashcard?.id ?? widget.resourceManager.getNextFlashcardId();

        final flashcard = Flashcard(
          id: flashcardId,
          front: _front ?? 'No content',
          back: _back ?? 'No content',
          createdAt: DateTime.now(),
        );

        await widget.resourceManager.updateFlashcard(flashcard);
        Navigator.of(context).pop();
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(
          context,
          exception: e,
        );
      }
    }
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final bool confirmedLogout = await showAlertDialog(
      context,
      title: AppLocalizations.of(context).deleteFlashcard,
      content: AppLocalizations.of(context).deleteFlashcardConfirm,
      defaultActionText: AppLocalizations.of(context).delete,
      cancelActionText: AppLocalizations.of(context).confirmNo,
    );

    if (confirmedLogout) {
      widget.resourceManager.removeFlashcard(widget.flashcard);
      widget.onDelete();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(
          widget.flashcard == null
              ? AppLocalizations.of(context).createNewFlashcard
              : AppLocalizations.of(context).editFlashcard,
        ),
        actions: [
          IconButton(
            onPressed: _submit,
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 32.0,
        ),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildForm(),
              ),
            ),
            if (widget.flashcard != null) ...[
              SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _confirmDelete(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      AppLocalizations.of(context).deleteFlashcard,
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
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).question,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(),
          ),
        ),
        initialValue: _front,
        textCapitalization: TextCapitalization.sentences,
        validator: (value) => (value == null || value.isEmpty)
            ? AppLocalizations.of(context).questionMustNotBeEmpty
            : null,
        onSaved: (value) => _front = value?.trim(),
      ),
      SizedBox(height: 10),
      TextFormField(
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).answer,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(),
          ),
        ),
        initialValue: _back,
        textCapitalization: TextCapitalization.sentences,
        validator: (value) => (value == null || value.isEmpty)
            ? AppLocalizations.of(context).answerMustNotBeEmpty
            : null,
        onSaved: (value) => _back = value?.trim(),
      ),
    ];
  }
}
