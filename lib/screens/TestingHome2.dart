import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../constants/colors.dart';
import '../services/notify.dart';
import 'Profile.dart';

DateTime scheduleTime = DateTime.now();

class TestHome2 extends StatefulWidget {
  const TestHome2({Key? key}) : super(key: key);

  @override
  State<TestHome2> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome2> {
  String input = "";

  createTodos() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(input);
    //Map
    Map<String, String> todos = {"todoTitle": input};
    documentReference.set(todos).whenComplete(() {
      print("$input created");
    });
  }

  deleteTodos(item) {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(item);
    documentReference.delete().whenComplete(() {
      print("$item deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBlack,
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: tdRed,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: tdWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Container(
                    margin: const EdgeInsets.only(
                      top: 30,
                      bottom: 30,
                    ),
                    child: Image.asset('assets/images/Remind_Logo.png',height: 100,)
                ),
                content: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Reminder',
                  ),
                  onChanged: (String value) {
                    input = value;
                  },
                ),
                actions: <Widget>[
                  const DatePickerTxt(),
                  ElevatedButton(
                    onPressed: () {
                      debugPrint('Notification Scheduled for $scheduleTime');
                      NotificationService().scheduleNotification(
                          title: 'Reminder: Its TIME TO DO IT!!!',
                          body: input,
                          scheduledNotificationDateTime: scheduleTime);
                      NotificationService().showNotification(title: 'Reminder: New work!', body: input);
                      createTodos();
                      Navigator.of(context).pop(); // closes the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: tdRed,
                    ),
                    child: const Text("Add New Reminder", style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("MyTodos").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (!snapshots.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshots.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshots.data!.docs[index];
              return Dismissible(
                onDismissed: (direction) {
                  NotificationService().showNotification(title: 'Reminder: Removed!', body: input);
                  deleteTodos(documentSnapshot["todoTitle"]);
                },
                key: Key(documentSnapshot["todoTitle"]),
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                  color: tdDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    textColor: tdWhite,
                    title: Text(documentSnapshot["todoTitle"]),
                    trailing: IconButton(
                      icon: const Icon(Icons.check_box, color: Colors.red),
                      onPressed: () {
                        NotificationService().showNotification(title: 'Reminder: Finished!', body: input);
                        deleteTodos(documentSnapshot["todoTitle"]);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBlack,
      elevation: 0,
      leading: const Icon(
        Icons.bookmark_added,
        color: tdWhite,
        size: 30,
      ),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Image.asset('assets/images/Remind_Logo2.png',
          height: 35,
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()
                  )
              );
            },
            style: TextButton.styleFrom (
              padding: EdgeInsets.zero,
            ),
            child: Container(
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage (
                  fit: BoxFit.cover,
                  image: AssetImage (
                    'assets/images/avatar.jpg',
                  ),
                ),
              ),
            ),
          ),
        ),
      ]
      ),
    );
  }
}
class DatePickerTxt extends StatefulWidget {
  const DatePickerTxt({
    Key? key,
  }) : super(key: key);

  @override
  State<DatePickerTxt> createState() => _DatePickerTxtState();
}

class _DatePickerTxtState extends State<DatePickerTxt> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          onChanged: (date) => scheduleTime = date,
          onConfirm: (date) {},
        );
      },
      child: const Text(
        'Select Date Time',
        style: TextStyle(color: tdRed),
      ),
    );
  }
}