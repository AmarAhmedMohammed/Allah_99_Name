class AllahName {
  final int id;
  final String arabic;
  final String transliteration;
  final String meaningEn;
  final String meaningAm;
  final String explanation;
  final String? audioUrl;

  AllahName({
    required this.id,
    required this.arabic,
    required this.transliteration,
    required this.meaningEn,
    required this.meaningAm,
    required this.explanation,
    this.audioUrl,
  });

  factory AllahName.fromJson(Map<String, dynamic> json) {
    return AllahName(
      id: json['id'] as int,
      arabic: json['arabic'] as String,
      transliteration: json['transliteration'] as String,
      meaningEn: json['meaning_en'] as String,
      meaningAm: json['meaning_am'] as String? ?? '',
      explanation: json['explanation'] as String,
      audioUrl: json['audio_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arabic': arabic,
      'transliteration': transliteration,
      'meaning_en': meaningEn,
      'meaning_am': meaningAm,
      'explanation': explanation,
      'audio_url': audioUrl,
    };
  }
}
