import 'package:flutter/material.dart';

import '../../../../../core/theme/color_values.dart';
import '../../../../../core/widgets/text_form_field/custom_text_form_field.dart';

class listEditProfile extends StatelessWidget {
  const listEditProfile({Key? key, required this.tittle, required this.name}) : super(key: key);
  final String tittle;
  final String name;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tittle,
          style: textTheme.bodyMedium!.copyWith(
            color: ColorValues.black01,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8,),
        CustomTextFormField(
          controller: TextEditingController(text: name),
          label: 'Nama',
          textInputType: TextInputType.name,
        )
      ],
    );
  }
}
