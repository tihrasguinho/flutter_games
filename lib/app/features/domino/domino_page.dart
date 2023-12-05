// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class DominoPage extends StatefulWidget {
  const DominoPage({super.key});

  @override
  State<DominoPage> createState() => _DominoPageState();
}

class _DominoPageState extends State<DominoPage> {
  final List<Domino> dominoes = [
    for (var a = 0; a <= 6; a++)
      for (var b = a; b <= 6; b++) Domino(a, b)
  ];

  final boardDominoes = signal(<Domino>[]);

  void insertBoardDomino(int index, Domino domino) {
    boardDominoes.value = [...boardDominoes.value, domino];
  }

  final myDominoes = signal(<Domino>[]);

  void removeMyDomino(Domino domino) {
    myDominoes.value = myDominoes.value.where((e) => e != domino).toList();
  }

  void instantiateDominoes() {
    for (var i = 0; i < 6; i++) {
      myDominoes.value.add(dominoes[Random().nextInt(dominoes.length)]);
    }
  }

  @override
  void initState() {
    super.initState();
    instantiateDominoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: DragTarget<Domino>(
                    onAcceptWithDetails: (details) {
                      insertBoardDomino(0, details.data);
                      removeMyDomino(details.data);
                    },
                    builder: (context, objs, rejects) {
                      return const SizedBox();
                    },
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      children: [
                        ...boardDominoes.watch(context).map(
                          (domino) {
                            return BoardDominoWidget(
                              domino: domino,
                              boardDominoes: boardDominoes.value,
                              onAccept: (d) {
                                insertBoardDomino(0, d);
                                removeMyDomino(d);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [
              ...myDominoes.watch(context).map(
                    (e) => Draggable<Domino>(
                      data: e,
                      feedback: DominoWidget(e, axis: Axis.vertical),
                      childWhenDragging: const SizedBox(),
                      child: DominoWidget(e, axis: Axis.vertical),
                    ),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}

class Domino {
  final int aValue;
  final int bValue;

  const Domino(this.aValue, this.bValue);

  bool get isDoublet => aValue == bValue;

  bool canFit(Domino domino) {
    if (isDoublet && domino.isDoublet) {
      return false;
    } else if (isDoublet && (aValue == domino.aValue || aValue == domino.bValue)) {
      return true;
    } else if (!isDoublet && domino.isDoublet && (aValue == domino.aValue || bValue == domino.bValue)) {
      return true;
    } else if (!isDoublet && !domino.isDoublet) {
      if (aValue == domino.aValue || aValue == domino.bValue || bValue == domino.aValue || bValue == domino.bValue) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  String toString() => 'Domino($aValue, $bValue)';

  Map<String, dynamic> toMap() => {
        'aValue': aValue,
        'bValue': bValue,
      };

  factory Domino.fromMap(Map<String, dynamic> map) {
    return Domino(
      map['aValue']?.toInt() ?? 0,
      map['bValue']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Domino.fromJson(String source) => Domino.fromMap(json.decode(source));

  @override
  bool operator ==(covariant Domino other) {
    if (identical(this, other)) return true;

    return other.aValue == aValue && other.bValue == bValue;
  }

  @override
  int get hashCode => aValue.hashCode ^ bValue.hashCode;
}

class DominoWidget extends StatelessWidget {
  const DominoWidget(this.domino, {super.key, this.axis = Axis.vertical});

  final Domino domino;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: axis == Axis.vertical ? 1 : 0,
      child: SizedBox(
        height: 96.0,
        child: AspectRatio(
          aspectRatio: 16 / 8,
          child: Material(
            elevation: 5,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            child: Row(
              children: [
                Expanded(
                  child: dotsBuilder(
                    domino.aValue,
                    hPadding: 16.0,
                    vPadding: axis == Axis.vertical ? 16.0 : 0.0,
                  ),
                ),
                Container(
                  height: 75.0,
                  width: 1.0,
                  color: Colors.grey,
                ),
                Expanded(
                  child: dotsBuilder(
                    domino.bValue,
                    hPadding: 16.0,
                    vPadding: axis == Axis.vertical ? 16.0 : 0.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dotsBuilder(
    int value, {
    double dotSize = 16.0,
    double hPadding = 16.0,
    double vPadding = 16.0,
  }) =>
      switch (value) {
        0 => const SizedBox(),
        1 => const Icon(Icons.circle, size: 16.0),
        2 => Padding(
            padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [Icon(Icons.circle, size: dotSize), const Spacer()]),
                Row(children: [const Spacer(), Icon(Icons.circle, size: dotSize, color: Colors.transparent), const Spacer()]),
                Row(children: [const Spacer(), Icon(Icons.circle, size: dotSize)]),
              ],
            ),
          ),
        3 => Padding(
            padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [Icon(Icons.circle, size: dotSize), const Spacer()]),
                Row(children: [const Spacer(), Icon(Icons.circle, size: dotSize), const Spacer()]),
                Row(children: [const Spacer(), Icon(Icons.circle, size: dotSize)]),
              ],
            ),
          ),
        4 => Padding(
            padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [Icon(Icons.circle, size: dotSize), const Spacer(), Icon(Icons.circle, size: dotSize)]),
                Row(children: [const Spacer(), Icon(Icons.circle, size: dotSize, color: Colors.transparent), const Spacer()]),
                Row(children: [Icon(Icons.circle, size: dotSize), const Spacer(), Icon(Icons.circle, size: dotSize)]),
              ],
            ),
          ),
        5 => Padding(
            padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [Icon(Icons.circle, size: dotSize), const Spacer(), Icon(Icons.circle, size: dotSize)]),
                Row(children: [const Spacer(), Icon(Icons.circle, size: dotSize), const Spacer()]),
                Row(children: [Icon(Icons.circle, size: dotSize), const Spacer(), Icon(Icons.circle, size: dotSize)]),
              ],
            ),
          ),
        6 => Padding(
            padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Icon(Icons.circle, size: dotSize), Icon(Icons.circle, size: dotSize), Icon(Icons.circle, size: dotSize)],
                ),
                Row(children: [Icon(Icons.circle, size: dotSize, color: Colors.transparent)]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Icon(Icons.circle, size: dotSize), Icon(Icons.circle, size: dotSize), Icon(Icons.circle, size: dotSize)],
                ),
              ],
            ),
          ),
        _ => const SizedBox(),
      };
}

// ********************************************************************

class BoardDominoWidget extends StatefulWidget {
  const BoardDominoWidget({
    super.key,
    required this.domino,
    required this.boardDominoes,
    required this.onAccept,
  });

  final Domino domino;
  final List<Domino> boardDominoes;
  final void Function(Domino domino) onAccept;

  @override
  State<BoardDominoWidget> createState() => _BoardDominoWidgetState();
}

class _BoardDominoWidgetState extends State<BoardDominoWidget> {
  final backgroudHover = signal(Colors.transparent);

  void setValid() {
    backgroudHover.value = Colors.green;
  }

  void setInvalid() {
    backgroudHover.value = Colors.red;
  }

  void setTransparent() {
    backgroudHover.value = Colors.transparent;
  }

  void isHovering(DragTargetDetails<Domino> details) {
    final domino = details.data;

    if (widget.boardDominoes.length == 1) {
      final current = widget.boardDominoes.first;

      if (current.canFit(domino)) {
        setValid();
      } else {
        setInvalid();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Domino>(
      onMove: isHovering,
      onLeave: (_) => setTransparent(),
      onAccept: (domino) {
        setTransparent();
        if (widget.domino.canFit(domino)) {
          widget.onAccept(domino);
        }
      },
      hitTestBehavior: HitTestBehavior.deferToChild,
      builder: (context, objs, rejects) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          color: backgroudHover.watch(context),
          child: DominoWidget(
            widget.domino,
            axis: widget.domino.isDoublet ? Axis.vertical : Axis.horizontal,
          ),
        );
      },
    );
  }
}
