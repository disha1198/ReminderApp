import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder Alert',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Reminder App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController _textFieldController = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Reminder'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "Reminder"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('CANCEL'),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: const Text('OK'),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021, 3),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String? codeDialog;
  String? valueText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Reminder')
        ),
        body:Center(  
          child: Material(
            color: const Color.fromARGB(255, 63, 138, 168),
            child: ListView(
              children: [
                const SizedBox(height: 40),
              buildMenuItem(
                text: 'Work Task',
                icon: Icons.access_alarm,
                onClicked: () => selectedItem(context, 0),
              ),
              const SizedBox(height: 40),
              buildMenuItem(
                text: 'Personal Task',
                icon: Icons.access_alarm,
                onClicked: () => selectedItem(context, 0),
              ),
              ],
            ),  
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
                _displayTextInputDialog(context);
                _selectDate(context);
                },
                child: const Icon(Icons.add),
      ),
    );
  }
  
/*child: Row(
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _displayTextInputDialog(context);
              _selectDate(context);
            },
            child: const Icon(Icons.add),
          ),
        ],
      )*/
  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(text, style: const TextStyle(color: color)),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const WorkReminder(),
        ));
        break;
    }
  }
}

class WorkReminder extends StatelessWidget {
  const WorkReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Work Task'),
        ),
      );
}
