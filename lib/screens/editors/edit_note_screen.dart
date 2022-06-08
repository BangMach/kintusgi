import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kintsugi/models/note_model.dart';
import 'package:kintsugi/services/resource_manager.dart';
import 'package:kintsugi/widgets/common/show_alert_dialog.dart';
import 'package:kintsugi/widgets/custom/show_exception_alert_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditNoteScreen extends StatefulWidget {
  EditNoteScreen({
    Key key,
    @required this.note,
    @required this.resourceManager,
    @required this.onDelete,
  }) : super(key: key);

  final Note note;
  final ResourceManager resourceManager;
  final Function onDelete;

  static Future<void> show(
    BuildContext context, {
    @required ResourceManager resourceManager,
    Note note,
    Function onDelete,
  }) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditNoteScreen(
        note: note,
        resourceManager: resourceManager,
        onDelete: onDelete,
      ),
    ));
  }

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  String _title;
  String _content;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _title = widget.note?.title;
      _content = widget.note?.content;
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
        final noteId =
            widget.note?.id ?? widget.resourceManager.getNextNoteId();

        final note = Note(
          id: noteId,
          title: _title ?? 'No title',
          content: _content ?? 'No content',
          createdAt: DateTime.now(),
        );

        await widget.resourceManager.updateNote(note);
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
      title: AppLocalizations.of(context).deleteNote,
      content: AppLocalizations.of(context).deleteNoteConfirm,
      defaultActionText: AppLocalizations.of(context).delete,
      cancelActionText: AppLocalizations.of(context).confirmNo,
    );

    if (confirmedLogout) {
      widget.resourceManager.removeNote(widget.note);
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
          widget.note == null
              ? AppLocalizations.of(context).createNewNote
              : AppLocalizations.of(context).editNote,
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
            if (widget.note != null) ...[
              SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _confirmDelete(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      AppLocalizations.of(context).deleteNote,
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
          labelText: AppLocalizations.of(context).title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(),
          ),
        ),
        initialValue: _title,
        textCapitalization: TextCapitalization.sentences,
        validator: (value) => (value == null || value.isEmpty)
            ? AppLocalizations.of(context).titleMustNotBeEmpty
            : null,
        onSaved: (value) => _title = value?.trim(),
      ),
      SizedBox(height: 10),
      TextFormField(
        maxLines: null,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).content,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(),
          ),
        ),
        initialValue: _content,
        textCapitalization: TextCapitalization.sentences,
        validator: (value) => (value == null || value.isEmpty)
            ? AppLocalizations.of(context).contentMustNotBeEmpty
            : null,
        onSaved: (value) => _content = value?.trim(),
      ),
    ];
  }
}
