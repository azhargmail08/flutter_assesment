import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assessment/screens/profile_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_assessment/models/contact_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'My Contacts',
              style: TextStyle(fontSize: 20),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 17),
                child: IconButton(
                  onPressed: () async {
                    await syncData();
                  },
                  icon: const Icon(Icons.sync),
                ),
              ),
            ],
          ),
          body: const ContentsInTheContactsCard(
            title: '',
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.2,
          minChildSize: 0.2,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child:
                  YourFavoriteContactWidget(scrollController: scrollController),
            );
          },
        ),
      ],
    );
  }

  YourFavoriteContactWidget({required ScrollController scrollController}) {}
}

List<Widget> selectionBox = [
  Text('All'),
  Text('Favorite'),
];

class ContentsInTheContactsCard extends StatefulWidget {
  const ContentsInTheContactsCard({super.key, required this.title});

  final String title;

  @override
  State<ContentsInTheContactsCard> createState() =>
      _ContentsInTheContactsCardState();
}

class _ContentsInTheContactsCardState extends State<ContentsInTheContactsCard> {
  TextEditingController _searchController = TextEditingController();
  List<bool> _selectionBox = [true, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Contacts',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Icon(Icons.search),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ToggleButtons(
                borderColor: Colors.white,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
                selectedBorderColor: Color(0xff32BAA5),
                fillColor: Color(0xff32BAA5),
                children: [
                  Text('All'),
                  Text('Favorite'),
                ],
                isSelected: _selectionBox,
                onPressed: (int index) {
                  setState(
                    () {
                      _selectionBox[index] = !_selectionBox[index];
                      _selectionBox[(index + 1) % 2] = false;
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: Hive.openBox<Contacts>('contacts'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final contactsBox = Hive.box<Contacts>('contacts');
                if (contactsBox.isEmpty) {
                  contactsBox.put(
                    1,
                    Contacts(
                      name: 'Darlene Steward',
                      email: 'darlene.stewards7@gmail.com',
                      image: "assets/images/profile_picture.png",
                      // isFavorite: false,
                    ),
                  );
                  contactsBox.put(
                    2,
                    Contacts(
                      name: 'Fullsnack Designers',
                      email: 'fendy27@gmail.com',
                      image: "assets/images/profile_picture.png",
                      // isFavorite: false,
                    ),
                  );
                  contactsBox.put(
                    3,
                    Contacts(
                      name: 'Lee Williamson',
                      email: 'leewilliomso76@gmail.com',
                      image: "assets/images/profile_picture.png",
                      // isFavorite: true,
                    ),
                  );
                  contactsBox.put(
                    4,
                    Contacts(
                      name: 'Ronald McCoy',
                      email: 'ronald.mccoy3@gmail.com',
                      image: "assets/images/profile_picture.png",
                      // isFavorite: false,
                    ),
                  );
                  contactsBox.put(
                    5,
                    Contacts(
                      name: 'Alber Bell',
                      email: 'albert.bell@gmail.com',
                      image: "assets/images/profile_picture.png",
                      // isFavorite: true,
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                    padding: EdgeInsets.all(8.0),
                    itemCount: contactsBox.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 15,
                      width: 20,
                    ),
                    itemBuilder: (context, index) {
                      final contacts = contactsBox.get(index + 1)!;
                      return GestureDetector(
                        onLongPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                contact: contacts,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffEBF8F6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(contacts.image),
                            ),
                            title: Text(contacts.name),
                            subtitle: Text(contacts.email),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    contacts.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: contacts.isFavorite
                                        ? Colors.yellow
                                        : null,
                                  ),
                                  onPressed: () {
                                    contactsBox.put(
                                      index + 1,
                                      Contacts(
                                        name: contacts.name,
                                        email: contacts.email,
                                        image: contacts.image,
                                        isFavorite: !contacts.isFavorite,
                                      ),
                                    );

                                    setState(() {});
                                  },
                                ),
                                IconButton(
                                  onPressed: () {
                                    contactsBox.delete(index + 1);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

Future<void> syncData() async {
  final contactsBox = Hive.box<Contacts>('contacts');
  for (int i = 1; i <= contactsBox.length; i++) {
    final contacts = contactsBox.get(i);
    print(
        'Synced: ${contacts?.name}, ${contacts?.email}, ${contacts?.image}, ${contacts?.isFavorite}');
  }
}
