import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        controller: scrollController,
          shrinkWrap: true,
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Todo title'),
              subtitle: Text('description'),
              trailing: Text(index.toString()),
            );
          }),
    );
  }
}
