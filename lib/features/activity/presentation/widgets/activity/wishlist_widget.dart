import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/color_values.dart';
import '../../../../../core/widgets/snackbar/snackbar_item.dart';
import '../../bloc/wishlist/wishlist_bloc.dart';

class WishlistWidget extends StatefulWidget {
  const WishlistWidget({super.key, required this.id, required this.isAdded});

  final int id;
  final bool isAdded;

  @override
  State<WishlistWidget> createState() => _WishlistWidgetState();
}

class _WishlistWidgetState extends State<WishlistWidget> {
  final ValueNotifier<bool> _isAdded = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _isAdded.value = widget.isAdded;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc, WishlistState>(
      listener: (context, state) {
        if (state is WishlistSuccess) {
          _isAdded.value = !_isAdded.value;
          showSnackBar(
            context,
            title: _isAdded.value
                ? 'Aktivitas ditambahkan ke daftar aktivitas'
                : 'Aktivitas dihapus dari daftar aktivitas',
            duration: const Duration(seconds: 1),
          );
        } else if (state is WishlistFailure) {
          showSnackBar(context, title: state.message);
        }
      },
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: () {
            context
                .read<WishlistBloc>()
                .add(AddOrRemoveWishlistEvent(id: widget.id));
          },
          backgroundColor: ColorValues.green02,
          tooltip: 'Tambah ke daftar aktivitas',
          child: state is WishlistLoading
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : ValueListenableBuilder(
                  valueListenable: _isAdded,
                  builder: (context, value, child) {
                    return Icon(
                      value ? Icons.done_rounded : Icons.playlist_add_rounded,
                      color: Colors.white,
                    );
                  },
                ),
        );
      },
    );
  }
}
