import 'package:firebase_database/firebase_database.dart';

class Todo {
  String key;
  String subject;
  bool completed;
  String userId;

  Todo({
    this.subject,
    this.completed,
    this.userId,
  });

  Todo.fromSnapShot(DataSnapshot snapshot) {
    this.key = snapshot.key;
    this.userId = snapshot.value['userId'];
    this.subject = snapshot.value['subject'];
    this.completed = snapshot.value['completed'];
  }

  toJson() {
    return {
      'userId': this.userId,
      'subject': this.subject,
      'completed': this.completed,
    };
  }
}
