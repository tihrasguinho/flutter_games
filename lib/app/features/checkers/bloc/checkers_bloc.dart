import 'package:flutter/material.dart';

import '../common/slot.dart';
import '../states/checkers_state.dart';

class CheckersBloc extends ValueNotifier<CheckersState> {
  int get blackPieces => value.slots.expand((row) => row).where((slot) => slot.value.isBlack).length;

  int get whitePieces => value.slots.expand((row) => row).where((slot) => slot.value.isWhite).length;

  Piece currentPlayer = White();

  CheckersBloc() : super(InitialCheckersState());

  void updateCheckers(Slot from, Slot to) {
    final slots = value.slots;

    if (from.nonPlayable || to.nonPlayable) {
      return;
    } else if (!to.value.isEmpty) {
      return;
    } else if (from.rowDiff(to.row) != from.columnDiff(to.column)) {
      return;
    } else if (from.rowDiff(to.row) >= 2) {
      final rowDiff = to.row - from.row;
      final columnDiff = to.column - from.column;

      final middleSlots = <Slot>[];

      for (var i = 0; i < from.rowDiff(to.row); i++) {
        final rowIndex = rowDiff.isNegative ? from.row - (from.rowDiff(to.row) - i) : from.row + (from.rowDiff(to.row) - i);
        final columnIndex = columnDiff.isNegative ? from.column - (from.columnDiff(to.column) - i) : from.column + (from.columnDiff(to.column) - i);

        middleSlots.add(slots[rowIndex.abs()][columnIndex.abs()]);
      }

      if (middleSlots.where((slot) => slot.value.runtimeType == from.value.runtimeType).isNotEmpty) {
        return;
      } else if (middleSlots.length == 2) {
        final middleSlot = middleSlots.last;

        slots[middleSlot.row][middleSlot.column] = Slot.empty(middleSlot.id);
      } else if (from.value.isBlackAndKing && middleSlots.where((slot) => slot.value.isWhite).length > 1) {
        return;
      } else if (from.value.isBlackAndKing && middleSlots.where((slot) => slot.value.isWhite).length == 1) {
        final middleSlot = middleSlots.firstWhere((slot) => slot.value.isWhite);

        slots[middleSlot.row][middleSlot.column] = Slot.empty(middleSlot.id);
      } else if (from.value.isWhiteAndKing && middleSlots.where((slot) => slot.value.isBlack).length > 1) {
        return;
      } else if (from.value.isWhiteAndKing && middleSlots.where((slot) => slot.value.isBlack).length == 1) {
        final middleSlot = middleSlots.firstWhere((slot) => slot.value.isBlack);

        slots[middleSlot.row][middleSlot.column] = Slot.empty(middleSlot.id);
      }
    } else if ((from.value.isWhiteAndNotKing || from.value.isBlackAndNotKing) && ((from.value.isBlack && (from.row - to.row).isNegative) || (from.value.isWhite && !(from.row - to.row).isNegative))) {
      return;
    } else if (from.rowDiff(to.row) > 1 && (from.value.isWhiteAndNotKing || from.value.isBlackAndNotKing)) {
      return;
    }

    slots[from.row][from.column] = to.copyWith(id: from.id);

    slots[to.row][to.column] = from.copyWith(
      id: to.id,
      value: from.value.isBlack && to.row == 0
          ? from.value.copyWith(king: true)
          : from.value.isWhite && to.row == 7
              ? from.value.copyWith(king: true)
              : from.value,
    );

    currentPlayer = switch (currentPlayer) {
      White _ => Black(),
      Black _ => White(),
      _ => currentPlayer,
    };

    value = LoadedCheckersState(slots);
  }

  void initCheckers() {
    value = LoadedCheckersState(
      <List<Slot>>[
        List.generate(8, (i) => i % 2 == 1 ? Slot.whitePiece('A$i') : Slot.nonPlayable('A$i')),
        List.generate(8, (i) => i % 2 == 0 ? Slot.whitePiece('B$i') : Slot.nonPlayable('B$i')),
        List.generate(8, (i) => i % 2 == 1 ? Slot.whitePiece('C$i') : Slot.nonPlayable('C$i')),
        List.generate(8, (i) => i % 2 == 0 ? Slot.empty('D$i') : Slot.nonPlayable('D$i')),
        List.generate(8, (i) => i % 2 == 1 ? Slot.empty('E$i') : Slot.nonPlayable('E$i')),
        List.generate(8, (i) => i % 2 == 0 ? Slot.blackPiece('F$i') : Slot.nonPlayable('F$i')),
        List.generate(8, (i) => i % 2 == 1 ? Slot.blackPiece('G$i') : Slot.nonPlayable('G$i')),
        List.generate(8, (i) => i % 2 == 0 ? Slot.blackPiece('H$i') : Slot.nonPlayable('H$i')),
      ],
    );
  }
}
