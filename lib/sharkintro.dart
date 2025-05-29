part of 'main.dart';

class SharkIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double minSize = screenWidth < screenHeight ? screenWidth : screenHeight;
    double maxSize = screenWidth > screenHeight ? screenWidth : screenHeight;

    if (screenHeight > screenWidth) {
      return SharkIntroVertical(
        minSize: minSize,
        maxSize: maxSize,
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        appState: appState,
      );
    } else {
      return SharkIntroHorizontal(
        minSize: minSize,
        maxSize: maxSize,
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        appState: appState,
      );
    }
  }
}

class SharkIntroVertical extends StatelessWidget {
  const SharkIntroVertical({
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
        IntroBG(color: Colors.blueAccent,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IslandBanner(minSize: minSize,
              maxSize: maxSize,
              isVertical: screenHeight > screenWidth,
              islandImage: "assets/png/sharkislandtransparent.png",
            ),
            TextScrollable(
              minSize: minSize,
              title: "¡Bienvenido a la Isla Tiburon!",
              description: "En esta isla te enseñaremos a usar DELETE, "
                  "un comando que te permite eliminar atributos de una tabla. "
                  "Usaras DELETE para eliminar los tiburones con tus cañones.",
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
                    buttonColor: Colors.blue,
                  ),
                  CommonButton(
                    appState: appState,
                    minSize: minSize,
                    onPressed: appState.sharkPlay,
                    label: "¡Empezar!",
                    labelColor: Colors.white,
                    buttonColor: Colors.deepPurple,
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

class SharkIntroHorizontal extends StatelessWidget {
  const SharkIntroHorizontal({
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
        IntroBG(color: Colors.blueAccent,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: IslandBanner(
              minSize: minSize,
              maxSize: maxSize,
              isVertical: screenHeight > screenWidth,
              islandImage: "assets/png/sharkislandtransparent.png",
            )),
            Expanded(
              child: Column(
                children: [
                  TextScrollable(
                    minSize: minSize,
                    title: "¡Bienvenido a la Isla Tesoro!",
                    description: "En esta isla te enseñaremos a usar DELETE, "
                        "un comando que te permite eliminar atributos de una tabla. "
                        "Usaras DELETE para eliminar los tiburones con tus cañones.",
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
                          buttonColor: Colors.blue,
                        ),
                        CommonButton(
                          appState: appState,
                          minSize: minSize,
                          onPressed: appState.sharkPlay,
                          label: "¡Empezar!",
                          labelColor: Colors.white,
                          buttonColor: Colors.deepPurple,
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