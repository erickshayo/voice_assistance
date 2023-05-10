import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_gpt/feature_box.dart';
import 'package:voice_gpt/openai_service.dart';
import 'package:voice_gpt/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = "";
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sanel"),
        leading: Icon(Icons.menu),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  margin: EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: Pallete.assistantCircleColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Container(
                height: 123,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/voice.jpg"),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: generatedImageUrl == null,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: EdgeInsets.symmetric(horizontal: 40).copyWith(
                top: 30,
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Pallete.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(20).copyWith(
                    topLeft: Radius.zero,
                  )),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  generatedContent == null
                      ? "Hello, What can i do for you?"
                      : generatedContent!,
                  style: TextStyle(
                    color: Pallete.mainFontColor,
                    fontSize: generatedContent == null ? 25 : 18,
                    fontFamily: "Cera Pro",
                  ),
                ),
              ),
            ),
          ),
          if (generatedImageUrl != null) Image.network(generatedImageUrl!),
          Visibility(
            visible: generatedContent == null && generatedImageUrl == null,
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10, left: 22),
              alignment: Alignment.centerLeft,
              child: Text(
                "Here are a few features ",
                style: TextStyle(
                  fontFamily: "Cera Pro",
                  color: Pallete.mainFontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Visibility(
            visible: generatedContent == null && generatedImageUrl == null,
            child: Column(
              children: [
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: "ChatGPT",
                  descriptionText:
                      "A smarter way to stay organized and informed with ChatGPT",
                ),
                FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headerText: "Dall-E",
                  descriptionText:
                      "Get inspired and stay creative with with your personal assistant powered by Dall-E",
                ),
                FeatureBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  headerText: "Smart Voice Assistant",
                  descriptionText:
                      "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT",
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: FloatingActionButton(
          backgroundColor: Pallete.firstSuggestionBoxColor,
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              final speech = await openAIService.isArtPromptAPI(lastWords);
              if (speech.contains('https')) {
                generatedContent = null;
                generatedImageUrl = speech;
                setState(() {});
              } else {
                generatedContent = speech;
                generatedImageUrl = null;
                setState(() {});
                await systemSpeak(speech);
              }
              await systemSpeak(speech);
              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          child: Icon(Icons.mic),
        ),
      ),
    );
  }
}
