import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:projeto_final/http/interceptor/logging_interceptor.dart';

final Client client =
    new HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

const String baseUrl = 'https://api.covid19api.com/summary';
