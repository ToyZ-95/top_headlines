class Categories {
  static String selectedCategory = 'General';
  static List<String> getCategories() {
    List<String> categories = [];
    categories.add('General');
    categories.add('Business');
    categories.add('Entertainment');
    categories.add('Health');
    categories.add('Science');
    categories.add('Sports');
    categories.add('Technology');
    return categories;
  }
}
