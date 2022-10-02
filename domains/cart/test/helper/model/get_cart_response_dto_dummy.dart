import 'dart:convert';

import 'package:cart/data/model/response/cart_response_dto.dart';

import '../json_reader.dart';

final resultGetCartDummyJson = json.decode(
  TestHelper.readJson('helper/json/get_carts.json'),
);

final CartResponseDto getCartResponseDtoDummy =
    CartResponseDto.fromJson(resultGetCartDummyJson);
