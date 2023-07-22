import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../core/widgets/dialog/information_dialog.dart';
import '../../domain/entities/conversation.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/chat_text_field.dart';
import '../widgets/chat_message_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Conversation> _conversation = [
    const Conversation(greetingMessage, true),
  ];
  final _scrollController = ScrollController();
  final _questionController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BuGuru AI'),
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => informationDialog(
                context,
                title: 'Tentang BuGuru AI',
                message: greetingMessage,
              ),
            ),
            icon: Assets.icons.information.svg(),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: _buildList(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                  child: _buildInput(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatSuccess) {
          final data = state.conversation;
          _conversation.removeAt(0);
          _addData(data.text, data.isAnswer);
        } else if (state is ChatLoading) {
          _addData(_questionController.text.trim(), false);
          _questionController.clear();
          _addData(typingMessage, true);
        } else if (state is ChatFailure) {
          _conversation.removeAt(0);
          _addData('Maaf, terjadi kesalahan', true);
        }
      },
      builder: (context, state) {
        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: _conversation.length,
          itemBuilder: (_, index) {
            var message = _conversation[index];
            return ChatMessageWidget(
              conversation: Conversation(message.text, message.isAnswer),
            );
          },
        );
      },
    );
  }

  Widget _buildInput() {
    return ChatTextField(
      onSubmitted: () {
        if (_questionController.text.trim().isNotEmpty) {
          context
              .read<ChatBloc>()
              .add(PostChatEvent(message: _questionController.text.trim()));
        }
      },
      controller: _questionController,
    );
  }

  void _addData(String message, bool isAnswer) {
    _conversation.insert(0, Conversation(message, isAnswer));
    _scrollDown();
  }

  void _scrollDown() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
