import 'dart:developer';

import 'package:logging/logging.dart';

void setupLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    final level = '[${rec.level.name}]'.padRight(0);
    final name = '[${rec.loggerName}]';
    final message = rec.message;
    log('$level $name $message', level: rec.level.value, error: rec.error);
  });
}
