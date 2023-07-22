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
                backgroundImage: const CachedNetworkImageProvider('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60'),
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
            const listEditProfile(tittle: 'Nama', name: 'Jane Doe'),
            const SizedBox(height: 10,),
            const listEditProfile(tittle: 'Email', name: 'janedoe@gmail.com'),
            const Spacer(),
            ElevatedButton(
              onPressed: (){
                navigatorPop(context);
              },
              child: const Text(
                'simpan'
              ),
            )
          ],
        ),
      ),
    );
  }
}
