import 'dart:developer';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

class PaginationController extends GetxController {
  PaginationController(this.stateManager, this.numOfItemsPerPage, this.fetchItems);

  PlutoGridStateManager stateManager;

  final int numOfItemsPerPage;
  final RxInt _currentPageNum = 1.obs;
  RxInt get currentPageNum => _currentPageNum;

  final RxInt numOfAllItems = 0.obs;

  final RxInt _numOfPages = 1.obs;
  RxInt get numOfPages => _numOfPages;

  final Future Function(int selectedPageNum, int numOfItemsPerPage) fetchItems;

  /// this map used to determine if the page isLoaded.
  Map<int, bool> isLoaded = {};

  @override
  void onInit() {
    stateManager.setPageSize(numOfItemsPerPage, notify: false);
    fetchItems(currentPageNum.value, numOfItemsPerPage);
    super.onInit();
  }

  bool isPageLoaded(int pageNum) {
    final isPageLoaded = isLoaded[pageNum] ?? false;

    return isPageLoaded;
  }

  void setIsLoaded(int pageNum) {
    isLoaded[pageNum] = true;
  }

  void setAllItemsNumber(int numOfAllItems) {
    this.numOfAllItems(numOfAllItems);
  }

  void setNumOfPages(int numOfPages) {
    _numOfPages(numOfPages);
  }

  Future<void> setSelectedPage(int selectedPageNum) async {
    _currentPageNum.value = selectedPageNum;
    stateManager.setPage(_currentPageNum.value);

    log('selected page: $_currentPageNum');
    

    /// if the selected page is not loaded then => download it
    if (!isPageLoaded(_currentPageNum.value)) {
      await fetchItems(_currentPageNum.value, numOfItemsPerPage);

      setIsLoaded(_currentPageNum.value);
    }
  }

  void initStateManager(PlutoGridStateManager stateManager) {
    this.stateManager = stateManager;
    setSelectedPage(_currentPageNum.value);
  }

  void refreshItems() {
    stateManager.removeAllRows();
    isLoaded.clear();
    _currentPageNum(1);
    setSelectedPage(_currentPageNum.value);
  }
}
