import "package:flutter/material.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clothing Selection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ClothesApp(),
    );
  }
}

class ClothesApp extends StatefulWidget {
  const ClothesApp({super.key});

  @override
  State<ClothesApp> createState() => _ClothesAppState();
}

class _ClothesAppState extends State<ClothesApp> {
  final List<Clothes> _clothesList = [
    Clothes("T-shirt"),
    Clothes("Jacket"),
    Clothes("Pants"),
    Clothes("Jeans")
  ];

  final TextEditingController _textFieldController = TextEditingController();
  _addItem(String name) {
    setState(() {
      _clothesList.add(Clothes(name));
    });
  }

  _deleteItem(int index) {
    setState(() {
      _clothesList.removeAt(index);
    });
  }

  _editItem(int index, String newName) {
    setState(() {
      _clothesList[index].name = newName;
    });
  }

  _showEditDialog(BuildContext context, int index, String text) {
    _textFieldController.text = text;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: TextField(
                controller: _textFieldController,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.blue))),
            actions: [
              TextButton(
                  onPressed: () {
                    _editItem(index, _textFieldController.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Clothes App",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: ListView.builder(
          itemCount: _clothesList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                _clothesList[index].name,
                style: const TextStyle(color: Colors.blue),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _deleteItem(index),
                    icon: const Icon(
                      Icons.delete_outlined,
                      color: Colors.red,
                    ),
                    style: IconButton.styleFrom(backgroundColor: Colors.green),
                  ),
                  IconButton(
                      onPressed: () => _showEditDialog(
                          context, index, _clothesList[index].name),
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: Colors.red,
                      ),
                      style:
                          IconButton.styleFrom(backgroundColor: Colors.green)),
                ],
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add_outlined, color: Colors.red),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Add new item"),
                  content: TextField(
                    controller: _textFieldController,
                    decoration: const InputDecoration(
                        hintText: "Enter item name",
                        hintStyle: TextStyle(color: Colors.blue)),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        _addItem(_textFieldController.text);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.red),
                      ),
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.green),
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}

class Clothes {
  String name;

  Clothes(this.name);
}
