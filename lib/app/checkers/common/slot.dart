class Slot {
  final String id;
  final Piece value;
  late final bool nonPlayable;

  Slot._(this.id, this.value, [this.nonPlayable = false]);

  int get row => switch (id[0]) {
        'A' => 0,
        'B' => 1,
        'C' => 2,
        'D' => 3,
        'E' => 4,
        'F' => 5,
        'G' => 6,
        'H' => 7,
        _ => 0,
      };

  int get column => int.parse(id[1]);

  int rowDiff(int other) {
    return (other - row).abs();
  }

  int columnDiff(int other) {
    return (other - column).abs();
  }

  factory Slot.empty(String id) {
    return Slot._(id, Empty());
  }

  factory Slot.whitePiece(String id) {
    return Slot._(id, White());
  }

  factory Slot.blackPiece(String id) {
    return Slot._(id, Black());
  }

  factory Slot.nonPlayable(String id) {
    return Slot._(id, Empty(), true);
  }

  Slot copyWith({
    String? id,
    Piece? value,
  }) {
    return Slot._(
      id ?? this.id,
      value ?? this.value,
    );
  }

  @override
  String toString() => '$runtimeType(id: $id, value: $value)';

  @override
  bool operator ==(Object other) => other is Slot && other.id == id && other.value == value;

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}

sealed class Piece {
  final bool king;

  Piece(this.king);

  Piece copyWith({bool? king}) {
    return switch (this) {
      Black b => Black(king ?? b.king),
      White w => White(king ?? w.king),
      Empty _ => Empty(),
    };
  }

  bool get isWhite => this is White;

  bool get isWhiteAndKing => this is White && king;

  bool get isWhiteAndNotKing => this is White && !king;

  bool get isBlack => this is Black;

  bool get isBlackAndKing => this is Black && king;

  bool get isBlackAndNotKing => this is Black && !king;

  bool get isEmpty => this is Empty;

  String get name => switch (this) {
        Black _ => 'Black',
        White _ => 'White',
        Empty _ => 'Empty',
      };

  @override
  String toString() => '$runtimeType(king: $king)';
}

final class Black extends Piece {
  Black([super.king = false]);
}

final class White extends Piece {
  White([super.king = false]);
}

final class Empty extends Piece {
  Empty() : super(false);
}
