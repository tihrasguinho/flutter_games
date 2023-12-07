class ChessSlotPredict {
  final List<int> indexesToMove;
  final List<int> finalIndexesToMove;

  const ChessSlotPredict(this.indexesToMove, this.finalIndexesToMove);

  bool get isEmpty => finalIndexesToMove.isEmpty;

  factory ChessSlotPredict.empty() {
    return const ChessSlotPredict([], []);
  }
}
