import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/controller/provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditPage extends StatefulWidget {
  String id;
  String title;
  String description;
  final VoidCallback onSave;

  EditPage({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  void initState() {
    super.initState();
    var editProvider = Provider.of<HomeProvider>(context, listen: false);
    editProvider.titlecontroller = TextEditingController(text: widget.title);
    editProvider.descriptioncontroller =
        TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Provider.of<HomeProvider>(context, listen: false)
                  .updateNotes(id: widget.id);
              widget.onSave();
              Navigator.of(context).pop();
            },
            child: const Text('Save', style: TextStyle(fontSize: 20)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<HomeProvider>(
          builder: (context, editProvider, child) => Column(
            children: [
              TextFormField(
                style: GoogleFonts.quicksand(fontSize: 20),
                controller: editProvider.titlecontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              TextFormField(
                maxLines: 10,
                style: GoogleFonts.quicksand(fontSize: 20),
                controller: editProvider.descriptioncontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Provider.of<HomeProvider>(context, listen: false)
                        .updateNotes(id: widget.id);
                    widget.onSave();
                    Navigator.of(context).pop();
                  },
                  child: Text("save"))
            ],
          ),
        ),
      ),
    );
  }
}
