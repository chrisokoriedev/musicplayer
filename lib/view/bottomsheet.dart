import 'package:flutter/material.dart';

class BottomSheetPage extends StatefulWidget {
  final double height;
  const BottomSheetPage({Key? key, required this.height}) : super(key: key);

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.height = 900;
        });
      },
      child: AnimatedContainer(
        width: double.infinity,
        height: widget.height,
        color: Colors.red,
        duration: const Duration(milliseconds: 500),
        child: Column(
          children: [
            SizedBox(
              widget.height: 30,
            ),
            widget.height == 50
                ? Container()
                : WillPopScope(
                    onWillPop: () async {
                      setState(() {
                        widget.height = 50;
                      });
                      return false;
                    },
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        int sen = 8;
                        if (details.delta.dy > sen) {
                          setState(() {
                            widget.height = 50;
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
                                  widget.height = 50;
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
    );
  }
}
