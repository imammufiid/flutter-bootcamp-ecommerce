import 'package:cart/data/mapper/cart_mapper.dart';
import '../model/get_cart_response_dto_dummy.dart';

final CartMapper mapper = CartMapper();
final cartDataEntityDummy =
    mapper.mapCartDataDtoToEntity(getCartResponseDtoDummy.data);
