import '../../../../achitecture.dart';

abstract class ItemDataSource {
  Future<List<Item>> getItems();
}
