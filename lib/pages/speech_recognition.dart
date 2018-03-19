import 'package:speech_recognition/speech_recognition.dart';
import 'dart:async';

class ActivateSpeechRecognition {
  SpeechRecognition speech;
  String _currentLocale = 'en_US';

  Future<bool> activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    speech = new SpeechRecognition();
    speech.setAvailabilityHandler(onSpeechAvailability);
    speech.setCurrentLocaleHandler(onCurrentLocale);
    speech.setRecognitionStartedHandler(onRecognitionStarted);
    speech.setRecognitionResultHandler(onRecognitionResult);
    speech.setRecognitionCompleteHandler(onRecognitionComplete);
    return speech.activate().then((res) => res);
  }

  void start() => speech
      .listen(locale: _currentLocale)
      .then((result) => print('_MyAppState.start => result $result'));

  Future<bool> cancel() => speech.cancel().then((result) => result);

  Future<bool> stop() => speech.stop().then((result) => result);

  bool onSpeechAvailability(bool result) => result;

  String onCurrentLocale(String locale) => locale;

  bool onRecognitionStarted() => true;

  String onRecognitionResult(String text) => text;

  bool onRecognitionComplete() => false;
}