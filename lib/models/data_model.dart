class DataModel {
  int? id;
  String? character;
  String? character2;
  String? pinyin;
  String? comment;
  String? reminder;
  String? examples;

  DataModel(
      {this.id,
        this.character,
        this.character2,
        this.pinyin,
        this.comment,
        this.reminder,
        this.examples});

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    character = json['character'];
    character2 = json['character2'];
    pinyin = json['pinyin'];
    comment = json['comment'];
    reminder = json['reminder'];
    examples = json['examples'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['character'] = character;
    data['character2'] = character2;
    data['pinyin'] = pinyin;
    data['comment'] = comment;
    data['reminder'] = reminder;
    data['examples'] = examples;
    return data;
  }

  @override
  String toString() {
    return 'DataModel{id: $id, character: $character, character2: $character2, pinyin: $pinyin, comment: $comment, reminder: $reminder, examples: $examples}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          character == other.character &&
          character2 == other.character2 &&
          pinyin == other.pinyin &&
          comment == other.comment &&
          reminder == other.reminder &&
          examples == other.examples;

  @override
  int get hashCode =>
      id.hashCode ^
      character.hashCode ^
      character2.hashCode ^
      pinyin.hashCode ^
      comment.hashCode ^
      reminder.hashCode ^
      examples.hashCode;

  DataModel copyWith({
    int? id,
    String? character,
    String? character2,
    String? pinyin,
    String? comment,
    String? reminder,
    String? examples,
  }) {
    return DataModel(
      id: id ?? this.id,
      character: character ?? this.character,
      character2: character2 ?? this.character2,
      pinyin: pinyin ?? this.pinyin,
      comment: comment ?? this.comment,
      reminder: reminder ?? this.reminder,
      examples: examples ?? this.examples,
    );
  }

  DataModel copyFrom(DataModel data) {
    id = data.id;
    character = data.character;
    character2 = data.character2;
    pinyin = data.pinyin;
    comment = data.comment;
    reminder = data.reminder;
    examples = data.examples;
    return this;
  }

  DataModel copyTo(DataModel data) {
    data.id = id;
    data.character = character;
    data.character2 = character2;
    data.pinyin = pinyin;
    data.comment = comment;
    data.reminder = reminder;
    data.examples = examples;
    return data;
  }

  DataModel copyWithMap(Map<String, dynamic> map) {
    return DataModel(
      id: map['id'] ?? id,
      character: map['character'] ?? character,
      character2: map['character2'] ?? character2,
      pinyin: map['pinyin'] ?? pinyin,
      comment: map['comment'] ?? comment,
      reminder: map['reminder'] ?? reminder,
      examples: map['examples'] ?? examples,
    );
  }

  DataModel copyFromMap(Map<String, dynamic> map) {
    id = map['id'];
    character = map['character'];
    character2 = map['character2'];
    pinyin = map['pinyin'];
    comment = map['comment'];
    reminder = map['reminder'];
    examples = map['examples'];
    return this;
  }


}
