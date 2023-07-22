import 'package:flutter/material.dart';

import '../../../../../core/route/navigator.dart';
import '../../../../../core/theme/color_values.dart';
import '../../widgets/item_settings/list_settings.dart';
import 'item/detail_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            listMenu(context, "Ubah Profil",  const Icon(Icons.info_outline_rounded, color: ColorValues.green02,), ColorValues.black01, onTap: () {
              navigatorPush(context, const DetailSettings());
            },),
            const SizedBox(height: 10,),
            listMenu(context, "Keluar",  const Icon(Icons.logout, color: Colors.red,), ColorValues.black01, onTap: () {},)
          ],
        ),
      ),
    );
  }
}
