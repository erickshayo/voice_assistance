import 'package:flutter/material.dart';
import 'package:voice_assistance/feature_box.dart';
import 'package:voice_assistance/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          Container(
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
                "Hello, What can i do for you?",
                style: TextStyle(
                  color: Pallete.mainFontColor,
                  fontSize: 25,
                  fontFamily: "Cera Pro",
                ),
              ),
            ),
          ),
          Container(
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
          Column(
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
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: FloatingActionButton(
          onPressed: () {}, 
          child: Icon(Icons.mic),),
      ),
    );
  }
}
