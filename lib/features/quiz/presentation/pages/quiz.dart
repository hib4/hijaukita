import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../core/pages/failure/failure_page.dart';
import '../../../../core/pages/success/success_page.dart';
import '../../../../core/route/navigator.dart';
import '../../../../core/theme/color_values.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/quiz_detail_activity.dart';
import '../bloc/main_quiz/main_quiz_bloc.dart';
import '../bloc/main_quiz/main_quiz_event.dart';
import '../bloc/main_quiz/main_quiz_state.dart';
import 'answer_quiz.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  int score = 0;
  PageController? _controller;
  String btnText = "Selanjutnya";
  bool answered = false;
  final List<bool> buttonStatusList = [];
  final List<QuizQuestion> quizQuestions = [];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Kuis'),
        leading: IconButton(
          onPressed: () => navigatorPop(context),
          icon: Assets.icons.arrow.svg(),
        ),
      ),
      body: MultiBlocProvider(
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
            if (state is QuizMainLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is QuizMainSuccess) {
              final data = state.quiz.data;
              quizQuestions.addAll(data.quizQuestion);
              buttonStatusList.addAll(List<bool>.filled(data.quizQuestion.length, false));
              return PageView.builder(
                controller: _controller!,
                onPageChanged: (page) {
                  if (page == quizQuestions.length - 1) {
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
                  if (index >= quizQuestions.length) {
                    return const Center(
                      child: Text("Pertanyaan tidak ditemukan."),
                    );
                  }

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
                      Container(
                        padding: const EdgeInsets.all(24.0),
                        child: Wrap(
                          children: [
                            for (int i = 0; i < quizQuestions[index].quizAnswer.length; i++)
                              answered
                                  ? ResultQuizPage(
                                buttonStatusList: buttonStatusList,
                                index: index,
                                i: i,
                                selectedAnswer: quizQuestions[index].correctAnswer,
                                answerQuizText: quizQuestions[index].explaination,
                                isCoorect: quizQuestions[index].quizAnswer[i].isCorrect,
                              )
                                  : Container(
                                width: double.infinity,
                                height: 46.0,
                                margin: const EdgeInsets.only(bottom: 20.0),
                                child: RawMaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      for (int j = 0; j < buttonStatusList.length; j++) {
                                        buttonStatusList[j] = false;
                                      }
                                      buttonStatusList[i] = true;
                                      answered = true;
                                    });
                                  },
                                  fillColor: buttonStatusList[i] ? ColorValues.green02 : ColorValues.grey01,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: buttonStatusList[i],
                                        groupValue: true,
                                        onChanged: (value) {
                                          setState(() {
                                            for (int j = 0; j < buttonStatusList.length; j++) {
                                              buttonStatusList[j] = false;
                                            }
                                            buttonStatusList[i] = true;
                                            answered = true;
                                          });
                                        },
                                        activeColor: Colors.white,
                                        fillColor: MaterialStateProperty.resolveWith<Color?>(
                                              (states) {
                                            if (states.contains(MaterialState.selected)) {
                                              return Colors.white;
                                            } else {
                                              return ColorValues.green02;
                                            }
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          quizQuestions[index].quizAnswer[i].answer,
                                          style: textTheme.bodyMedium!.copyWith(
                                            color: buttonStatusList[i] ? Colors.white : ColorValues.black01,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(24.0),
                        child: GestureDetector(
                          onTap: () {
                            if (index == data.quizQuestion.length - 1) {
                            } else if (answered) {
                              _controller!.nextPage(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut);
                              answered = false;
                              for (int j = 0; j < buttonStatusList.length; j++) {
                                buttonStatusList[j] = false;
                              }
                            } else {
                              setState(() {
                                answered = true;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: answered ? ColorValues.green02 : Colors.transparent),
                              color: answered ? ColorValues.green02 : Colors.transparent,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: GestureDetector(
                              onTap: (){
                                if (index == data.quizQuestion.length - 1) {
                                  navigatorPush(
                                    context,
                                    const SuccessPage()
                                  );
                                } else if (answered) {
                                  _controller!.nextPage(
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut);
                                  answered = false;
                                  for (int j = 0; j < buttonStatusList.length; j++) {
                                    buttonStatusList[j] = false;
                                  }
                                } else {
                                  setState(() {
                                    answered = true;
                                  });
                                }
                              },
                              child: Text(
                                answered ? (index == data.quizQuestion.length - 1 ? "Selesai" : "Selanjutnya") : "",
                                style: textTheme.titleMedium!.copyWith(
                                  color: answered ? Colors.white : Colors.transparent,
                                ),
                              ),
                            )
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  );
                },
                itemCount: quizQuestions.length,
              );
            } else if (state is QuizMainFailure) {
              return FailurePage(
                message: state.message,
                onPressed: () {},
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
