import 'package:dio/dio.dart';
import 'package:lanscare_app/day_34/models/harry_potter_models.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://hp-api.onrender.com/api/characters')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/')
  Future<List<HarryPotterModels>> getAllCharacter();
}
