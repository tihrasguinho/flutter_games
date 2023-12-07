import 'chess_slot.dart';

sealed class ChessState {
  final List<ChessSlot> slots;

  ChessState(this.slots);

  T when<T>({
    required T Function() onLoading,
    T Function(List<ChessSlot> slots)? onLoaded,
    T Function(String error)? onError,
    T Function()? onWhiteWinner,
    T Function()? onBlackWinner,
  }) {
    return switch (this) {
      LoadingChessState _ => onLoading(),
      LoadedChessState s => onLoaded?.call(s.slots) ?? onLoading(),
      ErrorChessState e => onError?.call(e.error) ?? onLoading(),
      WhiteWinnerState _ => onWhiteWinner?.call() ?? onLoading(),
      BlackWinnerState _ => onBlackWinner?.call() ?? onLoading(),
    };
  }
}

class LoadingChessState extends ChessState {
  LoadingChessState() : super([]);
}

final class LoadedChessState extends ChessState {
  LoadedChessState(super.slots);
}

final class ErrorChessState extends ChessState {
  final String error;
  ErrorChessState(this.error) : super([]);
}

final class WhiteWinnerState extends ChessState {
  WhiteWinnerState() : super([]);
}

final class BlackWinnerState extends ChessState {
  BlackWinnerState() : super([]);
}
