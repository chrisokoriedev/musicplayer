import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double height = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1.0,
      ),
      body: SingleChildScrollView(
          child: Column(children: [Center(child: Text('hey'))])),
      bottomSheet: GestureDetector(
        onTap: () {
          setState(() {
            height = 900;
          });
        },
        child: AnimatedContainer(
          width: double.infinity,
          height: height,
          color: Colors.red,
          duration: const Duration(milliseconds: 500),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              height == 50
                  ? Container()
                  : WillPopScope(
                      onWillPop: () async {
                        setState(() {
                          height = 50;
                        });
                        return false;
                      },
                      child: GestureDetector(
                        onVerticalDragUpdate: (details) {
                          int sen = 8;
                          if (details.delta.dy > sen) {
                            setState(() {
                              height = 50;
                            });
                          }
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.abc),
                              IconButton(
                                icon: Icon(Icons.arrow_drop_down),
                                onPressed: () {
                                  setState(() {
                                    height = 50;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
