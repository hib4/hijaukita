import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/pages/failure/failure_page.dart';
import '../../../../core/theme/color_values.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/quiz_detail_activity.dart';
import '../bloc/main_quiz/main_quiz_bloc.dart';
import '../bloc/main_quiz/main_quiz_event.dart';
import '../bloc/main_quiz/main_quiz_state.dart';

class PageWidget extends StatefulWidget {
  const PageWidget({Key? key, required this.id}) : super(key: key);

  final int id;
  @override
  State<PageWidget> createState() => _PageWidgetState();
}

class _PageWidgetState extends State<PageWidget> {

  int score = 0;
  PageController? _controller;
  String btnText = "Selanjutnya";
  bool answered = false;
  final List<bool> buttonStatusList = [];
  final List<QuizQuestion> quizQuestions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
    buttonStatusList.addAll(List<bool>.filled(quizQuestions.length, false));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl.get<QuizMainBloc>()
            ..add(
              GetQuizMainEvent(
                id: widget.id,
              ),
            ),
        ),
      ],
      child: BlocBuilder<QuizMainBloc, QuizMainState>(
        builder: (context, state) {
          if (state is QuizMainLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (state is QuizMainSuccess){
            final data = state.quiz.data;
            return PageView.builder(
              controller: _controller!,
              onPageChanged: (page) {
                if (page == data.quizQuestion.length - 1) {
                  setState(() {
                    btnText = "Lihat Hasil";
                  });
                }
                setState(() {
                  answered = false;
                });
              },
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.0,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: LinearProgressIndicator(
                                value: (index + 1) / data.quizQuestion.length,
                                backgroundColor: ColorValues.grey01,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    ColorValues.green02),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0,),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(17.0),
                            decoration: BoxDecoration(
                              color: const Color(0xffFFE1E1).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Pertanyaan",
                                      style: textTheme.titleMedium!.copyWith(
                                        color: ColorValues.black01,
                                      ),
                                    ),
                                    const SizedBox(width: 5.0,),
                                    Text(
                                      "${index + 1}",
                                      style: textTheme.titleLarge!.copyWith(
                                        color: ColorValues.black01,
                                      ),
                                    ),
                                    Text(
                                      "/${data.quizQuestion.length}",
                                      style: textTheme.bodySmall!.copyWith(
                                        color: ColorValues.black01,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  data.quizQuestion[index].question,
                                  style:textTheme.bodySmall!.copyWith(
                                    color: ColorValues.black01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 20.0, color: Colors.grey[200],),
                  ],
                );
              },
              itemCount: data.quizQuestion.length,
            );
          }
          else if (state is QuizMainFailure) {
            return FailurePage(
              message: state.message,
              onPressed: () {},
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }



}
