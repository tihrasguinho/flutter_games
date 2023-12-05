import 'dart:async';

import 'package:flutter/material.dart';

import '../common/slot.dart';
import '../controllers/checkers_controller.dart';

class CheckersPage extends StatefulWidget {
  const CheckersPage({super.key});

  @override
  State<CheckersPage> createState() => _CheckersPageState();
}

class _CheckersPageState extends State<CheckersPage> {
  late final CheckersController controller = CheckersController();

  final double maxWidth = 900.0;
  late final double slotSize = (maxWidth / 8.0) * 0.96;

  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.bloc,
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Pretas ${controller.bloc.blackPieces} x ${controller.bloc.whitePieces} Brancas\nCurrent player: ${controller.bloc.currentPlayer.name}',
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
          ),
          body: Center(
            child: SizedBox.fromSize(
              size: Size.fromWidth(maxWidth),
              child: state.when(
                onInitial: () => const Center(child: CircularProgressIndicator()),
                onError: (error) => Center(child: Text(error)),
                onLoaded: (slots) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Column(
                      children: [
                        for (var row = 0; row < slots.length; row++)
                          Row(
                            children: [
                              for (var column = 0; column < slots[row].length; column++)
                                DragTarget<Slot>(
                                  onAccept: (value) => controller.bloc.updateCheckers(value, slots[row][column]),
                                  builder: (context, candidateData, rejectedData) {
                                    return Draggable<Slot>(
                                      data: slots[row][column],
                                      feedback: Container(
                                        width: slotSize,
                                        height: slotSize,
                                        padding: const EdgeInsets.all(24.0),
                                        child: slots[row][column].value.isEmpty
                                            ? null
                                            : Material(
                                                elevation: 2,
                                                color: switch (slots[row][column].value) {
                                                  White _ => Colors.grey.shade800,
                                                  Black _ => Colors.black,
                                                  Empty _ => Colors.transparent,
                                                },
                                                shape: CircleBorder(
                                                  side: BorderSide(
                                                    color: (row + column) % 2 == 0 ? Colors.black : Colors.white,
                                                    width: slots[row][column].value.isWhiteAndKing || slots[row][column].value.isBlackAndKing ? 2.0 : 1.0,
                                                  ),
                                                ),
                                                child: slots[row][column].value.isWhiteAndKing || slots[row][column].value.isBlackAndKing
                                                    ? const Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                      )
                                                    : null,
                                              ),
                                      ),
                                      childWhenDragging: Container(
                                        decoration: BoxDecoration(
                                          color: (row + column) % 2 == 0 ? Colors.white : Colors.black,
                                          border: Border.all(color: Colors.black),
                                        ),
                                        width: slotSize,
                                        height: slotSize,
                                        padding: const EdgeInsets.all(24.0),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: (row + column) % 2 == 0 ? Colors.white : Colors.black,
                                          border: Border.all(color: Colors.black),
                                        ),
                                        width: slotSize,
                                        height: slotSize,
                                        padding: const EdgeInsets.all(24.0),
                                        child: slots[row][column].value.isEmpty
                                            ? const SizedBox()
                                            : Material(
                                                elevation: 2,
                                                color: switch (slots[row][column].value) {
                                                  White _ => Colors.grey.shade800,
                                                  Black _ => Colors.black,
                                                  Empty _ => Colors.transparent,
                                                },
                                                shape: CircleBorder(
                                                  side: BorderSide(
                                                    color: (row + column) % 2 == 0 ? Colors.black : Colors.white,
                                                    width: slots[row][column].value.isWhiteAndKing || slots[row][column].value.isBlackAndKing ? 2.0 : 1.0,
                                                  ),
                                                ),
                                                child: slots[row][column].value.isWhiteAndKing || slots[row][column].value.isBlackAndKing
                                                    ? const Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                      )
                                                    : null,
                                              ),
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
