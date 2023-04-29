import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class Shared {
  static Future<HttpClient> customHttpClient() async {
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    try {
      final sslCert =
          await rootBundle.load('certificates/themoviedb-certificate.cer');
      securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        log('Certificate already trusted - skip it');
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }

    HttpClient httpClient = HttpClient(context: securityContext);
    httpClient.badCertificateCallback = (cert, host, port) => false;

    return httpClient;
  }

  /// create LetsEncrypt client trusted certificate
  static Future<http.Client> createClient() async {
    IOClient ioClient = IOClient(await Shared.customHttpClient());
    return ioClient;
  }
}
