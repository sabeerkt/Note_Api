import 'package:flutter/material.dart';
import 'package:note/controller/provider.dart';

import 'package:provider/provider.dart';

class DialoguePage extends StatelessWidget {
  const DialoguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) => AlertDialog(
        title: const Text('Add '),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: homeProvider.titlecontroller,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: 4,
                controller: homeProvider.descriptioncontroller,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  homeProvider.addNotes(context);
                  homeProvider.titlecontroller.clear();
                  homeProvider.descriptioncontroller.clear();
                },
                child: const Text('Add'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
