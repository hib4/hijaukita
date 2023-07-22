import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijaukita/features/auth/presentation/pages/login/login_page.dart';
import 'package:hijaukita/features/profile/presentation/bloc/logout_bloc.dart';
import 'package:hijaukita/features/profile/presentation/bloc/logout_state.dart';

import '../../../../../core/route/navigator.dart';
import '../../../../../core/theme/color_values.dart';
import '../../../../../core/widgets/snackbar/snackbar_item.dart';
import '../../bloc/logout_event.dart';
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
            BlocConsumer<LogoutBloc, LogoutState>(
              listener: (context, state) {
                if(state is LogoutSuccess) {
                  navigatorPushAndRemove(context, const LoginPage());
                } else if (state is LogoutFailure) {
                  showSnackBar(context, title: state.message);
                }
              },
              builder: (context, state) {
                if(state is LogoutLoading) {
                  return const Center(child: CircularProgressIndicator(),);
                }
                return listMenu(context, "Keluar",  const Icon(Icons.logout, color: Colors.red,), ColorValues.black01, onTap: () {
                  context.read<LogoutBloc>().add(allLogoutEvent());
                },);
              },
            )
          ],
        ),
      ),
    );
  }
}
