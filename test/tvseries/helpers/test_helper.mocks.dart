// Mocks generated by Mockito 5.3.2 from annotations
// in ditonton/test/tvseries/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:convert' as _i14;
import 'dart:typed_data' as _i15;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/common/failure.dart' as _i7;
import 'package:ditonton/data/tvseries/datasources/tvseries_local_data_source.dart'
    as _i12;
import 'package:ditonton/data/tvseries/datasources/tvseries_remote_data_source.dart'
    as _i10;
import 'package:ditonton/data/tvseries/models/tvseries_detail_model.dart'
    as _i3;
import 'package:ditonton/data/tvseries/models/tvseries_model.dart' as _i11;
import 'package:ditonton/data/tvseries/models/tvseries_table.dart' as _i13;
import 'package:ditonton/domain/tvseries/entities/tvseries.dart' as _i8;
import 'package:ditonton/domain/tvseries/entities/tvseries_detail.dart' as _i9;
import 'package:ditonton/domain/tvseries/repositories/tvseries_repository.dart'
    as _i5;
import 'package:http/http.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTVSeriesDetailModel_1 extends _i1.SmartFake
    implements _i3.TVSeriesDetailModel {
  _FakeTVSeriesDetailModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_2 extends _i1.SmartFake implements _i4.Response {
  _FakeResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_3 extends _i1.SmartFake
    implements _i4.StreamedResponse {
  _FakeStreamedResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TVSeriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVSeriesRepository extends _i1.Mock
    implements _i5.TVSeriesRepository {
  MockTVSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>> getOnAirTVSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getOnAirTVSeries,
          [],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>.value(
                _FakeEither_0<_i7.Failure, List<_i8.TVSeries>>(
          this,
          Invocation.method(
            #getOnAirTVSeries,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>
      getPopularTVSeries() => (super.noSuchMethod(
            Invocation.method(
              #getPopularTVSeries,
              [],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i8.TVSeries>>(
              this,
              Invocation.method(
                #getPopularTVSeries,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>
      getTopRatedTVSeries() => (super.noSuchMethod(
            Invocation.method(
              #getTopRatedTVSeries,
              [],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i8.TVSeries>>(
              this,
              Invocation.method(
                #getTopRatedTVSeries,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i9.TVSeriesDetail>> getTVSeriesDetail(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTVSeriesDetail,
          [id],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, _i9.TVSeriesDetail>>.value(
                _FakeEither_0<_i7.Failure, _i9.TVSeriesDetail>(
          this,
          Invocation.method(
            #getTVSeriesDetail,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i9.TVSeriesDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>
      getTVSeriesRecommendations(int? id) => (super.noSuchMethod(
            Invocation.method(
              #getTVSeriesRecommendations,
              [id],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i8.TVSeries>>(
              this,
              Invocation.method(
                #getTVSeriesRecommendations,
                [id],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>> searchTVSeries(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTVSeries,
          [query],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>.value(
                _FakeEither_0<_i7.Failure, List<_i8.TVSeries>>(
          this,
          Invocation.method(
            #searchTVSeries,
            [query],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>
      getWatchlistTVSeries() => (super.noSuchMethod(
            Invocation.method(
              #getWatchlistTVSeries,
              [],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i8.TVSeries>>(
              this,
              Invocation.method(
                #getWatchlistTVSeries,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TVSeries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveWatchlist(
          _i9.TVSeriesDetail? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlist,
          [tvSeries],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
            _FakeEither_0<_i7.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlist,
            [tvSeries],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeFromWatchlist(
          _i9.TVSeriesDetail? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFromWatchlist,
          [tvSeries],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
            _FakeEither_0<_i7.Failure, String>(
          this,
          Invocation.method(
            #removeFromWatchlist,
            [tvSeries],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<bool> isAddedToWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlist,
          [id],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
}

/// A class which mocks [TVSeriesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVSeriesRemoteDataSource extends _i1.Mock
    implements _i10.TVSeriesRemoteDataSource {
  MockTVSeriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i11.TVSeriesModel>> getOnAirTVSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getOnAirTVSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i11.TVSeriesModel>>.value(<_i11.TVSeriesModel>[]),
      ) as _i6.Future<List<_i11.TVSeriesModel>>);
  @override
  _i6.Future<List<_i11.TVSeriesModel>> getPopularTVSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularTVSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i11.TVSeriesModel>>.value(<_i11.TVSeriesModel>[]),
      ) as _i6.Future<List<_i11.TVSeriesModel>>);
  @override
  _i6.Future<List<_i11.TVSeriesModel>> getTopRatedTVSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedTVSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i11.TVSeriesModel>>.value(<_i11.TVSeriesModel>[]),
      ) as _i6.Future<List<_i11.TVSeriesModel>>);
  @override
  _i6.Future<_i3.TVSeriesDetailModel> getTVSeriesDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTVSeriesDetail,
          [id],
        ),
        returnValue: _i6.Future<_i3.TVSeriesDetailModel>.value(
            _FakeTVSeriesDetailModel_1(
          this,
          Invocation.method(
            #getTVSeriesDetail,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.TVSeriesDetailModel>);
  @override
  _i6.Future<List<_i11.TVSeriesModel>> getTVSeriesRecommendations(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTVSeriesRecommendations,
          [id],
        ),
        returnValue:
            _i6.Future<List<_i11.TVSeriesModel>>.value(<_i11.TVSeriesModel>[]),
      ) as _i6.Future<List<_i11.TVSeriesModel>>);
  @override
  _i6.Future<List<_i11.TVSeriesModel>> searchTVSeries(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTVSeries,
          [query],
        ),
        returnValue:
            _i6.Future<List<_i11.TVSeriesModel>>.value(<_i11.TVSeriesModel>[]),
      ) as _i6.Future<List<_i11.TVSeriesModel>>);
}

/// A class which mocks [TVSeriesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVSeriesLocalDataSource extends _i1.Mock
    implements _i12.TVSeriesLocalDataSource {
  MockTVSeriesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> insertWatchlist(_i13.TVSeriesTable? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [tvSeries],
        ),
        returnValue: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<String> removeWatchlist(_i13.TVSeriesTable? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [tvSeries],
        ),
        returnValue: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<_i13.TVSeriesTable?> getTVSeriesById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTVSeriesById,
          [id],
        ),
        returnValue: _i6.Future<_i13.TVSeriesTable?>.value(),
      ) as _i6.Future<_i13.TVSeriesTable?>);
  @override
  _i6.Future<List<_i13.TVSeriesTable>> getWatchlistTVSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTVSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i13.TVSeriesTable>>.value(<_i13.TVSeriesTable>[]),
      ) as _i6.Future<List<_i13.TVSeriesTable>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i4.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i14.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i14.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i14.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i14.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<_i15.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i15.Uint8List>.value(_i15.Uint8List(0)),
      ) as _i6.Future<_i15.Uint8List>);
  @override
  _i6.Future<_i4.StreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i6.Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_3(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i6.Future<_i4.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
