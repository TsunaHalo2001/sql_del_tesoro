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
  void mapTreasure() {
    state = 4; // Change to the state for the treasure selector map
    notifyListeners();
  }
  void treasurePlay() async {
    state = 5; // Change to the state for the treasure intro
    turtlesGot = await getTurtles(); // Get turtles from the database

    notifyListeners();
  }
  void mapShark() {
    state = 6; // Change to the state for the shark intro
    notifyListeners();
  }
  void sharkPlay() {
    state = 7; // Change to the state for the shark play
    notifyListeners();
  }
  String printTreasures() {
    String result = '';

    List<Turtle> sortedTurtles = List.from(turtlesGot);
    sortedTurtles.sort((a, b) => b.treasure.compareTo(a.treasure));

    for (var turtle in sortedTurtles) {
      result += '${turtle.name} tiene ${turtle.treasure} tesoros.\n';
    }
    return result;
  }
  void eraseDatabase() async {
    final dbz = await getdb(); // Assuming DatabaseProvider is defined in the main scope
    await Turtle.eraseDatabase(dbz, 'all'); // Clear all turtles and records
    turtles.clear(); // Clear the turtles list
    turtlesGot.clear(); // Clear the turtles got list
    cannons = 0; // Reset cannons
    sharkKilled = 0; // Reset sharks killed
    ghostKilled = 0; // Reset ghosts killed
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

  Future<void> getTreasure() async {
    final dbz = await getdb(); // Assuming DatabaseProvider is defined in the main scope
    final List<Map<String, Object?>> maps = await dbz.query('turtle_got');

    turtlesGot = [
      for (final map in maps)
        Turtle(
          name: map['name'] as String,
          treasure: map['treasure'] as int,
        ),
    ];
    notifyListeners();
  }

  Future<void> purchaseCannon(String name) async {
    final dbz = await getdb();

    for (var turtle in turtlesGot) {
      if (turtle.name == name && turtle.treasure >= 10) {
        turtle.treasure -= 10; // Assuming each cannon costs 10 treasures
        await turtle.saveToDatabase(dbz, 'turtle_got'); // Save the updated turtle to the database
        await addCannon(); // Add a cannon
        notifyListeners();
      }
    }
  }

  Future<void> addCannon() async {
    final dbz = await getdb();

    cannons++;
    await dbz.insert(
      'records',
      {'id': 1, 'turtle': 0, 'cannons': cannons, 'shark_killed': sharkKilled, 'ghost_killed': ghostKilled, 'skull': skull},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    notifyListeners();
  }

  Future<void> getRecords() async {
    final dbz = await getdb();
    final List<Map<String, Object?>> maps = await dbz.query('records');

    if (maps.isNotEmpty) {
      cannons = maps[0]['cannons'] as int; // Get the number of cannons from the database
      sharkKilled = maps[0]['shark_killed'] as int; // Get the number of sharks killed from the database
      ghostKilled = maps[0]['ghost_killed'] as int; // Get the number of ghosts killed from the database
      skull = maps[0]['skull'] as int; // Get the number of skulls from the database
    } else {
      cannons = 0; // If no records, set cannons to 0
      sharkKilled = 0; // If no records, set sharks killed to 0
      ghostKilled = 0; // If no records, set ghosts killed to 0
      skull = 0; // If no records, set skulls to 0
    }
    notifyListeners();
  }

  Future<void> killShark() async {
    final dbz = await getdb();
    if (cannons <= 0) {
      return; // No cannons available to kill the shark
    }
    sharkKilled++;
    cannons--;
    await dbz.insert(
      'records',
      {'id': 1, 'turtle': 0, 'cannons': cannons, 'shark_killed': sharkKilled, 'ghost_killed': ghostKilled, 'skull': skull},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  var state = 0;
  List<Turtle> turtles = [];
  List<Turtle> turtlesGot = [];
  bool isChecked = false;
  int treasures = 0;
  String actualTreasure = '';
  int cannons = 0;
  int sharkKilled = 0;
  int ghostKilled = 0;
  int skull = 0;
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
    else if (data == 'all') {
      await db.execute(
        'DELETE FROM turtle',
      );
      await db.execute(
        'DELETE FROM turtle_got',
      );
      await db.execute(
        'DELETE FROM records',
      );
      await db.execute(
        'DELETE FROM shark',
      );
      await db.execute(
        'DELETE FROM ghost',
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