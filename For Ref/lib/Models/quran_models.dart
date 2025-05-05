class Sura {
  int? suraNo;
  String? engName;
  String? arName;
  String? arNameLong;
  String? engTranslation;
  String? revPlace;
  int? ayahCount;
  int? imageCount;

  bool isCompleted = false;

  Sura({
    this.suraNo,
    this.engName,
    this.arName,
    this.engTranslation,
    this.revPlace,
    this.ayahCount,
    this.arNameLong,
    this.imageCount,
  });

  Sura.fromJson(Map<String, dynamic> json) {
    suraNo = json['Sura_No'];
    engName = json['Eng_Name'];
    arName = json['Ar_Name'];
    arNameLong = json['Ar_Name_Long'];
    engTranslation = json['Eng_Translation'];
    revPlace = json['Rev_Place'];
    ayahCount = json['Ayah_Count'];
    imageCount = json['Image_Count'];
  }
}

class Ayah {
  int? ayahNo;
  String? verse;
  String? verseSimple;
  String? transliteration;
  String? translation;
  String get cleanAyah {
    if (verse!.length < 2) return verse!;

    // Split the string by spaces
    List<String> words = verse!.split(' ');

    // If there's only one word or no spaces, return as is
    if (words.length < 2) return verse!;

    // Take all words except the last one
    String firstPart = words.sublist(0, words.length - 1).join(' ');
    // Take the last word
    String lastWord = words.last;

    // Combine with no space
    return '$firstPart$lastWord';
  }

  Ayah({this.ayahNo, this.verse, this.translation, this.transliteration, this.verseSimple});

  Ayah.fromJson(Map<String, dynamic> json) {
    ayahNo = json['Ayah_No'];
    verse = json['Verse'];
    verseSimple = json['Verse_Simple'];
    translation = json['Translation'];
    transliteration = json['Transliteration'];
  }
}
