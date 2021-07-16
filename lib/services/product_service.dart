import 'package:bs_admin/utils/config.dart';
import 'package:http_repository/http_repository.dart';

class ProductService extends RepositoryCRUD {
  @override
  String get api => '${Config.api}/product';

}