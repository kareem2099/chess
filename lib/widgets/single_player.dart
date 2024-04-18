import 'package:chess_flutter/blocs/board_bloc.dart';
import 'package:chess_flutter/models/chess_piece.dart';
import 'package:chess_flutter/widgets/chess_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chess/chess.dart' as chess_pkg;
import 'package:flutter/services.dart';

class ChessBoardSinglePlayer extends StatefulWidget {
  const ChessBoardSinglePlayer({Key? key});

  @override
  State<ChessBoardSinglePlayer> createState() => _ChessBoardStateSinglePlayer();
}

class _ChessBoardStateSinglePlayer extends State<ChessBoardSinglePlayer> {
  late BoardBloc _boardBloc;

  @override
  void initState() {
    super.initState();
    _boardBloc = BoardBloc(chessGame: chess_pkg.Chess());
    _boardBloc.setBoardState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.blue, // Background color
            ),
          ),
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double borderSize = constraints.maxWidth > constraints.maxHeight
                    ? constraints.maxWidth
                    : constraints.maxHeight;
                return Container(
                  width: borderSize,
                  height: borderSize,
                  margin: EdgeInsets.all(1),
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                  ),
                  child: _buildChessGrid(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChessGrid() {
    return ValueListenableBuilder(
      valueListenable: _boardBloc.boardMapPiecesNf,
      builder: (
        _,
        Map<int, ChessPiece> boardMapPieces,
        __,
      ) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
            // Add childAspectRatio to adjust the size of the grid cells
            childAspectRatio: 1.79, // Square cells
          ),
          itemBuilder: (context, index) {
            // Determine color of the square
            late Widget child;
            if (!boardMapPieces.containsKey(index)) {
              child = Container();
            } else {
              // Adjust the size of the SVG to fit within the grid cell
              child = SvgPicture.asset(
                boardMapPieces[index]!.svgPath,
                fit: BoxFit
                    .scaleDown, // Use scaleDown to fit the SVG within the cell
              );
            }

            bool isLightSquare = (index ~/ 8 + index) % 2 == 0;

            return ChessTile(
              boardBloc: _boardBloc,
              index: index,
              isLightSquare: isLightSquare,
              child: child,
            );
          },
          itemCount: 64,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        );
      },
    );
  }
}
