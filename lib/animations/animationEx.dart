import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimationExample extends StatefulWidget {
  const AnimationExample({super.key});

  @override
  State<AnimationExample> createState() => _AnimationExampleState();
}

class _AnimationExampleState extends State<AnimationExample> {
  var crosFadeState = CrossFadeState.showFirst;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animation")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedCrossFade(
              firstChild: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                width: 200,
                color: Colors.lightBlue,
                child: Text("FLutter"),
              ),
              secondChild: Container(
                width: 200,
                height: 100,
                color: Colors.teal,
                child: Column(children: [Text("Flutter"), Text("data")]),
              ),
              crossFadeState: crosFadeState,
              duration: Duration(seconds: 1),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  crosFadeState = crosFadeState == CrossFadeState.showFirst
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst;
                });
              },
              child: Text("switch"),
            ),
          ],
        ),
      ),
    );
  }
}
