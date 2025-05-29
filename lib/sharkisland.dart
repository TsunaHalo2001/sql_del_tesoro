part of 'main.dart';

class SharkIsland extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double minSize = screenWidth < screenHeight ? screenWidth : screenHeight;
    double maxSize = screenWidth > screenHeight ? screenWidth : screenHeight;

    if (screenHeight > screenWidth) {
      return SharkIslandVertical(appState: appState, minSize: minSize);
    }
    else {
      return SharkIslandHorizontal(appState: appState, minSize: minSize);
    }
  }
}

class SharkIslandVertical extends StatelessWidget {
  const SharkIslandVertical({
    super.key,
    required this.appState,
    required this.minSize,
  });

  final MyAppState appState;
  final double minSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MapBG(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: appState.mainPlay,
                      icon: Icon(Icons.backspace_outlined, color: Colors.white),
                    ),
                    Column(
                      children: [
                        TextWithShadow(
                          minSize: minSize,
                          labelText: '''Tiburones
eliminados''',
                          textColor: Colors.white,
                          shadowColor: Colors.blue,
                        ),
                        TextWithShadow(
                          minSize: minSize,
                          labelText: appState.sharkKilled.toString(),
                          textColor: Colors.white,
                          shadowColor: Colors.blue,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        TextWithShadow(
                          minSize: minSize,
                          labelText: '''Cañones
Disponibles''',
                          textColor: Colors.white,
                          shadowColor: Colors.amber,
                        ),
                        TextWithShadow(
                          minSize: minSize,
                          labelText: appState.cannons.toString(),
                          textColor: Colors.white,
                          shadowColor: Colors.amber,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SharkButtons(appState: appState, minSize: minSize),
              SharkButtons(appState: appState, minSize: minSize),
              SharkButtons(appState: appState, minSize: minSize),
              TextWithShadow(
                minSize: minSize * 0.8,
                labelText: "DELETE FROM tiburones",
                textColor: Colors.white,
                shadowColor: Colors.black,
              ),
              TextWithShadow(
                minSize: minSize * 0.8,
                labelText: "WHERE (fila, columna)",
                textColor: Colors.white,
                shadowColor: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SharkButtons extends StatelessWidget {
  const SharkButtons({
    super.key,
    required this.appState,
    required this.minSize,
  });

  final MyAppState appState;
  final double minSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: appState.killShark,
            icon: Image.asset(
              "assets/gif/shark.gif",
              width: minSize * 0.4,
              height: minSize * 0.4,
            ),
          ),
          IconButton(
            onPressed: appState.killShark,
            icon: Image.asset(
              "assets/gif/shark.gif",
              width: minSize * 0.4,
              height: minSize * 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class SharkIslandHorizontal extends StatelessWidget {
  const SharkIslandHorizontal({
    super.key,
    required this.appState,
    required this.minSize,
  });

  final MyAppState appState;
  final double minSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MapBG(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: minSize * 0.4,
                      height: minSize * 0.4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/gif/shark.gif"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: minSize * 0.4,
                      height: minSize * 0.4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/gif/shark.gif"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}