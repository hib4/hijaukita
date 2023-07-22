import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../data/repositories/chat_repository.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/conversation.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required ChatRepository repository})
      : _repository = repository,
        super(ChatInitial()) {
    on<PostChatEvent>(_postChatEventHandler);
  }

  final ChatRepository _repository;

  Future<void> _postChatEventHandler(
    PostChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    final either = await _repository.postChat(event.message);
    _emitChatResult(either, emit);
  }

  Future<void> _emitChatResult(
    Either<Failure, Chat> either,
    Emitter<ChatState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          ChatFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (chat) {
        emit(
          ChatSuccess(
            conversation: Conversation(chat.choices[0].message.content, true),
          ),
        );
      },
    );
  }
}
