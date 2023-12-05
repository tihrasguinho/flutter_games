import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:signals/signals_flutter.dart';

import 'tic_tac_toe_slot.dart';

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key});

  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  final slotsSignal = signal(List<TicTacToeSlot>.generate(9, (index) => EmptySlot(index)));

  void insertSlot(int index, TicTacToeSlot slot) {
    if (slotsSignal.value[index] is EmptySlot) {
      slotsSignal.value[index] = slot.copyWith(index);
      slotsSignal.value = [...slotsSignal.value];
    }
  }

  TicTacToeSlot? checkGameWinner(List<TicTacToeSlot> slots) {
    final first = [slots[0], slots[1], slots[2]];

    if (first.every((e) => (e.runtimeType == first.first.runtimeType) && e is! EmptySlot)) {
      return first.first;
    }

    final second = [slots[3], slots[4], slots[5]];

    if (second.every((e) => (e.runtimeType == second.first.runtimeType) && e is! EmptySlot)) {
      return second.first;
    }

    final third = [slots[6], slots[7], slots[8]];

    if (third.every((e) => (e.runtimeType == third.first.runtimeType) && e is! EmptySlot)) {
      return third.first;
    }

    final fourth = [slots[0], slots[3], slots[6]];

    if (fourth.every((e) => (e.runtimeType == fourth.first.runtimeType) && e is! EmptySlot)) {
      return fourth.first;
    }

    final fifth = [slots[1], slots[4], slots[7]];

    if (fifth.every((e) => (e.runtimeType == fifth.first.runtimeType) && e is! EmptySlot)) {
      return fifth.first;
    }

    final sixth = [slots[2], slots[5], slots[8]];

    if (sixth.every((e) => (e.runtimeType == sixth.first.runtimeType) && e is! EmptySlot)) {
      return fifth.first;
    }

    final seventh = [slots[0], slots[4], slots[8]];

    if (seventh.every((e) => (e.runtimeType == seventh.first.runtimeType) && e is! EmptySlot)) {
      return fifth.first;
    }

    final eighth = [slots[2], slots[4], slots[6]];

    if (eighth.every((e) => (e.runtimeType == eighth.first.runtimeType) && e is! EmptySlot)) {
      return fifth.first;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final slots = slotsSignal.watch(context);

    final size = MediaQuery.sizeOf(context);

    final width = size.width >= 900.0 ? 900.0 : size.width;

    return Scaffold(
      body: Center(
        child: SizedBox.fromSize(
          size: Size.fromWidth(width * 0.9),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  padding: const EdgeInsets.all(24.0),
                  itemCount: slots.length,
                  itemBuilder: (context, index) {
                    final slot = slots[index];

                    return DragTarget<TicTacToeSlot>(
                      onAccept: (slot) => insertSlot(index, slot),
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          decoration: BoxDecoration(border: borderBuilder(index)),
                          child: switch (slot) {
                            CircleSlot circle => Lottie.asset(
                                circle.value,
                                repeat: false,
                                fit: BoxFit.cover,
                              ),
                            CrossSlot cross => Lottie.asset(
                                cross.value,
                                repeat: false,
                                fit: BoxFit.cover,
                              ),
                            _ => const SizedBox(),
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Row(
                children: [
                  DraggableWidget(value: CircleSlot()),
                  DraggableWidget(value: CrossSlot()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Border borderBuilder(int index) {
  Border border = Border.all();

  switch (index) {
    case 0:
      return border.copyWith(
        top: border.top.copyWith(style: BorderStyle.none),
        left: border.left.copyWith(style: BorderStyle.none),
      );
    case 1:
      return border.copyWith(
        top: border.top.copyWith(style: BorderStyle.none),
      );
    case 2:
      return border.copyWith(
        top: border.top.copyWith(style: BorderStyle.none),
        right: border.right.copyWith(style: BorderStyle.none),
      );
    case 3:
      return border.copyWith(
        left: border.left.copyWith(style: BorderStyle.none),
      );
    case 4:
      return border;
    case 5:
      return border.copyWith(
        right: border.right.copyWith(style: BorderStyle.none),
      );
    case 6:
      return border.copyWith(
        bottom: border.bottom.copyWith(style: BorderStyle.none),
        left: border.left.copyWith(style: BorderStyle.none),
      );
    case 7:
      return border.copyWith(
        bottom: border.bottom.copyWith(style: BorderStyle.none),
      );
    case 8:
      return border.copyWith(
        bottom: border.bottom.copyWith(style: BorderStyle.none),
        right: border.right.copyWith(style: BorderStyle.none),
      );
    default:
      return border;
  }
}

extension BorderCopyWithExtension on Border {
  Border copyWith({
    BorderSide? top,
    BorderSide? right,
    BorderSide? bottom,
    BorderSide? left,
  }) {
    return Border(
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
      left: left ?? this.left,
    );
  }
}

class DraggableWidget<T extends TicTacToeSlot> extends StatefulWidget {
  const DraggableWidget({
    super.key,
    required this.value,
    this.size = 128.0,
  });

  final double size;
  final T value;

  @override
  State<DraggableWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> with SingleTickerProviderStateMixin {
  late final controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));

  @override
  void initState() {
    super.initState();
    controller.value = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Draggable<TicTacToeSlot>(
      data: widget.value,
      feedback: Material(
        type: MaterialType.transparency,
        child: SizedBox(
          height: widget.size,
          width: widget.size,
          child: Lottie.asset(
            widget.value.value,
            repeat: false,
            controller: controller,
          ),
        ),
      ),
      child: SizedBox(
        height: widget.size,
        width: widget.size,
        child: Lottie.asset(
          widget.value.value,
          repeat: false,
          controller: controller,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
