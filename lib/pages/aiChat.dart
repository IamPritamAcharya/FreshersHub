import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:freshers/theme/theme2.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:freshers/pages/info.dart';


class AiChat extends StatefulWidget {
  const AiChat({super.key});

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> {
  ChatUser myself = ChatUser(id: "1", firstName: "Pritam");
  ChatUser bot = ChatUser(id: "2", firstName: "Gemini");

  List<ChatMessage> allMessages = [];
  List<ChatUser> typing = [];

  final header = {
    'Content-Type': 'application/json',
  };

  bool conversationStarted = false;

  Future<void> getdata(ChatMessage m) async {
    typing.add(bot);
    allMessages.insert(0, m);
    setState(() {});

    var data = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };

    await http.post(Uri.parse(oururl), headers: header, body: jsonEncode(data)).then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        var botText = result['candidates'][0]['content']['parts'][0]['text'];

        // Remove repeated text at the beginning of the response
        botText = removeRepetition(m.text, botText);

        ChatMessage m1 = ChatMessage(
          text: botText,
          user: bot,
          createdAt: DateTime.now(),
        );

        allMessages.insert(0, m1);
      } else {
        print("error occurred");
      }
    }).catchError((e) {});
    typing.remove(bot);
    setState(() {});
  }

  String removeRepetition(String userMessage, String botResponse) {
    // Normalize the messages for comparison
    String userNormalized = userMessage.trim().toLowerCase();
    String botNormalized = botResponse.trim().toLowerCase();

    // Split the user message into words for more precise matching
    List<String> userWords = userNormalized.split(RegExp(r'\s+'));
    List<String> botWords = botNormalized.split(RegExp(r'\s+'));

    // Find the longest matching prefix
    int maxMatchLength = 0;
    for (int i = 0; i < userWords.length; i++) {
      if (i < botWords.length && userWords[i] == botWords[i]) {
        maxMatchLength = i + 1;
      } else {
        break;
      }
    }

    // If the match is significant (more than a third of the user message length), remove it
    if (maxMatchLength > userWords.length / 3) {
      botResponse = botWords.sublist(maxMatchLength).join(' ').trim();
    }

    // Further check for repeated segments within the bot's response
    String cleanedBotResponse = _removeInternalRepetitions(botResponse);
    return cleanedBotResponse;
  }

  String _removeInternalRepetitions(String text) {
    List<String> sentences = text.split(RegExp(r'[.!?]\s+'));
    Set<String> seenSentences = {};
    List<String> result = [];

    for (String sentence in sentences) {
      if (!seenSentences.contains(sentence.trim().toLowerCase())) {
        seenSentences.add(sentence.trim().toLowerCase());
        result.add(sentence);
      }
    }

    return result.join('. ');
  }

  void resetChat() {
    setState(() {
      allMessages.clear();
      conversationStarted = false;
    });
  }

  List<InlineSpan> _parseText(String text) {
    final List<InlineSpan> spans = [];
    final boldPattern = RegExp(r'\*\*(.*?)\*\*');
    final codePattern = RegExp(r'```(.*?)```', dotAll: true);
    int start = 0;

    text.splitMapJoin(
      codePattern,
      onMatch: (match) {
        final matchStart = match.start;
        final matchEnd = match.end;
        if (start < matchStart) {
          spans.addAll(_parseBoldText(text.substring(start, matchStart)));
        }
        spans.add(
          WidgetSpan(
            child: Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.symmetric(vertical: 8.0),
              color: Colors.grey.shade200,
              child: SelectableText(
                match.group(1)!.trim(),
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
        start = matchEnd;
        return '';
      },
      onNonMatch: (nonMatch) {
        if (start < nonMatch.length) {
          spans.addAll(_parseBoldText(nonMatch.substring(start)));
        }
        return '';
      },
    );
    return spans;
  }

  List<InlineSpan> _parseBoldText(String text) {
    final List<InlineSpan> spans = [];
    final boldPattern = RegExp(r'\*\*(.*?)\*\*');
    int start = 0;

    text.splitMapJoin(
      boldPattern,
      onMatch: (match) {
        final matchStart = match.start;
        final matchEnd = match.end;
        if (start < matchStart) {
          spans.add(TextSpan(text: text.substring(start, matchStart)));
        }
        spans.add(TextSpan(text: match.group(1), style: TextStyle(fontWeight: FontWeight.bold)));
        start = matchEnd;
        return '';
      },
      onNonMatch: (nonMatch) {
        if (start < nonMatch.length) {
          spans.add(TextSpan(text: nonMatch.substring(start)));
        }
        return '';
      },
    );
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final isTheme2 = Theme.of(context).colorScheme.surface == theme2.colorScheme.surface;
    final textcolorInput = (isTheme2) ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary;
    final bottextColor = (isTheme2) ? Colors.grey.shade800 : Theme.of(context).colorScheme.onSecondary;
    final bottextColor2 = (isTheme2) ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            if (!conversationStarted)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.35, // Adjust the vertical position as needed
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'lib/icons/gemini.png',
                    height: 40, // Keep the size constant
                    color: Colors.grey.shade600.withAlpha(90),
                  ),
                ),
              ),
            Column(
              children: [
                Expanded(
                  child: DashChat(
                    typingUsers: typing,
                    currentUser: myself,
                    onSend: (ChatMessage m) {
                      setState(() {
                        conversationStarted = true;
                      });
                      getdata(m);
                    },
                    messages: allMessages,
                    messageOptions: MessageOptions(
                      currentUserContainerColor: Colors.black,
                      currentUserTextColor: Colors.white,
                      containerColor: Color.fromARGB(255, 218, 218, 218),
                      textColor: Colors.black,
                      messagePadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      messageDecorationBuilder: (ChatMessage message, ChatMessage? previousMessage, ChatMessage? nextMessage) {
                        return BoxDecoration(
                          color: message.user.id == myself.id ? Colors.black : bottextColor,
                          borderRadius: BorderRadius.circular(25.0),
                        );
                      },
                      messageTextBuilder: (ChatMessage message, ChatMessage? previousMessage, ChatMessage? nextMessage) {
                        return GestureDetector(
                          onLongPress: () {
                            Clipboard.setData(ClipboardData(text: message.text));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Text copied to clipboard')),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SelectableText.rich(
                              TextSpan(
                                children: _parseText(message.text),
                              ),
                              style: TextStyle(
                                color: message.user.id == myself.id ? Colors.white : bottextColor2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    inputOptions: InputOptions(
                      inputDecoration: InputDecoration(
                        filled: true,
                        fillColor: (isTheme2) ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.tertiary,
                        hintText: 'Type a message',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      inputTextStyle: TextStyle(color: textcolorInput),
                      sendButtonBuilder: defaultSendButton(color: textcolorInput),
                      leading: [],
                      trailing: [
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: resetChat,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
