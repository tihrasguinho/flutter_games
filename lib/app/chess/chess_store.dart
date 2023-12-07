import 'package:flutter/material.dart';

import 'chess_piece.dart';
import 'chess_slot.dart';
import 'chess_slot_predict.dart';
import 'chess_state.dart';

class ChessStore extends ValueNotifier<ChessState> {
  ChessStore() : super(LoadedChessState(_defaultValues));

  void updateSlot(ChessSlot from, ChessSlot to) {
    final slots = value.slots;

    slots[slots.indexOf(from)] = to.copyWith(id: from.id);

    slots[slots.indexOf(to)] = from.copyWith(id: to.id);

    value = LoadedChessState(slots);
  }

  ChessSlotPredict slotValidate(ChessSlot slot) {
    if (slot.piece == null) return ChessSlotPredict.empty();

    final slots = value.slots;

    if (slot.piece?.type == ChessPieceType.pawn) {
      if (slot.piece?.color == ChessPieceColor.white) {
        final index = slots.indexOf(slot);

        final nextSlot = slots[index - 8];

        if (nextSlot.piece == null) {
          return ChessSlotPredict([index - 8], [index - 8]);
        }
      }

      if (slot.piece?.color == ChessPieceColor.black) {
        final index = slots.indexOf(slot);

        final nextSlot = slots[index + 8];

        if (nextSlot.piece == null) {
          return ChessSlotPredict([index + 8], [index + 8]);
        }
      }
    } else if (slot.piece?.type == ChessPieceType.rook) {
      final index = slots.indexOf(slot);

      final nextIndexes = <int>[];

      for (var i = 1; i < 8; i++) {
        if (slots.asMap().containsKey(index + i * 8) && slots[index + i * 8].piece == null) {
          nextIndexes.add(index + i * 8);
        } else {
          break;
        }
      }

      for (var i = 1; i < 8; i++) {
        if (slots.asMap().containsKey(index - i * 8) && slots[index - i * 8].piece == null) {
          nextIndexes.add(index - i * 8);
        } else {
          break;
        }
      }

      for (var i = 1; i < 8 - slot.column; i++) {
        if (slots.asMap().containsKey(index + i) && slots[index + i].piece == null) {
          nextIndexes.add(index + i);
        } else {
          break;
        }
      }

      for (var i = 1; i < slot.column + 1; i++) {
        if (slots.asMap().containsKey(index - i) && slots[index - i].piece == null) {
          nextIndexes.add(index - i);
        } else {
          break;
        }
      }

      return ChessSlotPredict(nextIndexes, nextIndexes);
    } else if (slot.piece?.type == ChessPieceType.knight) {
      final index = slots.indexOf(slot);

      final nextIndexes = [
        if (slots.asMap().containsKey(index + 6) && slots[index + 6].piece == null) index + 6,
        if (slots.asMap().containsKey(index + 10) && slots[index + 10].piece == null) index + 10,
        if (slots.asMap().containsKey(index - 6) && slots[index - 6].piece == null) index - 6,
        if (slots.asMap().containsKey(index - 10) && slots[index - 10].piece == null) index - 10,
        if (slots.asMap().containsKey(index + 15) && slots[index + 15].piece == null) index + 15,
        if (slots.asMap().containsKey(index + 17) && slots[index + 17].piece == null) index + 17,
        if (slots.asMap().containsKey(index - 15) && slots[index - 15].piece == null) index - 15,
        if (slots.asMap().containsKey(index - 17) && slots[index - 17].piece == null) index - 17,
      ];

      return ChessSlotPredict(nextIndexes, nextIndexes);
    } else if (slot.piece?.type == ChessPieceType.bishop) {
      final index = slots.indexOf(slot);

      final nextIndexes = <int>[];

      for (var i = 1; i < 8 - slot.column; i++) {
        if (slots.asMap().containsKey(index + i * 9) && slots[index + i * 9].piece == null) {
          nextIndexes.add(index + i * 9);
        } else {
          break;
        }
      }

      for (var i = 1; i < slot.column + 1; i++) {
        if (slots.asMap().containsKey(index - i * 9) && slots[index - i * 9].piece == null) {
          nextIndexes.add(index - i * 9);
        } else {
          break;
        }
      }

      for (var i = 1; i < 8 - slot.column; i++) {
        if (slots.asMap().containsKey(index + i * 7) && slots[index + i * 7].piece == null) {
          nextIndexes.add(index + i * 7);
        } else {
          break;
        }
      }

      for (var i = 1; i < slot.column + 1; i++) {
        if (slots.asMap().containsKey(index - i * 7) && slots[index - i * 7].piece == null) {
          nextIndexes.add(index - i * 7);
        } else {
          break;
        }
      }

      return ChessSlotPredict(nextIndexes, nextIndexes);
    } else if (slot.piece?.type == ChessPieceType.queen) {
      final index = slots.indexOf(slot);

      final nextIndexes = <int>[];

      for (var i = 1; i < 8 - slot.column; i++) {
        if (slots.asMap().containsKey(index + i * 9) && slots[index + i * 9].piece == null) {
          nextIndexes.add(index + i * 9);
        } else {
          break;
        }
      }

      for (var i = 1; i < slot.column + 1; i++) {
        if (slots.asMap().containsKey(index - i * 9) && slots[index - i * 9].piece == null) {
          nextIndexes.add(index - i * 9);
        } else {
          break;
        }
      }

      for (var i = 1; i < 8 - slot.column; i++) {
        if (slots.asMap().containsKey(index + i * 7) && slots[index + i * 7].piece == null) {
          nextIndexes.add(index + i * 7);
        } else {
          break;
        }
      }

      for (var i = 1; i < slot.column + 1; i++) {
        if (slots.asMap().containsKey(index - i * 7) && slots[index - i * 7].piece == null) {
          nextIndexes.add(index - i * 7);
        } else {
          break;
        }
      }

      for (var i = 1; i < 8; i++) {
        if (slots.asMap().containsKey(index + i * 8) && slots[index + i * 8].piece == null) {
          nextIndexes.add(index + i * 8);
        } else {
          break;
        }
      }

      for (var i = 1; i < 8; i++) {
        if (slots.asMap().containsKey(index - i * 8) && slots[index - i * 8].piece == null) {
          nextIndexes.add(index - i * 8);
        } else {
          break;
        }
      }

      for (var i = 1; i < 8 - slot.column; i++) {
        if (slots.asMap().containsKey(index + i) && slots[index + i].piece == null) {
          nextIndexes.add(index + i);
        } else {
          break;
        }
      }

      for (var i = 1; i < slot.column + 1; i++) {
        if (slots.asMap().containsKey(index - i) && slots[index - i].piece == null) {
          nextIndexes.add(index - i);
        } else {
          break;
        }
      }

      return ChessSlotPredict(nextIndexes, nextIndexes);
    } else if (slot.piece?.type == ChessPieceType.king) {
      final index = slots.indexOf(slot);

      final nextIndexes = <int>[];

      for (var i = 1; i < 2; i++) {
        if (slots.asMap().containsKey(index + i * 9) && slots[index + i * 9].piece == null) {
          nextIndexes.add(index + i * 9);
        } else {
          break;
        }
      }

      for (var i = 1; i < 2; i++) {
        if (slots.asMap().containsKey(index - i * 9) && slots[index - i * 9].piece == null) {
          nextIndexes.add(index - i * 9);
        } else {
          break;
        }
      }

      for (var i = 1; i < 2; i++) {
        if (slots.asMap().containsKey(index + i * 7) && slots[index + i * 7].piece == null) {
          nextIndexes.add(index + i * 7);
        } else {
          break;
        }
      }

      for (var i = 1; i < 2; i++) {
        if (slots.asMap().containsKey(index - i * 7) && slots[index - i * 7].piece == null) {
          nextIndexes.add(index - i * 7);
        } else {
          break;
        }
      }

      for (var i = 1; i < 2; i++) {
        if (slots.asMap().containsKey(index + i * 8) && slots[index + i * 8].piece == null) {
          nextIndexes.add(index + i * 8);
        } else {
          break;
        }
      }

      for (var i = 1; i < 2; i++) {
        if (slots.asMap().containsKey(index - i * 8) && slots[index - i * 8].piece == null) {
          nextIndexes.add(index - i * 8);
        } else {
          break;
        }
      }

      for (var i = 1; i < 2; i++) {
        if (slots.asMap().containsKey(index + i) && slots[index + i].piece == null) {
          nextIndexes.add(index + i);
        } else {
          break;
        }
      }

      for (var i = 1; i < 2; i++) {
        if (slots.asMap().containsKey(index - i) && slots[index - i].piece == null) {
          nextIndexes.add(index - i);
        } else {
          break;
        }
      }

      return ChessSlotPredict(nextIndexes, nextIndexes);
    }

    return ChessSlotPredict.empty();
  }
}

