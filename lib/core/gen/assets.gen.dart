/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/arrow.svg
  SvgGenImage get arrow => const SvgGenImage('assets/icons/arrow.svg');

  /// File path: assets/icons/bell.svg
  SvgGenImage get bell => const SvgGenImage('assets/icons/bell.svg');

  /// File path: assets/icons/coin.svg
  SvgGenImage get coin => const SvgGenImage('assets/icons/coin.svg');

  /// File path: assets/icons/discover.svg
  SvgGenImage get discover => const SvgGenImage('assets/icons/discover.svg');

  /// File path: assets/icons/eye.svg
  SvgGenImage get eye => const SvgGenImage('assets/icons/eye.svg');

  /// File path: assets/icons/eye_hide.svg
  SvgGenImage get eyeHide => const SvgGenImage('assets/icons/eye_hide.svg');

  /// File path: assets/icons/google.svg
  SvgGenImage get google => const SvgGenImage('assets/icons/google.svg');

  /// File path: assets/icons/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/home.svg');

  /// File path: assets/icons/information.svg
  SvgGenImage get information =>
      const SvgGenImage('assets/icons/information.svg');

  /// File path: assets/icons/leaderboard.svg
  SvgGenImage get leaderboard =>
      const SvgGenImage('assets/icons/leaderboard.svg');

  /// File path: assets/icons/location.svg
  SvgGenImage get location => const SvgGenImage('assets/icons/location.svg');

  /// File path: assets/icons/logo.svg
  SvgGenImage get logo => const SvgGenImage('assets/icons/logo.svg');

  /// File path: assets/icons/profile.svg
  SvgGenImage get profile => const SvgGenImage('assets/icons/profile.svg');

  /// File path: assets/icons/search.svg
  SvgGenImage get search => const SvgGenImage('assets/icons/search.svg');

  /// File path: assets/icons/settings.svg
  SvgGenImage get settings => const SvgGenImage('assets/icons/settings.svg');

  /// File path: assets/icons/upload_photo.svg
  SvgGenImage get uploadPhoto =>
      const SvgGenImage('assets/icons/upload_photo.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        arrow,
        bell,
        coin,
        discover,
        eye,
        eyeHide,
        google,
        home,
        information,
        leaderboard,
        location,
        logo,
        profile,
        search,
        settings,
        uploadPhoto
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/bird_bottle.svg
  SvgGenImage get birdBottle =>
      const SvgGenImage('assets/images/bird_bottle.svg');

  /// File path: assets/images/earth.svg
  SvgGenImage get earth => const SvgGenImage('assets/images/earth.svg');

  /// File path: assets/images/globe.svg
  SvgGenImage get globe => const SvgGenImage('assets/images/globe.svg');

  /// File path: assets/images/person_success.svg
  SvgGenImage get personSuccess =>
      const SvgGenImage('assets/images/person_success.svg');

  /// File path: assets/images/person_zoom.svg
  SvgGenImage get personZoom =>
      const SvgGenImage('assets/images/person_zoom.svg');

  /// File path: assets/images/woman_globe.svg
  SvgGenImage get womanGlobe =>
      const SvgGenImage('assets/images/woman_globe.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [birdBottle, earth, globe, personSuccess, personZoom, womanGlobe];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/typing.json
  LottieGenImage get typing =>
      const LottieGenImage('assets/lottie/typing.json');

  /// List of all assets
  List<LottieGenImage> get values => [typing];
}

class $AssetsTfliteGen {
  const $AssetsTfliteGen();

  /// File path: assets/tflite/model.tflite
  String get model => 'assets/tflite/model.tflite';

  /// File path: assets/tflite/model_unquant_metadata.tflite
  String get modelUnquantMetadata =>
      'assets/tflite/model_unquant_metadata.tflite';

  /// List of all assets
  List<String> get values => [model, modelUnquantMetadata];
}

class $AssetsWindowGen {
  const $AssetsWindowGen();

  /// File path: assets/window/background.svg
  SvgGenImage get background =>
      const SvgGenImage('assets/window/background.svg');

  /// File path: assets/window/bottle.svg
  SvgGenImage get bottle => const SvgGenImage('assets/window/bottle.svg');

  /// File path: assets/window/paper.svg
  SvgGenImage get paper => const SvgGenImage('assets/window/paper.svg');

  /// File path: assets/window/small_paper.svg
  SvgGenImage get smallPaper =>
      const SvgGenImage('assets/window/small_paper.svg');

  /// File path: assets/window/trash.svg
  SvgGenImage get trash => const SvgGenImage('assets/window/trash.svg');

  /// File path: assets/window/wave.svg
  SvgGenImage get wave => const SvgGenImage('assets/window/wave.svg');

  /// File path: assets/window/wave_bottle.svg
  SvgGenImage get waveBottle =>
      const SvgGenImage('assets/window/wave_bottle.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [background, bottle, paper, smallPaper, trash, wave, waveBottle];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const $AssetsTfliteGen tflite = $AssetsTfliteGen();
  static const $AssetsWindowGen window = $AssetsWindowGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(this._assetName);

  final String _assetName;

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
