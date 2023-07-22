import 'package:flutter/material.dart';

import '../../../../core/theme/color_values.dart';

class FilterChipWidget extends StatefulWidget {
  const FilterChipWidget({
    super.key,
    required this.id,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final int id;
  final String label;
  final bool selected;
  final void Function(bool) onSelected;

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FilterChip(
      label: Text(widget.label, style: textTheme.bodySmall),
      selected: widget.selected,
      backgroundColor: _colorMap[widget.id],
      selectedColor: _selectedColorMap[widget.id],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onSelected: widget.onSelected,
    );
  }
}

final Map<int, Color> _colorMap = {
  1: ColorValues.subGreen,
  2: ColorValues.subPink,
  3: ColorValues.subBlue,
};

final Map<int, Color> _selectedColorMap = {
  1: ColorValues.subGreen.withOpacity(1),
  2: ColorValues.subPink.withOpacity(1),
  3: ColorValues.subBlue.withOpacity(1),
};
