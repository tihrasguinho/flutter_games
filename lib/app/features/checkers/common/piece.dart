enum Piece {
  white('WHITE', false),
  whiteKing('WHITE', true),
  black('BLACK', false),
  blackKing('BLACK', true),
  empty('', false);

  final String id;
  final bool king;

  const Piece(this.id, this.king);

  bool get isBlack => this == black || this == blackKing;

  bool get isWhite => this == white || this == whiteKing;
}


// class Piece {
//   final String id;
//   final bool king;

//   Piece._(this.id, [this.king = false]);

//   factory Piece.white() => Piece._('white');

//   factory Piece.black() => Piece._('black');

//   factory Piece.empty() => Piece._('');

//   bool get isEmpty => id.isEmpty;

//   bool get isNotEmpty => !isEmpty;

//   Piece copyWith({
//     String? id,
//     bool? king,
//   }) {
//     return Piece._(id ?? this.id, king ?? this.king);
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//     };
//   }

//   factory Piece.fromMap(Map<String, dynamic> map) {
//     return Piece._(map['id'] as String);
//   }

//   String toJson() => json.encode(toMap());

//   factory Piece.fromJson(String source) => Piece.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'Piece(id: $id, king: $king)';

//   @override
//   bool operator ==(covariant Piece other) {
//     if (identical(this, other)) return true;

//     return other.id == id;
//   }

//   @override
//   int get hashCode => id.hashCode;
// }
