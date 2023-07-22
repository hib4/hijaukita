import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/pages/success/success_page.dart';
import '../../../../../core/route/navigator.dart';
import '../../../../../core/widgets/snackbar/snackbar_item.dart';
import '../../../../../core/widgets/text_form_field/custom_text_form_field.dart';
import '../../../../../injection_container.dart';
import '../../bloc/classifier/classifier_bloc.dart';
import '../../bloc/upload_photo/upload_photo_bloc.dart';
import '../../widgets/upload_photo/photo_container_widget.dart';

class UploadPhotoPage extends StatefulWidget {
  const UploadPhotoPage({super.key, required this.activityId, this.category});

  final int activityId;
  final String? category;

  @override
  State<UploadPhotoPage> createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  late final ClassifierBloc _classifierBloc;
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _classifierBloc = ClassifierBloc();
  }

  @override
  void dispose() {
    _classifierBloc.close();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => _classifierBloc,
        ),
        BlocProvider(
          create: (_) => sl.get<UploadPhotoBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Unggah Foto ${widget.category ?? ''}'),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocProvider.value(
                      value: _classifierBloc,
                      child: PhotoContainerWidget(
                        category: widget.category ?? '',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Deskripsi', style: textTheme.titleMedium),
                    const SizedBox(height: 4),
                    CustomTextFormField(
                      label: 'Masukkan deskripsi (opsional)',
                      controller: _descriptionController,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 68),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                color: Colors.white,
                child: BlocBuilder<ClassifierBloc, ClassifierState>(
                  builder: (context, classifier) {
                    return BlocConsumer<UploadPhotoBloc, UploadPhotoState>(
                      listener: (context, state) {
                        if (state is UploadPhotoSuccess) {
                          navigatorPushAndRemove(context, const SuccessPage());
                        } else if (state is UploadPhotoFailure) {
                          showSnackBar(context, title: state.message);
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: classifier is ClassifierSuccess
                              ? () {
                                  context.read<UploadPhotoBloc>().add(
                                        PostUploadPhotoEvent(
                                          activityId: widget.activityId,
                                          desc: _descriptionController.text,
                                          photo: classifier.path,
                                        ),
                                      );
                                }
                              : null,
                          child: state is UploadPhotoLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text('Kirim'),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
