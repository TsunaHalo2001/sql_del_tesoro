part of 'main.dart';

class TreasureIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double minSize = screenWidth < screenHeight ? screenWidth : screenHeight;
    double maxSize = screenWidth > screenHeight ? screenWidth : screenHeight;

    if (screenHeight > screenWidth) {
      return TreasureIntroVertical(
        minSize: minSize,
        maxSize: maxSize,
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        appState: appState,
      );
    } else {
      return TreasureIntroHorizontal(
        minSize: minSize,
        maxSize: maxSize,
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        appState: appState,
      );
    }
  }
}

class TreasureIntroVertical extends StatelessWidget {
  const TreasureIntroVertical({
    super.key,
    required this.minSize,
    required this.maxSize,
    required this.screenHeight,
    required this.screenWidth,
    required this.appState,
  });

  final double minSize;
  final double maxSize;
  final double screenHeight;
  final double screenWidth;
  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IntroBG(color: Colors.limeAccent,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IslandBanner(minSize: minSize,
              maxSize: maxSize,
              isVertical: screenHeight > screenWidth,
              islandImage: "assets/png/treasureisland.png",
            ),
            TextScrollable(
              minSize: minSize,
              title: "¡Bienvenido a la Isla Tesoro!",
              description: "En esta isla te enseñaremos a usar UPDATE, "
                  "un comando que te permite modificar atributos de una tabla. "
                  "Usaras UPDATE para actualizar tus tesoros al comprar cañones, "
                  "los necesitaras.",
            ),
            SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CommonButton(
                    appState: appState,
                    minSize: minSize,
                    onPressed: appState.mainPlay,
                    label: "Volver al mapa",
                    labelColor: Colors.white,
                    buttonColor: Colors.amber,
                  ),
                  CommonButton(
                    appState: appState,
                    minSize: minSize,
                    onPressed: appState.treasurePlay,
                    label: "¡Empezar!",
                    labelColor: Colors.white,
                    buttonColor: Colors.amber,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TreasureIntroHorizontal extends StatelessWidget {
  const TreasureIntroHorizontal({
    super.key,
    required this.minSize,
    required this.maxSize,
    required this.screenHeight,
    required this.screenWidth,
    required this.appState,
  });

  final double minSize;
  final double maxSize;
  final double screenHeight;
  final double screenWidth;
  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IntroBG(color: Colors.limeAccent,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: IslandBanner(
              minSize: minSize,
              maxSize: maxSize,
              isVertical: screenHeight > screenWidth,
              islandImage: "assets/png/treasureisland.png",
            )),
            Expanded(
              child: Column(
                children: [
                  TextScrollable(
                    minSize: minSize,
                    title: "¡Bienvenido a la Isla Tesoro!",
                    description: "En esta isla te enseñaremos a usar UPDATE, "
                        "un comando que te permite modificar atributos de una tabla. "
                        "Usaras UPDATE para actualizar tus tesoros al comprar cañones, "
                        "los necesitaras.",
                  ),
                  SafeArea(
                    top: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CommonButton(
                          appState: appState,
                          minSize: minSize,
                          onPressed: appState.mainPlay,
                          label: "Volver al mapa",
                          labelColor: Colors.white,
                          buttonColor: Colors.amber,
                        ),
                        CommonButton(
                          appState: appState,
                          minSize: minSize,
                          onPressed: appState.treasurePlay,
                          label: "¡Empezar!",
                          labelColor: Colors.white,
                          buttonColor: Colors.amber,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}