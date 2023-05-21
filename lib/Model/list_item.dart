import 'dart:convert';

class ListItem {
  String? id;
  String? listName;
  String? distance;

  ListItem({this.id, this.listName, this.distance});

  @override
  String toString() {
    return 'ListItem(id: $id, listName: $listName, distance: $distance)';
  }

  factory ListItem.fromMap(Map<String, dynamic> data) => ListItem(
        id: data['id'] as String?,
        listName: data['list_name'] as String?,
        distance: data['distance'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'list_name': listName,
        'distance': distance,
      };

  /// Parses the string and returns the resulting Json object as [ListItem].
  factory ListItem.fromJson(String data) {
    return ListItem.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// Converts [ListItem] to a JSON string.
  String toJson() => json.encode(toMap());

  ListItem copyWith({
    String? id,
    String? listName,
    String? distance,
  }) {
    return ListItem(
      id: id ?? this.id,
      listName: listName ?? this.listName,
      distance: distance ?? this.distance,
    );
  }
}
