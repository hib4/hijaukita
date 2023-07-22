import 'package:flutter/material.dart';
import 'package:hijaukita/features/profile/presentation/widgets/redeem_point_dialog.dart';
import '../../../../core/theme/color_values.dart';
import '../../domain/entities/profile.dart';
import '../widgets/item/card_dampak_widget.dart';
import '../widgets/point_widget.dart';

class ImpactPage extends StatefulWidget {
  const ImpactPage({
    Key? key,
    required this.doneActivities,
    required this.myBadges,
    required this.listBadges,
    required this.point,
  }) : super(key: key);

  final List<DoneActivity> doneActivities;
  final List<BadgeProfile> myBadges;
  final List<BadgeProfile> listBadges;
  final String point;

  @override
  State<ImpactPage> createState() => _ImpactPageState();
}

class _ImpactPageState extends State<ImpactPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
            child: PointCard(() {
              showDialog(
                context: context,
                builder: (_) => RedeemPointDialog(
                  badges: widget.myBadges,
                  point: widget.point,
                ),
              );
            }, context, widget.myBadges),
          ),
          const SizedBox(height: 36),
          const Divider(thickness: 16, color: ColorValues.grey01),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              mainAxisExtent: 140,
            ),
            itemCount: widget.doneActivities.length,
            itemBuilder: (context, index) {
              final data = widget.doneActivities[index];
              return CardDampak(
                context,
                _backgroundColorMap[data.id.toString()] ?? ColorValues.subBlue,
                _colorsMap[data.id.toString()] ?? ColorValues.gradient03,
                '${data.count}X',
                data.subCategory,
              );
            },
          ),
          const Divider(thickness: 16, color: ColorValues.grey01),
        ],
      ),
    );
  }
}

final Map<String, Color> _backgroundColorMap = {
  '1': ColorValues.subGreen,
  '2': ColorValues.subPink,
  '3': ColorValues.subBlue,
};

final Map<String, List<Color>> _colorsMap = {
  '1': ColorValues.gradient01,
  '2': ColorValues.gradient02,
  '3': ColorValues.gradient03,
};
