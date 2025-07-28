class Analogy {
  final String text;
  final String? firestoreId;
  final List<String>? images;
  final List<String?> tags;

  Analogy({
    required this.text,
    this.firestoreId,
    this.images,
    List<String?>? tags,
  }) : tags = tags ?? [];

  // Convert an Analogy to a Map
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'firestoreId': firestoreId,
      'images': images,
      'tags': tags,
    };
  }

  // Create an Analogy from a Map
  factory Analogy.fromMap(Map<String, dynamic> map, String documentId) {
    return Analogy(
      text: map['text'] as String,
      firestoreId: documentId,
      images: map['images'] != null ? List<String>.from(map['images']) : null,
      tags: map['tags'] != null ? List<String?>.from(map['tags']) : [],
    );
  }

  // Create a copy of the Analogy with some fields updated
  Analogy copyWith({
    String? text,
    String? firestoreId,
    List<String>? images,
    List<String?>? tags,
  }) {
    return Analogy(
      text: text ?? this.text,
      firestoreId: firestoreId ?? this.firestoreId,
      images: images ?? this.images,
      tags: tags ?? this.tags,
    );
  }

  @override
  String toString() {
    return 'Analogy(text: $text, firestoreId: $firestoreId, images: $images, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is Analogy &&
        other.text == text &&
        other.firestoreId == firestoreId &&
        other.images == images &&
        other.tags == tags;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        firestoreId.hashCode ^
        (images?.hashCode ?? 0) ^
        tags.hashCode;
  }
}
