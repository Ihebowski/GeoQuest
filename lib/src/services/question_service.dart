import 'package:geoquest/src/models/contry_model.dart';
import 'package:geoquest/src/models/question_model.dart';
import 'package:geoquest/src/repositories/country_repository.dart';
import 'dart:math';

class QuestionService {
  final CountryRepository _countryRepository = CountryRepository();

  Future<List<QuestionModel>> generateRandomQuestions() async {
    try {
      List<CountryModel> countries = await _countryRepository.getCountries();
      countries.shuffle();
      List<QuestionModel> questions = [];

      for (int i = 0; i < 10 && i < countries.length; i++) {
        var correctCountry = countries[i];
        var options = [correctCountry.name];

        while (options.length < 3) {
          var randomCountry =
              countries[Random().nextInt(countries.length)].name;
          if (!options.contains(randomCountry)) {
            options.add(randomCountry);
          }
        }

        options.shuffle();

        questions.add(
          QuestionModel(
            questionText: 'Which country does this flag belong to?',
            options: options,
            correctAnswer: correctCountry.name,
            imageUrl: correctCountry.flag,
          ),
        );
      }
      return questions;
    } catch (e) {
      throw Exception('Error generating questions: $e');
    }
  }
}
