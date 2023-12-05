sealed class TicTacToeSlot {
  final int index;
  final String value;

  TicTacToeSlot(this.index, this.value);

  TicTacToeSlot copyWith(int index) {
    return switch (this) {
      CircleSlot _ => CircleSlot(index),
      CrossSlot _ => CrossSlot(index),
      EmptySlot _ => EmptySlot(index),
    };
  }
}

final class EmptySlot extends TicTacToeSlot {
  EmptySlot(int index) : super(index, '');
}

final class CrossSlot extends TicTacToeSlot {
  CrossSlot([int index = 0]) : super(index, 'assets/red.json');
}

final class CircleSlot extends TicTacToeSlot {
  CircleSlot([int index = 0]) : super(index, 'assets/green.json');
}
