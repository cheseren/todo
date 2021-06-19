import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Page Not Found'),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Card(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Go Back',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
