import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../configs/localization/localization_extensions.dart';

class DateRangeFilter extends StatelessWidget {
  const DateRangeFilter(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.onChanged});

  final DateTime startDate;
  final DateTime endDate;
  final void Function(DateTime start, DateTime end) onChanged;

  Future<void> _pick(BuildContext context) async {
    final range = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2024),
        lastDate: DateTime.now(),
        initialDateRange: DateTimeRange(start: startDate, end: endDate),
        helpText: context.l10n.selectDateRange);
    if (range != null) onChanged(range.start, range.end);
  }

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
        onPressed: () => _pick(context),
        icon: const Icon(Icons.date_range_outlined),
        label: Text(
            '${DateFormat.yMMMd(Localizations.localeOf(context).toString()).format(startDate)} – ${DateFormat.yMMMd(Localizations.localeOf(context).toString()).format(endDate)}'),
      );
}
