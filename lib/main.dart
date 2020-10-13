import 'package:dismissible_actions_example/data.dart';
import 'package:dismissible_actions_example/model/chat.dart';
import 'package:dismissible_actions_example/utils.dart';
import 'package:dismissible_actions_example/widget/dismissible_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Dismissible Example';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Chat> items = List.of(Data.chats);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.restore),
              onPressed: () {
                setState(() {
                  items = List.of(Data.chats);
                });
              },
            ),
          ],
        ),
        body: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final item = items[index];

            return DismissibleWidget(
              item: item,
              child: buildListTile(item),
              onDismissed: (direction) =>
                  dismissItem(context, index, direction),
            );
          },
        ),
      );

  void dismissItem(
    BuildContext context,
    int index,
    DismissDirection direction,
  ) {
    setState(() {
      items.removeAt(index);
    });

    switch (direction) {
      case DismissDirection.endToStart:
        Utils.showSnackBar(context, 'Chat has been deleted');
        break;
      case DismissDirection.startToEnd:
        Utils.showSnackBar(context, 'Chat has been archived');
        break;
      default:
        break;
    }
  }

  Widget buildListTile(Chat item) => ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(item.urlAvatar),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.username,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(item.message)
          ],
        ),
        onTap: () {},
      );
}
