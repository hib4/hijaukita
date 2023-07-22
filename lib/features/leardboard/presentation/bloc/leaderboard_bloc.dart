import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../data/repositories/leaderboard_repository.dart';
import '../../domain/entities/leaderboard.dart';
import 'leaderboard_event.dart';
import 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState>{
  LeaderboardBloc({required LeaderboardRepository repository}) : _repository = repository, super(LeaderboardInitial()){
    on<GetLeaderboardEvent>(_getLeaderboardEventHandler);
  }

  final LeaderboardRepository _repository;

  Future<void> _getLeaderboardEventHandler(GetLeaderboardEvent event, Emitter<LeaderboardState> emit) async {
    emit(LeaderboardLoading());

    final either = await _repository.getLeaderboard(event.type);

    _emitLeaderboardResult(either, emit);
  }

  Future<void> _emitLeaderboardResult(Either<Failure, Leaderboard> either, Emitter<LeaderboardState> emit) async {
    await either.fold(
          (failure) async {
        emit(
          LeaderboardFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
          (leaderboard) async {
        emit(LeaderboardSuccess(
          leaderboard: leaderboard,
        ));
      },
    );
  }
}