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

// CRUD ---------------------------------------------------
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

  void updateMenuItem(
      String oldName, String newName, double newPrice, String newCategory) {
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

// CRUD ---------------------------------------------------end
// CRUD ---------------------------------------------------
  void createOrder(int orderId, int tableNumber) {
    Order order = Order(orderId: orderId, tableNumber: tableNumber);
    orders.add(order);
    tables[tableNumber] = true;
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
// CRUD ---------------------------------------------------end

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
  //Restaurant ----------------------------------------------------------
  Restaurant araimairu = Restaurant();
  //Create
  araimairu.createMenuItem('ข้าวผัดกระเพราะไข่เยี่ยวหมา', 120, 'อาหารจารเดียว');
  araimairu.createMenuItem('สลัดผัก', 80, 'ของทานเล่น');
  araimairu.createMenuItem('บลาวนี่', 50, 'ของหวาน');
  //Read
//   print("<---- MENU ---->");
//   araimairu.menu.forEach((item) {
//     print('${item.name}  ${item.price} BAHT  ${item.category}');
//   });
  //Update
  araimairu.updateMenuItem(
      'ข้าวผัดกระเพราะไข่เยี่ยวหมา', 'ข้าวไข่เจียว', 40, 'อาหารจานเดียว');
  //Del
  araimairu.deleteMenuItem('สลัดผัก');
  //Read
  print('\n<---- MENU ---->');
  araimairu.menu.forEach((item) {
    print('${item.name}  ${item.price} BAHT  ${item.category}');
  });
  //Restaurant end

  //Order ----------------------------------------------------------

  //Create order for orderId = 1 Table = 10
  araimairu.createOrder(1, 1);
  araimairu.createOrder(2, 2);
  araimairu.createOrder(3, 3);
  araimairu.createOrder(4, 4);
  araimairu.createOrder(5, 5);

  //Specific for orderId = 1
  Order? order = araimairu.readOrder(1);
  if (order != null) {
    order.addItem(araimairu.getMenuItem('ข้าวไข่เจียว')!);
    order.addItem(araimairu.getMenuItem('บลาวนี่')!);
  }
  Order? order2 = araimairu.readOrder(2);
  if (order2 != null) {
    order2.addItem(araimairu.getMenuItem('ข้าวไข่เจียว')!);
    order2.addItem(araimairu.getMenuItem('ข้าวไข่เจียว')!);
  }
  Order? order3 = araimairu.readOrder(3);
  if (order3 != null) {
    order3.addItem(araimairu.getMenuItem('ข้าวไข่เจียว')!);
    order3.addItem(araimairu.getMenuItem('บลาวนี่')!);
  }
  Order? order4 = araimairu.readOrder(4);
  if (order4 != null) {
    order4.addItem(araimairu.getMenuItem('ข้าวไข่เจียว')!);
    order4.addItem(araimairu.getMenuItem('บลาวนี่')!);
  }
  Order? order5 = araimairu.readOrder(5);
  if (order5 != null) {
    order5.addItem(araimairu.getMenuItem('ข้าวไข่เจียว')!);
    order5.addItem(araimairu.getMenuItem('บลาวนี่')!);
  }

  //Read
  print('\n<---- Orders ---->');
  araimairu.orders.forEach((order) {
    print('\nOrder ID: ${order.orderId} Table: ${order.tableNumber}');
    order.items.forEach((item) {
      print('-${item.name} ${item.price} BAHT');
    });
  });

  if (order != null) {
    order.removeItem(araimairu.getMenuItem('บลาวนี่')!);
    order.addItem(araimairu.getMenuItem('ข้าวไข่เจียว')!);
  }

  //complete than ว่าง โต๊ะ
  araimairu.completeOrder(1);
  araimairu.completeOrder(2);
  araimairu.completeOrder(5);

  //Status Table ----------------------------------------------------------

  print('\n<---- Table Status ---->');
  araimairu.tables.forEach((tableNumber, isOccupied) {
    print(
        'Table $tableNumber: ${isOccupied ? 'ไม่ว่าง' : 'ว่าง กินเสร็จแล้ว'}');
  });
}
