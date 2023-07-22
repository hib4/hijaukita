import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/route/navigator.dart';
import '../../bloc/classifier/classifier_bloc.dart';

void photoBottomSheet(BuildContext context, String category) {
  final textTheme = Theme.of(context).textTheme;

  showModalBottomSheet(
    context: context,
    builder: (_) => Container(
      width: double.infinity,
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              context.read<ClassifierBloc>().add(
                    PhotoClassifierEvent(
                        isFromCamera: true, category: category),
                  );
              navigatorPop(context);
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ambil dari kamera',
                style: textTheme.titleMedium,
              ),
            ),
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: () {
              context.read<ClassifierBloc>().add(
                    PhotoClassifierEvent(category: category),
                  );
              navigatorPop(context);
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pilih dari galeri',
                style: textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
