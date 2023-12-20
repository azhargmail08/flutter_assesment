import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Contacts extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String email;

  @HiveField(2)
  late String image;

  @HiveField(3)
  late bool isFavorite;

  Contacts({
    required this.name,
    required this.email,
    required this.image,
    this.isFavorite = false,
  });
}

class ContactAdapter extends TypeAdapter<Contacts> {
  @override
  final typeId = 0;

  @override
  Contacts read(BinaryReader reader) {
    return Contacts(
      name: reader.readString(),
      email: reader.readString(),
      image: reader.readString(),
      isFavorite: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Contacts obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.email);
    writer.writeString(obj.image);
    writer.writeBool(obj.isFavorite);
  }
}
