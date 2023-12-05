sealed class Slot<T extends Object?> {
  final int index;
  final T? value;

  const Slot(this.index, this.value);
}

final class EmptySlot<T extends Object?> extends Slot<T> {
  const EmptySlot(int index) : super(index, null);
}

final class FilledSlot<T extends Object?> extends Slot<T> {
  const FilledSlot(int index, T value) : super(index, value);
}
