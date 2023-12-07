import '../common/slot.dart';

sealed class CheckersState {
  final List<List<Slot>> slots;

  CheckersState(this.slots);

  T when<T>({
    required T Function() onInitial,
    T Function(List<List<Slot>> slots)? onLoaded,
    T Function(String error)? onError,
  }) {
    return switch (this) {
      InitialCheckersState _ => onInitial(),
      LoadedCheckersState s => onLoaded?.call(s.slots) ?? onInitial(),
      ErrorCheckersState e => onError?.call(e.error) ?? onInitial(),
    };
  }
}

class InitialCheckersState extends CheckersState {
  InitialCheckersState() : super([]);
}

final class LoadedCheckersState extends CheckersState {
  LoadedCheckersState(super.slots);
}

final class ErrorCheckersState extends CheckersState {
  final String error;

  ErrorCheckersState(this.error) : super([]);
}
