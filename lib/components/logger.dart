/// Since most messages of flutter console are helpless,
/// Wrap our logs inside a drawn box to make it easy to identify.
import 'package:logger/logger.dart';

final logger = Logger(
  filter: ProductionFilter(),
  printer: PrettyPrinter(methodCount: 1, colors: false, printEmojis: false),
);
