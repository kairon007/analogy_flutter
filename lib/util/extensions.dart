import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

extension LocalizedContext on BuildContext {
  /// Shortcut to get AppLocalizations more easily
  AppLocalizations get loc => AppLocalizations.of(this)!;


}