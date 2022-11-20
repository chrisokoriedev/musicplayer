import 'package:flutter/material.dart';

class BottomSheetPage extends StatefulWidget {
  final double height;
   final GlobalKey<MainMusicSectionState> key;

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  double? height;
  @override
  void initState() {
    super.initState();
    height = widget.height;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          height = 900;
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
              height: 30,
            ),
            widget.height == 50
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
    );
  }
}
