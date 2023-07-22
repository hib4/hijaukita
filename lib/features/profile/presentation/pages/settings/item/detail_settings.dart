import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/route/navigator.dart';
import '../../../../../../core/theme/color_values.dart';
import '../../../widgets/item_settings/edit_textfield_widget.dart';

class DetailSettings extends StatefulWidget {
  const DetailSettings({Key? key}) : super(key: key);

  @override
  State<DetailSettings> createState() => _DetailSettingsState();
}

class _DetailSettingsState extends State<DetailSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Positioned(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: ColorValues.grey02,
                backgroundImage: const CachedNetworkImageProvider(
                  'https://images.unsplash.com/photo-1496302662116-35cc4f36df92?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: ColorValues.green02,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const listEditProfile(
              tittle: 'Nama',
              name: 'Hiba Kun',
            ),
            const SizedBox(
              height: 10,
            ),
            const listEditProfile(
              tittle: 'Email',
              name: 'hibakun8@gmail.com',
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                navigatorPop(context);
              },
              child: const Text('Simpan'),
            )
          ],
        ),
      ),
    );
  }
}
