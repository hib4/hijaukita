import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijaukita/features/quiz/presentation/pages/quiz.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../core/pages/failure/failure_page.dart';
import '../../../../core/route/navigator.dart';
import '../../../../core/theme/color_values.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/quiz_detail_activity.dart';
import '../bloc/detail_quiz_activity/quiz_bloc.dart';
import '../bloc/detail_quiz_activity/quiz_event.dart';
import '../bloc/detail_quiz_activity/quiz_state.dart';

class QuizDetailActivityPage extends StatefulWidget {
  const QuizDetailActivityPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<QuizDetailActivityPage> createState() => _QuizDetailActivityPageState();
}

class _QuizDetailActivityPageState extends State<QuizDetailActivityPage> {
  final int _duration = 60;
  late Timer _timer;
  int _remainingTime = 0;
  bool _isCountdownActive = false;

  void _startTimer() {
    _isCountdownActive = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
      });

      if (_remainingTime == 0) {
        _timer.cancel();
        _isCountdownActive = false;
      }
    });
  }

  String _formatDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _remainingTime = _duration;
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl.get<QuizBloc>()
            ..add(
              GetQuizEvent(id: widget.id),
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kuiz'),
        ),
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state is QuizLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is QuizSuccess){
              final data = state.quiz.data;
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: data.video,
                          flags: const YoutubePlayerFlags(
                            autoPlay: false,
                            mute: false,
                            showLiveFullscreenButton: false,
                          ),
                        ),
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: ColorValues.green02,
                        bottomActions: [
                          CurrentPosition(),
                          const SizedBox(width: 10),
                          ProgressBar(isExpanded: true),
                          const SizedBox(width: 10),
                          RemainingDuration(),
                        ],
                        progressColors: const ProgressBarColors(
                          playedColor: ColorValues.green02,
                          handleColor: ColorValues.green02,
                        ),
                      ),
                    ),
                    const SizedBox(height: 19),
                    Text(
                      data.name,
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.description,
                      style: textTheme.bodySmall,
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tombol akan di aktifkan dalam',
                          style: textTheme.bodySmall!
                              .copyWith(color: Colors.grey, fontSize: 10),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDuration(_remainingTime),
                          style: textTheme.bodySmall!.copyWith(
                              color: ColorValues.green02, fontSize: 10),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    _isCountdownActive
                        ? ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text(
                        'Lanjut',
                      ),
                    )
                        : ElevatedButton(
                      onPressed: () {
                        navigatorPush(
                          context,
                          QuizPage(
                            id: widget.id,
                          ),
                        );
                      },
                      child: const Text(
                        'Lanjut',
                      ),
                    )
                  ],
                ),
              );
            } else if (state is QuizFailure) {
              return FailurePage(
                message: state.message,
                onPressed: () {},
              );
            } else {
              return const SizedBox();
            }
          },
        )
      ),
    );
  }
}
