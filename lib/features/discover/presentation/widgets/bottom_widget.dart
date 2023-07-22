import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/discover/discover_bloc.dart';
import 'discover_text_field.dart';
import 'filter_chip_widget.dart';

class BottomWidget extends StatefulWidget {
  const BottomWidget({super.key});

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  final _controller = TextEditingController();
  final Set<int> _filters = <int>{};

  @override
  Widget build(BuildContext context) {
    return BlocListener<DiscoverBloc, DiscoverState>(
      listener: (context, state) {
        if (state is DiscoverInitial) {
          setState(() {
            _controller.clear();
            _filters.clear();
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: DiscoverTextField(
              controller: _controller,
              onChanged: (value) => _valueChanged(),
            ),
          ),
          const SizedBox(height: 9),
          SizedBox(
            height: 48,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              children: [
                FilterChipWidget(
                  id: 1,
                  label: 'Carbon conscious',
                  selected: _filters.contains(1),
                  onSelected: (value) => _onSelected(value, 1),
                ),
                const SizedBox(width: 8),
                FilterChipWidget(
                  id: 2,
                  label: 'Carbon conscious',
                  selected: _filters.contains(2),
                  onSelected: (value) => _onSelected(value, 2),
                ),
                const SizedBox(width: 8),
                FilterChipWidget(
                  id: 3,
                  label: 'Carbon conscious',
                  selected: _filters.contains(3),
                  onSelected: (value) => _onSelected(value, 3),
                ),
              ],
            ),
          ),
          const SizedBox(height: 9),
        ],
      ),
    );
  }

  void _onSelected(bool value, int id) {
    setState(() {
      if (value) {
        _filters.add(id);
      } else {
        _filters.remove(id);
      }
      _valueChanged();
    });
  }

  void _valueChanged() {
    context.read<DiscoverBloc>().add(
        ValueDiscoverChangedEvent(text: _controller.text, category: _filters));
  }
}
