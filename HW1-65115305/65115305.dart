class MenuItem {
  String name;
  double price;
  String category;

  MenuItem({required this.name, required this.price, required this.category});
}

class Order {
  int orderId;
  int tableNumber;
  List<MenuItem> items;
  bool isCompleted;

  Order({required this.orderId, required this.tableNumber})
      : items = [],
        isCompleted = false;

  void addItem(MenuItem item) {
    items.add(item);
  }

  void removeItem(MenuItem item) {
    items.remove(item);
  }

  void completeOrder() {
    isCompleted = true;
  }
}

class Restaurant {
  List<MenuItem> menu;
  List<Order> orders;
  Map<int, bool> tables;

  Restaurant()
      : menu = [],
        orders = [],
        tables = {};

  // CRUD operations for MenuItem
  void createMenuItem(String name, double price, String category) {
    MenuItem item = MenuItem(name: name, price: price, category: category);
    menu.add(item);
  }

  MenuItem? readMenuItem(String name) {
    for (MenuItem item in menu) {
      if (item.name == name) {
        return item;
      }
    }
    return null;
  }

  void updateMenuItem(String oldName, String newName, double newPrice, String newCategory) {
    for (MenuItem item in menu) {
      if (item.name == oldName) {
        item.name = newName;
        item.price = newPrice;
        item.category = newCategory;
        break;
      }
    }
  }

  void deleteMenuItem(String name) {
    menu.removeWhere((item) => item.name == name);
  }

  // CRUD operations for Order
  void createOrder(int orderId, int tableNumber) {
    Order order = Order(orderId: orderId, tableNumber: tableNumber);
    orders.add(order);
    tables[tableNumber] = true; // Mark the table as occupied
  }

  Order? readOrder(int orderId) {
    for (Order order in orders) {
      if (order.orderId == orderId) {
        return order;
      }
    }
    return null;
  }

  void updateOrder(int orderId, int newTableNumber, List<MenuItem> newItems) {
    for (Order order in orders) {
      if (order.orderId == orderId) {
        order.tableNumber = newTableNumber;
        order.items = newItems;
        break;
      }
    }
  }

  void deleteOrder(int orderId) {
    orders.removeWhere((order) => order.orderId == orderId);
  }

  void completeOrder(int orderId) {
    for (Order order in orders) {
      if (order.orderId == orderId) {
        order.completeOrder();
        tables[order.tableNumber] = false; // Mark the table as available
        break;
      }
    }
  }

  MenuItem? getMenuItem(String name) {
    for (MenuItem item in menu) {
      if (item.name == name) {
        return item;
      }
    }
    return null;
  }

  Order? getOrder(int orderId) {
    for (Order order in orders) {
      if (order.orderId == orderId) {
        return order;
      }
    }
    return null;
  }
}

void main() {
  // สร้างร้านอาหาร
  Restaurant restaurant = Restaurant();

  // เพิ่มเมนูอาหาร
  restaurant.createMenuItem('Pasta', 12.5, 'Main Course');
  restaurant.createMenuItem('Caesar Salad', 8.0, 'Appetizer');
  restaurant.createMenuItem('Cheesecake', 6.5, 'Dessert');

  // อ่านและแสดงเมนู
  print('--- Menu ---');
  restaurant.menu.forEach((item) {
    print('${item.name} - ${item.price} USD - ${item.category}');
  });

  // อัปเดตเมนู
  restaurant.updateMenuItem('Pasta', 'Spaghetti Carbonara', 13.0, 'Main Course');

  // ลบเมนู
  restaurant.deleteMenuItem('Caesar Salad');

  // อ่านและแสดงเมนูหลังการอัปเดตและลบ
  print('\n--- Updated Menu ---');
  restaurant.menu.forEach((item) {
    print('${item.name} - ${item.price} USD - ${item.category}');
  });

  // สร้างออเดอร์
  restaurant.createOrder(1, 10);
  Order? order = restaurant.readOrder(1);
  if (order != null) {
    order.addItem(restaurant.getMenuItem('Spaghetti Carbonara')!);
    order.addItem(restaurant.getMenuItem('Cheesecake')!);
  }

  // อ่านและแสดงออเดอร์
  print('\n--- Orders ---');
  restaurant.orders.forEach((order) {
    print('Order ID: ${order.orderId} - Table: ${order.tableNumber}');
    order.items.forEach((item) {
      print('  ${item.name} - ${item.price} USD');
    });
  });

  // อัปเดตออเดอร์
  if (order != null) {
    order.removeItem(restaurant.getMenuItem('Cheesecake')!);
    order.addItem(restaurant.getMenuItem('Spaghetti Carbonara')!);
  }

  // ลบออเดอร์
  restaurant.deleteOrder(1);

  // แสดงสถานะของโต๊ะ
  print('\n--- Table Status ---');
  restaurant.tables.forEach((tableNumber, isOccupied) {
    print('Table $tableNumber: ${isOccupied ? 'Occupied' : 'Available'}');
  });

  // สร้างออเดอร์ใหม่และทำให้เสร็จสมบูรณ์
  restaurant.createOrder(2, 12);
  restaurant.completeOrder(2);

  // แสดงสถานะของโต๊ะหลังทำออเดอร์เสร็จ
  print('\n--- Updated Table Status ---');
  restaurant.tables.forEach((tableNumber, isOccupied) {
    print('Table $tableNumber: ${isOccupied ? 'Occupied' : 'Available'}');
  });
}