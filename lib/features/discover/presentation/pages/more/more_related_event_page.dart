import 'package:flutter/material.dart';

class MoreRelatedEventPage extends StatefulWidget {
  const MoreRelatedEventPage({super.key});

  @override
  State<MoreRelatedEventPage> createState() => _MoreRelatedEventPageState();
}

class _MoreRelatedEventPageState extends State<MoreRelatedEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
        itemCount: 10,
        itemBuilder: (_, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
          );
        },
      ),
    );
  }
}
