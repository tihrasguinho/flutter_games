enum ChessPieceColor { black, white }

enum ChessPieceType { pawn, knight, bishop, rook, queen, king }

class ChessPiece {
  final String emoji;
  final ChessPieceType type;
  final ChessPieceColor color;

  const ChessPiece._(this.emoji, this.type, this.color);

  factory ChessPiece.pawn(ChessPieceColor color) => ChessPiece._('♟️', ChessPieceType.pawn, color);

  factory ChessPiece.knight(ChessPieceColor color) => ChessPiece._('♞', ChessPieceType.knight, color);

  factory ChessPiece.bishop(ChessPieceColor color) => ChessPiece._('♝', ChessPieceType.bishop, color);

  factory ChessPiece.rook(ChessPieceColor color) => ChessPiece._('♜', ChessPieceType.rook, color);

  factory ChessPiece.queen(ChessPieceColor color) => ChessPiece._('♛', ChessPieceType.queen, color);

  factory ChessPiece.king(ChessPieceColor color) => ChessPiece._('♚', ChessPieceType.king, color);

  int get colorValue => switch (color) {
        ChessPieceColor.black => 0xFF000000,
        ChessPieceColor.white => 0xFFFFFFFF,
      };

  @override
  String toString() {
    return 'ChessPiece($emoji)';
  }

  @override
  bool operator ==(covariant ChessPiece other) {
    return other.emoji == emoji;
  }

  @override
  int get hashCode => emoji.hashCode;
}
