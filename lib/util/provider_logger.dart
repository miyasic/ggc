import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'logger.dart';

const _logPrefix = '[RIVERPOD]';

/// Riverpod の各 Provider のライフサイクルをログ出力するためのオブザーバー
///
/// ログ出力したい場合は Provider に name プロパティを設定すること
class ProviderLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<dynamic> provider,
    Object? value,
    ProviderContainer container,
  ) {
    final name = provider.name;
    if (name != null) {
      logger.t(
        '$_logPrefix[ADD] $name: value = $value',
      );
    }
  }

  @override
  void providerDidFail(
    ProviderBase<dynamic> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    final name = provider.name;
    if (name != null) {
      logger.w(
        '$_logPrefix[ERROR] $name',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final name = provider.name;
    if (name != null) {
      logger.t(
        '$_logPrefix[UPDATE] $name: '
        'newValue = $newValue',
      );
    }
  }

  @override
  void didDisposeProvider(
    ProviderBase<dynamic> provider,
    ProviderContainer container,
  ) {
    final name = provider.name;
    if (name != null) {
      logger.t(
        '$_logPrefix[DISPOSE] $name',
      );
    }
  }
}