final _defaultValues = [
  ChessSlot('A0', ChessPiece.rook(ChessPieceColor.black)),
  ChessSlot('A1', ChessPiece.knight(ChessPieceColor.black)),
  ChessSlot('A2', ChessPiece.bishop(ChessPieceColor.black)),
  ChessSlot('A3', ChessPiece.queen(ChessPieceColor.black)),
  ChessSlot('A4', ChessPiece.king(ChessPieceColor.black)),
  ChessSlot('A5', ChessPiece.bishop(ChessPieceColor.black)),
  ChessSlot('A6', ChessPiece.knight(ChessPieceColor.black)),
  ChessSlot('A7', ChessPiece.rook(ChessPieceColor.black)),
  ChessSlot('B0', ChessPiece.pawn(ChessPieceColor.black)),
  ChessSlot('B1', ChessPiece.pawn(ChessPieceColor.black)),
  ChessSlot('B2', ChessPiece.pawn(ChessPieceColor.black)),
  ChessSlot('B3', ChessPiece.pawn(ChessPieceColor.black)),
  ChessSlot('B4', ChessPiece.pawn(ChessPieceColor.black)),
  ChessSlot('B5', ChessPiece.pawn(ChessPieceColor.black)),
  ChessSlot('B6', ChessPiece.pawn(ChessPieceColor.black)),
  ChessSlot('B7', ChessPiece.pawn(ChessPieceColor.black)),
  ...List.generate(8, (index) => ChessSlot('C$index', null)),
  ...List.generate(8, (index) => ChessSlot('D$index', null)),
  ...List.generate(8, (index) => ChessSlot('E$index', null)),
  ...List.generate(8, (index) => ChessSlot('F$index', null)),
  ChessSlot('G0', ChessPiece.pawn(ChessPieceColor.white)),
  ChessSlot('G1', ChessPiece.pawn(ChessPieceColor.white)),
  ChessSlot('G2', ChessPiece.pawn(ChessPieceColor.white)),
  ChessSlot('G3', ChessPiece.pawn(ChessPieceColor.white)),
  ChessSlot('G4', ChessPiece.pawn(ChessPieceColor.white)),
  ChessSlot('G5', ChessPiece.pawn(ChessPieceColor.white)),
  ChessSlot('G6', ChessPiece.pawn(ChessPieceColor.white)),
  ChessSlot('G7', ChessPiece.pawn(ChessPieceColor.white)),
  ChessSlot('H0', ChessPiece.rook(ChessPieceColor.white)),
  ChessSlot('H1', ChessPiece.knight(ChessPieceColor.white)),
  ChessSlot('H2', ChessPiece.bishop(ChessPieceColor.white)),
  ChessSlot('H3', ChessPiece.queen(ChessPieceColor.white)),
  ChessSlot('H4', ChessPiece.king(ChessPieceColor.white)),
  ChessSlot('H5', ChessPiece.bishop(ChessPieceColor.white)),
  ChessSlot('H6', ChessPiece.knight(ChessPieceColor.white)),
  ChessSlot('H7', ChessPiece.rook(ChessPieceColor.white)),
];
