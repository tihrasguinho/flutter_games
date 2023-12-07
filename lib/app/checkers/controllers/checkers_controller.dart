import '../bloc/checkers_bloc.dart';

class CheckersController {
  final bloc = CheckersBloc();

  CheckersController() {
    bloc.initCheckers();
  }
}
