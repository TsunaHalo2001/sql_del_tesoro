part of 'main.dart';

class TurtleIsland extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double minSize = screenWidth < screenHeight ? screenWidth : screenHeight;
    double maxSize = screenWidth > screenHeight ? screenWidth : screenHeight;

    if (screenHeight > screenWidth) {
      return TurtleIslandVertical(appState: appState, minSize: minSize);
    }
    else {
      return TurtleIslandHorizontal(appState: appState, minSize: minSize);
    }
  }
}

class TurtleIslandVertical extends StatelessWidget {
  const TurtleIslandVertical({
    super.key,
    required this.appState,
    required this.minSize,
  });

  final MyAppState appState;
  final double minSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainBG(bgImage: "assets/jpg/sandbg.jpg"),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: appState.mainPlay,
                            icon: Icon(Icons.backspace_outlined, color: Colors.white),
                          ),
                          Spacer(),
                          TextWithShadow(
                            minSize: minSize * 0.8,
                            labelText: "Total Tesoros: ${appState.treasures}",
                            textColor: Colors.yellow,
                            shadowColor: Colors.black,
                          ),
                          Spacer(),
                        ],
                      ),
                      TextWithShadow(
                        minSize: minSize * 0.8,
                        labelText: "SELECT SUM(tesoros) AS 'Total Tesoros'",
                        textColor: Colors.white,
                        shadowColor: Colors.black,
                      ),
                    ],
                  ),
                  ),
              ),
              TurtleSelector(appState: appState, minSize: minSize, selector: 0, verticalRatio: 0.3, horizontalRatio: 0.6),
              TurtleSelector(appState: appState, minSize: minSize, selector: 1, verticalRatio: 0.3, horizontalRatio: 0.6),
              TurtleSelector(appState: appState, minSize: minSize, selector: 2, verticalRatio: 0.3, horizontalRatio: 0.6),
              TurtleSelector(appState: appState, minSize: minSize, selector: 3, verticalRatio: 0.3, horizontalRatio: 0.6),
              TurtleSelector(appState: appState, minSize: minSize, selector: 4, verticalRatio: 0.3, horizontalRatio: 0.6),
            ],
          ),
        ),
      ],
    );
  }
}

class TurtleIslandHorizontal extends StatelessWidget {
  const TurtleIslandHorizontal({
    super.key,
    required this.appState,
    required this.minSize,
  });

  final MyAppState appState;
  final double minSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainBG(bgImage: "assets/jpg/sandbg.jpg"),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: appState.mainPlay,
                            icon: Icon(Icons.backspace_outlined, color: Colors.white),
                          ),
                          Spacer(),
                          TextWithShadow(
                            minSize: minSize * 0.8,
                            labelText: "Total Tesoros: ${appState.treasures}",
                            textColor: Colors.yellow,
                            shadowColor: Colors.black,
                          ),
                          Spacer(),
                        ],
                      ),
                      TextWithShadow(
                        minSize: minSize * 0.8,
                        labelText: "SELECT SUM(tesoros) AS 'Total Tesoros'",
                        textColor: Colors.white,
                        shadowColor: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  TurtleSelector(appState: appState, minSize: minSize, selector: 0, verticalRatio: 0.5, horizontalRatio: 0.3),
                  TurtleSelector(appState: appState, minSize: minSize, selector: 1, verticalRatio: 0.5, horizontalRatio: 0.3),
                  TurtleSelector(appState: appState, minSize: minSize, selector: 2, verticalRatio: 0.5, horizontalRatio: 0.3),
                  TurtleSelector(appState: appState, minSize: minSize, selector: 3, verticalRatio: 0.5, horizontalRatio: 0.3),
                  TurtleSelector(appState: appState, minSize: minSize, selector: 4, verticalRatio: 0.5, horizontalRatio: 0.3),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TurtleSelector extends StatelessWidget {
  const TurtleSelector({
    super.key,
    required this.appState,
    required this.minSize,
    required this.selector,
    required this.verticalRatio,
    required this.horizontalRatio,
  });

  final MyAppState appState;
  final double minSize;
  final int selector;
  final double verticalRatio;
  final double horizontalRatio;

  @override
  Widget build(BuildContext context) {
    if (horizontalRatio > verticalRatio) {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(value: appState.isChecked, onChanged: (bool? value) {
              appState.turtleSelected(selector);
            },
            ),
            TextWithShadow(
              minSize: minSize * 0.8,
              labelText: appState.turtles[selector].name,
              textColor: Colors.green,
              shadowColor: Colors.black,
            ),
            Spacer(),
            HideTreasures(
              minSize: minSize,
              appState: appState,
              indexer: selector,
              verticalRatio: verticalRatio,
              horizontalRatio: horizontalRatio,
            ),
          ],
        ),
      );
    }
    else {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(value: appState.isChecked, onChanged: (bool? value) {
              appState.turtleSelected(selector);
            },
            ),
            TextWithShadow(
              minSize: minSize * 0.8,
              labelText: appState.turtles[selector].name,
              textColor: Colors.green,
              shadowColor: Colors.black,
            ),
            HideTreasures(
              minSize: minSize,
              appState: appState,
              indexer: selector,
              verticalRatio: verticalRatio,
              horizontalRatio: horizontalRatio,
            ),
          ],
        ),
      );
    }
  }
}

class HideTreasures extends StatelessWidget {
  const HideTreasures({
    super.key,
    required this.minSize,
    required this.appState,
    required this.indexer,
    required this.verticalRatio,
    required this.horizontalRatio,
  });

  final double minSize;
  final MyAppState appState;
  final int indexer;
  final double verticalRatio;
  final double horizontalRatio;

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return SizedBox(
      width: minSize * horizontalRatio,
      height: minSize * verticalRatio,
      child: Stack(
        alignment: Alignment.center,
        children:
          generateRandomImages(appState, appState.turtlesGot[indexer].treasure, random, minSize, 'assets/gif/coin.gif', 0.05, verticalRatio, horizontalRatio) +
          generateRandomImages(appState, 90, random, minSize, 'assets/png/turtle.png', 0.1, verticalRatio, horizontalRatio),
      ),
    );
  }
}

List<Widget> generateRandomImages(MyAppState appState, int cuantity, Random random, double minSize, String image, double size, double verticalRatio, double horizontalRatio) {
  return List<Widget>.generate(cuantity, (index) {
    double left = random.nextDouble() * (minSize * horizontalRatio);
    double top = random.nextDouble() * (minSize * verticalRatio);
    return Positioned(
      left: left,
      top: top,
      child: Image.asset(
        image,
        width: minSize * size,
        height: minSize * size,
      ),
    );
  }
  );
}