import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  final String? name;
  final GestureTapCallback? onTap;
  final String? description;
  final String? done;
  final Widget? bdone;
  const TodoWidget({
    Key? key,
    this.name,
    this.description,
    this.done,
    this.onTap,
    this.bdone
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: done == "yes" ? Colors.green : Colors.white,
        child: ListTile(
          onTap: onTap,
          title: Text(
            name ?? 'Untitled Todo',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            description ?? '',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          trailing: bdone,
        ));
  }
}
