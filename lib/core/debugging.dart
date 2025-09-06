import 'package:super_brain/core/services/test_data_service.dart';
import 'package:super_brain/core/services/test_summary_data_service.dart';

/// Debugging utilities for development
class DebugHelper {
  /// Populate test data for development
  static Future<void> populateTestData() async {
    try {
      // Populate summaries
      await TestSummaryDataService.populateTestSummaries();
      print('✅ Test summaries populated');

      print('🎉 All test data populated successfully!');
    } catch (e) {
      print('❌ Error populating test data: $e');
    }
  }

  /// Clear all test data
  static Future<void> clearTestData() async {
    try {
      // Clear word lists
      await TestDataService.clearTestData();
      print('✅ Test word lists cleared');

      // Clear summaries
      await TestSummaryDataService.clearTestSummaries();
      print('✅ Test summaries cleared');

      print('🧹 All test data cleared successfully!');
    } catch (e) {
      print('❌ Error clearing test data: $e');
    }
  }
}
