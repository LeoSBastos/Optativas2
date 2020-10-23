import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:web_api_curso/http/interceptor/logging_interceptor.dart';

final Client client =
    new HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

const String baseUrl = 'http://192.168.1.69:8080/api/v1/cursos';
