import 'package:flutter/material.dart';

class PlutoScreen extends StatelessWidget {
  final String? title;
  final String? topTitle;
  final List<Widget>? topContents;
  final List<Widget>? topButtons;
  final Widget? body;

  const PlutoScreen({
    Key? key,
    this.title,
    this.topTitle,
    this.topContents,
    this.topButtons,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title - PlutoGrid'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, size) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: size.maxWidth,
                height: size.maxHeight,
                constraints: const BoxConstraints(
                  minHeight: 750,
                ),
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [

                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: body!,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: const Color(0xFF33BDE5),
      ),
    );
  }
}