abstract class AppPricingCalculator {
  /// Calculates the total price based on tax and shipping.
  static double calculateTotalPrice(double productPrice, String location) {
    final double taxRate = getTaxRateForLocation(location);
    final double taxAmount = productPrice * taxRate;
    final double shippingCost = getShippingCost(location);
    final double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  ///--- Calculate shipping cost
  static String calculateShippingCost(double productPrice, String location) {
    final double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  ///--- Calculate tax

  static String calculateTax(double productPrice, String location) {
    final double taxRate = getTaxRateForLocation(location);
    final double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    // This function should return the tax rate based on the location.
    // For simplicity, let's assume a flat tax rate of 5% for all locations.
    // In a real application, you would fetch this from a database or an API.
    return 0.10; // 5% tax rate
  }

  static double getShippingCost(String location) {
    // This function should return the shipping cost based on the location.
    // For simplicity, let's assume a flat shipping cost of $5 for all locations.
    // In a real application, you would fetch this from a database or an API.
    return 5.00; // Flat shipping cost
  }
}
