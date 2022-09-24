import 'dart:convert';

import 'package:product/data/model/response/banner_response_dto.dart';

import '../../json_reader.dart';

final resultBannerDummyJson = json.decode(
  TestHelper.readJson('helper/json/banner.json'),
);

final BannerResponseDto? bannerResponseDtoDummy =
    BannerResponseDto.fromJson(resultBannerDummyJson);
