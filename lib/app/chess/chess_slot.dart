import 'chess_piece.dart';

class ChessSlot {
  final String id;
  final ChessPiece? piece;

  const ChessSlot(this.id, this.piece);

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

  int get colorValue => (row + column) % 2 == 0 ? 0xFFFFFFFF : 0x95000000;

  ChessSlot copyWith({
    String? id,
    ChessPiece? Function()? piece,
  }) {
    return ChessSlot(
      id ?? this.id,
      piece != null ? piece() : this.piece,
    );
  }

  @override
  String toString() {
    return 'ChessSlot($id, $piece)';
  }

  @override
  bool operator ==(covariant ChessSlot other) {
    return other.id == id && other.piece == piece;
  }

  @override
  int get hashCode => id.hashCode ^ piece.hashCode;
}
