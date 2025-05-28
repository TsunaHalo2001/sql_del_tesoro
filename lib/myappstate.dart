part of 'main.dart';

class MyAppState extends ChangeNotifier {
  Future<Database> getdb() async {
    final db = openDatabase(
      join(
        await getDatabasesPath(),
        'sqldeltesoro',
      ),
      onCreate: (db, version) async {
        // Create tables and initialize the database
        await db.execute('''  
          CREATE TABLE records (
            id INTEGER PRIMARY KEY,
            turtle INTEGER DEFAULT 0,
            cannons INTEGER DEFAULT 0,
            shark_killed INTEGER DEFAULT 0,
            ghost_killed INTEGER DEFAULT 0,
            skull INTEGER DEFAULT 0
          );
          ''');
        await db.execute('''
          CREATE TABLE turtle (
            name TEXT PRIMARY KEY,
            treasure INTEGER
          );
          ''');
        await db.execute('''
          CREATE TABLE turtle_got (
            name TEXT PRIMARY KEY,
            treasure INTEGER
          );
          ''');
        await db.execute('''
          CREATE TABLE shark (
            name TEXT PRIMARY KEY
          );
          ''');
        await db.execute('''
          CREATE TABLE ghost (
            name TEXT PRIMARY KEY
          );
          ''');
      },
      version: 1,
    );
  return db;
  }

  void mainPlay() {
    state = 1; // Change to the state for the main play
    notifyListeners();
  }
  void mapTurtle() {
    state = 2; // Change to the state for the turtle selector map
    notifyListeners();
  }
  void turtlePlay() async {
    state = 3; // Change to the state for the turtle intro
    await generate('turtle'); // Generate turtles
    turtlesGot = await getTurtles(); // Get turtles from the database
    notifyListeners();
  }

  Future<void> generate(String type) async {
    final dbz = await getdb(); // Assuming DatabaseProvider is defined in the main scope
    // Logic to generate turtles
    switch (type) {
      case 'turtle':
        await Turtle.eraseDatabase(dbz, 'turtle'); // Clear existing turtles
        for (int i = 0; i < 5; i++) {
          var turtle = Turtle(name: '', treasure: 0);
          turtle.setRandom(); // Set random name and treasure
          turtles.add(turtle);
          await turtle.saveToDatabase(dbz, 'turtle'); // Assuming db is defined in the main scope
        }
        break;
      default:
        throw UnimplementedError('Unknown type: $type');
    }

    notifyListeners();
  }

  Future<List<Turtle>> getTurtles() async {
    final dbz = await getdb(); // Assuming DatabaseProvider is defined in the main scope
    final List<Map<String, Object?>> maps = await dbz.query('turtle_got');

    print('Turtles got: ${maps.length}');

    return [
      for (final map in maps)
        Turtle(
          name: map['name'] as String,
          treasure: map['treasure'] as int,
        ),
    ];
  }// Initialize the database

  Future<void> turtleSelected(int index) async {
    final dbz = await getdb(); // Assuming DatabaseProvider is defined in the main scope

    var turtle = turtles[index];
    for (var t in turtlesGot) {
      if (t.name == turtle.name) {
        turtle.treasure = turtle.treasure + t.treasure; // Add the treasure of the turtle already selected
        turtlesGot.remove(t); // Remove the turtle from the already selected list
      }
    }
    turtlesGot.add(turtle); // Add the selected turtle to the already selected list
    await turtle.saveToDatabase(dbz, 'turtle_got'); // Save the selected turtle to the database
    turtles.removeAt(index); // Remove the turtle from the available turtles list
    await turtle.eraseTurtle(dbz, 'turtle', turtle.name); // Erase the turtle from the database

    var newTurtle = Turtle(name: '', treasure: 0);
    newTurtle.setRandom(); // Set random name and treasure for the new turtle
    turtles.add(newTurtle); // Add the new turtle to the available turtles list
    await newTurtle.saveToDatabase(dbz, 'turtle'); // Save the new turtle to the database

    notifyListeners();
  }

  Future<void> getTurtleTreasure() async {
    final dbz = await getdb(); // Assuming DatabaseProvider is defined in the main scope
    final List<Map<String, Object?>> maps = await dbz.query('turtle_got');

    int totalTreasure = 0;
    for (final map in maps) {
      totalTreasure += map['treasure'] as int;
    }
    treasures = totalTreasure; // Return the total treasure of all turtles
  }

  var state = 0;
  List<Turtle> turtles = [];
  List<Turtle> turtlesGot = [];
  bool isChecked = false;
  int treasures = 0;
}

class Turtle {
  Turtle({
    required this.name,
    required this.treasure}
  );

  String name;
  int treasure;

  Future<void> saveToDatabase(Database db, String data) async {
    if (data == 'turtle') {
      await db.insert(
        'turtle',
        {'name': name, 'treasure': treasure},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    else if (data == 'turtle_got') {
      await db.insert(
        'turtle_got',
        {'name': name, 'treasure': treasure},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<void> eraseDatabase(Database db, String data) async {
    if (data == 'turtle') {
      await db.execute(
        'DELETE FROM turtle',
      );
    }
    else if (data == 'turtle_got') {
      await db.execute(
        'DELETE FROM turtle_got',
      );
    }
  }

  Future<void> eraseTurtle(Database db, String data, String name) async {
    if (data == 'turtle') {
      await db.delete(
        'turtle',
        where: 'name = ?',
        whereArgs: [name],
      );
    }
    else if (data == 'turtle_got') {
      await db.delete(
        'turtle_got',
        where: 'name = ?',
        whereArgs: [name],
      );
    }
  }

  void setRandom() {
    name = WordPair.random().asLowerCase;
    treasure = Random().nextInt(10) + 1;
  }

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'treasure': treasure,
    };
  }

  @override
  String toString() {
    return 'Turtle{name: $name, treasure: $treasure}';
  }
}