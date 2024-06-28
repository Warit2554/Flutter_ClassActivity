class Person {
  String _name;

  Person(this._name);

  String get name => _name;
  set name(String name) => _name = name;
}

class Engine {
  String _model;
  int _speed;

  Engine(this._model, this._speed);

  String get model => _model;
  set model(String model) => _model = model;

  int get speed => _speed;
  set speed(int speed) => _speed = speed;

  displayEngineInfo() {
    print("Engine model: $_model, Speed: $_speed km/h");
  }
}

class Car {
  String _brand;
  String _model;
  Person _owner;
  Engine _engine;

  Car(this._brand, this._model, this._owner, this._engine);

  String get brand => _brand;
  set brand(String brand) => _brand = brand;

  String get model => _model;
  set model(String model) => _model = model;

  Person get owner => _owner;
  set owner(Person owner) => _owner = owner;

  Engine get engine => _engine;
  set engine(Engine engine) => _engine = engine;

  displayCarInfo() {
    print(
        "Brand: $brand\nModel: $model\nOwner: ${owner.name}\nEngine:${engine.model}");
  }

  run() {
    print("$brand $model by ${owner.name} is running at ${_engine.speed} km/h");
  }
}

class Honda extends Car {
  String _color;

  Honda(String brand, String model, Person owner, Engine engine, this._color)
      : super(brand, model, owner, engine);

  String get color => _color;
  set color(String color) => _color = color;

  void run() {
    super.run();
    print("Honda running at 120 km/h");
  }

  void displayCarInfo() {
    print("Brand: $brand");
    print("Model: $model");
    print("Color: $_color");
    print("Owner: ${owner.name}");
    print("Engine: ${engine.model}");
  }
}

class Mycar extends Car {
  String _color;

  Mycar(String brand, String model, Person owner, Engine engine, this._color)
      : super(brand, model, owner, engine);

  String get color => _color;
  set color(String color) => _color = color;

  void run() {
    print("${owner.name} car running at ${engine.speed} km/h");
  }

  void displayCarInfo() {
    print("Brand: $brand");
    print("Model: $model");
    print("Color: $_color");
    print("Owner: ${owner.name}");
    print("Engine: ${engine.model}");
  }
}

void main() {
  Person person = Person("Messi");
  Person person1 = Person("Ronoldo Shuuuuuu");
  Engine engine = Engine("V2", 220);
  Engine engine1 = Engine("V12", 300);
  Car honda = Honda("Honda", "Ceevic", person, engine, "Green");
  Car mycar = Mycar("Toyota", "Corolla AE80", person1, engine1, "Black");

  engine.displayEngineInfo();
  engine1.displayEngineInfo();
  print("---------------->");
  print(" Frist Car");
  mycar.displayCarInfo();
  print("---------------->");
  print(" Second Car");
  honda.displayCarInfo();
  print("---------------->");
  honda.run();
  mycar.run();
}
