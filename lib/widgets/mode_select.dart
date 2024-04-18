import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chess_flutter/widgets/single_player.dart';
import 'package:chess_flutter/chess_board.dart';
import 'package:flutter/services.dart';

class ModeSelectionScreen extends StatelessWidget {
  final AudioPlayer audioPlayer = AudioPlayer();
  final String audioTextSinglePlayer = "يا هلا يا هلا بالحجى ف اللعب التقيل ";

  final String audioTextMulti = "يا هلا يا هلا بالحجى ف اللعب المالتى ";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Mode ya ayoha el hoba'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _onButtonPressed(context,
                  'audio/player_vs_ player.mp3', ChessBoardSinglePlayer()),
              child: Text('Player vs Player'),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => _onButtonPressed(
                  context, 'audio/single_player.mp3', ChessBoardp2p()),
              child: Text('Single Player'),
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonPressed(
      BuildContext context, String audioPath, Widget nextPage) async {
    await audioPlayer
        .play(AssetSource(audioPath)); // Replace with your audio file
    _showTextDialog(context, audioTextSinglePlayer, nextPage);
  }

  void _showTextDialog(BuildContext context, String text, Widget nextPage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Audio Text'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => nextPage),
                    );
                  },
                  child: Text('Start Game'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
