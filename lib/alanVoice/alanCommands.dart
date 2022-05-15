import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:provider/provider.dart';

class AlanVoiceCommands extends StatefulWidget {
  const AlanVoiceCommands({Key? key}) : super(key: key);

  @override
  _AlanVoiceCommandsState createState() => _AlanVoiceCommandsState();
}

class _AlanVoiceCommandsState extends State<AlanVoiceCommands> {
  _AlanVoiceCommandsState() {
    AlanVoice.addButton(
        "6c32a6cd03dda31fa16776e42b7ae7642e956eca572e1d8b807a3e2338fdd0dc/stage");

    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
