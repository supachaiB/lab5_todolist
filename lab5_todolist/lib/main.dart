import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({
    super.key,
  });

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  late TextEditingController _texteditController;
  late TextEditingController _descriptionController;

  final List<Map<String, dynamic>> _myList = [];

  @override
  void initState() {
    super.initState();
    _texteditController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  void addTodoHandle(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add new task"),
            content: SizedBox(
              width: 120,
              height: 140,
              child: Column(
                children: [
                  TextField(
                    controller: _texteditController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Input your task"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Description"),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _myList.add({
                        'name': _texteditController.text,
                        'note': _descriptionController.text,
                        'completed': false,
                      });
                    });
                    _texteditController.clear();
                    _descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Save"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _myList.isNotEmpty
          ? ListView.builder(
              itemCount: _myList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _myList[index]['completed'],
                        onChanged: (value) {
                          setState(() {
                            _myList[index]['completed'] = value;
                          });
                        },
                      ),
                      const SizedBox(
                          width: 10), // เว้นระยะห่างระหว่าง Checkbox กับข้อความ
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _myList[index]['name'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                decoration: _myList[index]['completed']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            if (_myList[index]['note'] != null &&
                                _myList[index]['note'].isNotEmpty)
                              Text(_myList[index]['note']!,
                                  style: TextStyle(
                                    decoration: _myList[index]['completed']
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  )),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _myList.removeAt(index);
                          });
                        },
                      )
                    ],
                  ),
                );
              },
            )
          : const Center(child: Text("No tasks added yet")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodoHandle(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
