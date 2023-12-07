import 'package:flutter/material.dart';

import 'chess_slot.dart';
import 'chess_slot_predict.dart';
import 'chess_store.dart';

class ChessPage extends StatefulWidget {
  const ChessPage({super.key});

  @override
  State<ChessPage> createState() => _ChessPageState();
}

class _ChessPageState extends State<ChessPage> {
  final store = ChessStore();

  ChessSlotPredict predict = ChessSlotPredict.empty();

  void setPredict(ChessSlotPredict value) {
    setState(() {
      predict = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(const Size(900, 900)),
          child: ValueListenableBuilder(
            valueListenable: store,
            builder: (context, value, _) {
              return value.when(
                onLoading: () => const Center(child: CircularProgressIndicator()),
                onError: (error) => Center(child: Text(error)),
                onWhiteWinner: () => const Center(child: Text('White won')),
                onBlackWinner: () => const Center(child: Text('Black won')),
                onLoaded: (slots) => AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 2.0,
                          spreadRadius: 1.0,
                        ),
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(-2.0, -2.0),
                          blurRadius: 2.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
                      shrinkWrap: true,
                      itemCount: slots.length,
                      itemBuilder: (context, index) {
                        final slot = slots[index];

                        final slotColor = predict.indexesToMove.contains(index) ? Color.alphaBlend(Colors.green.withOpacity(0.3), Color(slot.colorValue)) : Color(slot.colorValue);

                        return DragTarget<ChessSlot>(
                          onAccept: (from) {
                            store.updateSlot(from, slot);
                          },
                          builder: (context, candidateData, rejectedData) {
                            return Draggable<ChessSlot>(
                              data: slot,
                              onDragStarted: () => setPredict(store.slotValidate(slot)),
                              onDragEnd: (_) => setPredict(ChessSlotPredict.empty()),
                              onDragCompleted: () => setPredict(ChessSlotPredict.empty()),
                              feedback: Material(
                                type: MaterialType.transparency,
                                child: Text(
                                  slot.piece?.emoji ?? '',
                                  style: TextStyle(
                                    fontSize: 64.0,
                                    color: Color(slot.piece?.colorValue ?? 0xFFFFFFFF),
                                    shadows: const [
                                      Shadow(
                                        color: Colors.black87,
                                        offset: Offset(2.0, -1.0),
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              childWhenDragging: Container(
                                color: slotColor,
                                alignment: Alignment.center,
                              ),
                              child: Container(
                                color: slotColor,
                                alignment: Alignment.center,
                                child: Text(
                                  slot.piece?.emoji ?? '',
                                  style: TextStyle(
                                    fontSize: 64.0,
                                    color: Color(slot.piece?.colorValue ?? 0xFFFFFFFF),
                                    shadows: const [
                                      Shadow(
                                        color: Colors.black87,
                                        offset: Offset(2.0, -1.0),
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
