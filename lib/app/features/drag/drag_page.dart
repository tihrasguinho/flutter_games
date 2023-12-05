import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'slot.dart';

class DragPage extends StatefulWidget {
  const DragPage({super.key});

  @override
  State<DragPage> createState() => _DragPageState();
}

class _DragPageState extends State<DragPage> {
  final slotsSignal = signal(<Slot<String>>[...List.generate(12 * 12, (index) => EmptySlot<String>(index))]);

  void insertSlot(int index, Slot<String> slot) {
    slotsSignal.value = [...slotsSignal.value.take(index), slot, ...slotsSignal.value.skip(index + 1)];
  }

  @override
  Widget build(BuildContext context) {
    final slots = slotsSignal.watch(context);

    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth >= 1024.0 ? 1024.0 : constraints.maxWidth;

              return Center(
                child: SizedBox(
                  width: width,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 12),
                      itemCount: slots.length,
                      itemBuilder: (context, index) {
                        final slot = slots[index];

                        return CardTarget<String>(
                          index: slot.index,
                          value: slot.value,
                          onAccept: (value) {
                            if (value != null) {
                              insertSlot(slot.index, FilledSlot<String>(slot.index, value));
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [1, 2, 3, 4, 5]
                  .map(
                    (e) => Draggable<String>(
                      data: e.toString(),
                      feedback: Material(
                        type: MaterialType.transparency,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            color: Colors.white70,
                          ),
                          alignment: Alignment.center,
                          child: Text(e.toString()),
                        ),
                      ),
                      childWhenDragging: const SizedBox(
                        width: 100,
                        height: 100,
                      ),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          color: Colors.white70,
                        ),
                        alignment: Alignment.center,
                        child: Text(e.toString()),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CardTarget<T extends Object> extends StatefulWidget {
  const CardTarget({
    super.key,
    required this.index,
    this.value,
    this.onAccept,
  });

  final int index;
  final T? value;

  final void Function(T? value)? onAccept;

  @override
  State<CardTarget<T>> createState() => _CardTargetState<T>();
}

class _CardTargetState<T extends Object> extends State<CardTarget<T>> {
  final hoverSignal = signal(false);

  bool get isHovering => hoverSignal.value;

  void onHover(bool isHovering) {
    hoverSignal.value = isHovering;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: DragTarget<T>(
        onMove: (details) => onHover(true),
        onLeave: (details) => onHover(false),
        onAccept: (value) {
          widget.onAccept?.call(value);
          onHover(false);
        },
        builder: (context, _, __) {
          return SizedBox(
            child: Center(
              child: Text(
                '${widget.index + 1}\n${widget.value}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isHovering ? Colors.blue : Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
