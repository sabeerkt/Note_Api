import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/controller/provider.dart';
import 'package:note/service/api_services.dart';
import 'package:note/view/edit.dart';
import 'package:note/widget/texform.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const DialoguePage();
              },
            );
          },
          child: const Text("Add"),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Notes ',
          style: GoogleFonts.kanit(fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) => FutureBuilder(
            future: ApiService().getNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: homeProvider.noteList.length,
                  itemBuilder: (context, index) {
                    final data = homeProvider.noteList[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                data.name ?? 'data is here',
                                style: GoogleFonts.quicksand(),
                              ),
                              subtitle: Text(
                                data.description ?? 'data is here',

                                //  "Description: ${data.description ?? 'data is here'}",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => EditPage(
                                          id: data.id!,
                                          title: data.name!,
                                          description: data.description!,
                                          onSave: () {
                                            homeProvider.loadNotes();
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.edit,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Delete..?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            homeProvider.deleteNote(
                                                id: data.id);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Yes'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  child: const Icon(Icons.delete,
                                      color: Color.fromARGB(255, 255, 0, 0)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return const Center(child: Text('Data is not available'));
              }
            },
          ),
        ),
      ),
    );
  }
}
