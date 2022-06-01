import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:voice_to_text_chat/views/home/chat_input_widget.dart';
import 'package:voice_to_text_chat/views/home/chat_title_widget.dart';
import 'package:voice_to_text_chat/views/home/chat_widget.dart';
import 'package:voice_to_text_chat/views/home/contact_list.dart';
import 'package:voice_to_text_chat/views/home/profile_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Material(
      child: Container(
        color: NeumorphicTheme.baseColor(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0, left: 35, right: 35),
                      child: ProfileWidget()
                    ),
                    Expanded(
                      child: ContactsListWidget()
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                flex: 8,
                child: Column(
                  children: const [
                    ChatTitleWidget(),
                    Expanded(child: ChatWidget()),
                    ChatInputWidget(),
                    SizedBox(height: 10)
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
