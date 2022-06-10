import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart' as ja;

class AudioService {
  AudioSession? audioSessions;

  ja.AudioPlayer player = ja.AudioPlayer(
    androidApplyAudioAttributes: false,
    handleInterruptions: false,
    handleAudioSessionActivation: false,
  );

  static final AudioService _instance = AudioService._internal();

  factory AudioService() => _instance;

  AudioService._internal() {
    _audioSessionConfigure();
  }

  getPlayBack() async {
    await player.setAsset('assets/audios/countdown.wav');
    await _handleInterruption();
  }

  stop() async {
    await player.stop();
    // await audioSessions!.setActive(true);

    await audioSessions!.setActive(false);
  }

  start() async {
    await player.setAsset('assets/audios/countdown.wav');
    await player.play();
    await audioSessions!.setActive(true);
  }

  _handleInterruption() async {
    player.playing ? await player.stop() : await player.play();
    await audioSessions!.setActive(true);
    // await audioSessions!.setActive(player.playing);
  }

  _audioSessionConfigure() {
    return AudioSession.instance.then((audioSession) async {
      await audioSession
          .configure(AudioSessionConfiguration(
            avAudioSessionCategory: AVAudioSessionCategory.playback,
            avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
            avAudioSessionMode: AVAudioSessionMode.defaultMode,
            avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
            avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.notifyOthersOnDeactivation,
            androidAudioAttributes: AndroidAudioAttributes(
              contentType: AndroidAudioContentType.music,
              flags: AndroidAudioFlags.none,
              usage: AndroidAudioUsage.media,
            ),
            androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransient,
            androidWillPauseWhenDucked: true,
          ))
          .then((_) => audioSessions = audioSession);

      // await player.setAsset('assets/audios/countdown.wav');
    });
  }
}
