import 'package:chat_app/models/models.dart';
import 'package:chat_app/screens/screens.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../helper.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _Stories()),
        SliverList(
          delegate: SliverChildBuilderDelegate(_delegate),
        ),
      ],
    );
  }
  Widget _delegate(BuildContext context, int index){
    final Faker faker =Faker();
    final date =Helpers.randomDate();
    return _MessageTitle(
      messageData: MessageData(
        senderName: faker.person.name(),
        message: faker.lorem.sentence(),
        messageDate: date, 
        dateMessage: Jiffy(date).fromNow(),
        profilePicture: Helpers.randomPictureUrl(),
        ),
      );
  }
}

class _MessageTitle extends StatelessWidget {
  const _MessageTitle({
    Key? key, 
    required this.messageData,
    }) : super(key: key);

 final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap:  (){
            Navigator.of(context).push(ChatScreen.routeWithChannel(messageData));
          },
          child: Row(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Avatar.medium(url: messageData.profilePicture),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(messageData.senderName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  letterSpacing: 0.2,
                  wordSpacing: 1.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height:20,
                child: Text(
                  messageData.message,
                  overflow: TextOverflow.ellipsis,
                  ),
                ), 
              ],
            ),
          ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        messageData.dateMessage.toUpperCase(),
                        style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            '1',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                    
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}


class _Stories extends StatelessWidget {
  const _Stories({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top:8),
      elevation: 0,
      child: SizedBox(
        height: 134,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Stories',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final faker = Faker();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 60,
                      child: _StoryCard(
                        storyData: StoryData(
                          name:faker.person.name(),
                          url: Helpers.randomPictureUrl()
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    Key? key,
    required this.storyData,
  }) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}