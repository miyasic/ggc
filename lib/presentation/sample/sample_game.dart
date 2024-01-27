import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ggc/presentation/sample/moving_range.dart';
import 'package:ggc/presentation/sample/play_area.dart';

enum PlayState { welcome, playing, gameOver, won }

class SampleGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapDetector {
  SampleGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 360,
            height: 640,
          ),
        );

  final ValueNotifier<int> score = ValueNotifier(0);
  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
      case PlayState.won:
        overlays.add(playState.name);
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    // worldはゲーム画面のこと
    world.add(PlayArea());

    playState = PlayState.welcome;

    // デバッグモードを有効にする
    debugMode = true;
  }

  void startGame() {
    if (playState == PlayState.playing) {
      return;
    }

    playState = PlayState.playing;
    score.value = 0;

    // 行動範囲を表示
    world.add(MovingRange());
  }

  @override
  void onTap() {
    super.onTap();
    // タップしたらゲームを開始
    startGame();
  }

  @override // キーボードイベントを受け取る
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);
    // switch (event.logicalKey) {
    //   case LogicalKeyboardKey.arrowLeft:
    //     world.children.query<Bat>().first.moveBy(-batStep);
    //   case LogicalKeyboardKey.arrowRight:
    //     world.children.query<Bat>().first.moveBy(batStep);
    //   case LogicalKeyboardKey.space:
    //   case LogicalKeyboardKey.enter:
    //     startGame();
    // }
    return KeyEventResult.handled;
  }

  @override
  Color backgroundColor() => const Color(0xfff2e8cf);
}
