part of 'main.dart';

class TurtleIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double minSize = screenWidth < screenHeight ? screenWidth : screenHeight;
    double maxSize = screenWidth > screenHeight ? screenWidth : screenHeight;

    if (screenHeight > screenWidth) {
      return TurtleIntroVertical(
        minSize: minSize,
        maxSize: maxSize,
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        appState: appState,
      );
    } else {
      return TurtleIntroHorizontal(
        minSize: minSize,
        maxSize: maxSize,
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        appState: appState,
      );
    }
  }
}

class TurtleIntroVertical extends StatelessWidget {
  const TurtleIntroVertical({
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
        IntroBG(color: Colors.lightGreenAccent,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IslandBanner(minSize: minSize, maxSize: maxSize, isVertical: screenHeight > screenWidth),
            TextScrollable(
              minSize: minSize,
              title: "¡Bienvenido a la Isla Tortuga!",
              description: "Aquí empieza tu viaje a traves de SQL y las bases de datos. "
                  "En esta isla te enseñaremos a usar SELECT y WHERE, "
                  "un comando que te permite elegir atributos de una tabla. "
                  "Con SELECT podras escoger cual columna de una tabla quieres ver, "
                  "y con WHERE podras filtrar los resultados segun tus necesidades. "
                  "Usaras SELECT para elegir el monton de tortugas que quieres, "
                  "y WHERE para sacar el tesoro de entre el monton."
                  "Preparate para buscar tesoros escondidos.",
            ),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  CommonButton(
                    appState: appState,
                    minSize: minSize,
                    onPressed: appState.mainPlay,
                    label: "Volver al mapa",
                    labelColor: Colors.white,
                    buttonColor: Colors.blue,
                  ),
                  Spacer(),
                  CommonButton(
                    appState: appState,
                    minSize: minSize,
                    onPressed: appState.turtlePlay,
                    label: "¡Empezar!",
                    labelColor: Colors.white,
                    buttonColor: Colors.green,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TurtleIntroHorizontal extends StatelessWidget {
  const TurtleIntroHorizontal({
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
        IntroBG(color: Colors.lightGreenAccent,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: IslandBanner(minSize: minSize, maxSize: maxSize, isVertical: screenHeight > screenWidth)),
            Expanded(
              child: Column(
                children: [
                  TextScrollable(
                    minSize: minSize,
                    title: "¡Bienvenido a la Isla Tortuga!",
                    description: "Aquí empieza tu viaje a traves de SQL y las bases de datos. "
                        "En esta isla te enseñaremos a usar SELECT y WHERE, "
                        "un comando que te permite elegir atributos de una tabla. "
                        "Con SELECT podras escoger cual columna de una tabla quieres ver, "
                        "y con WHERE podras filtrar los resultados segun tus necesidades. "
                        "Usaras SELECT para elegir el monton de tortugas que quieres, "
                        "y WHERE para sacar el tesoro de entre el monton."
                        "Preparate para buscar tesoros escondidos.",
                  ),
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        CommonButton(
                          appState: appState,
                          minSize: minSize,
                          onPressed: appState.mainPlay,
                          label: "Volver al mapa",
                          labelColor: Colors.white,
                          buttonColor: Colors.blue,
                        ),
                        Spacer(),
                        CommonButton(
                          appState: appState,
                          minSize: minSize,
                          onPressed: appState.turtlePlay,
                          label: "¡Empezar!",
                          labelColor: Colors.white,
                          buttonColor: Colors.green,
                        ),
                        Spacer(),
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

class IslandBanner extends StatelessWidget {
  const IslandBanner({
    super.key,
    required this.minSize,
    required this.maxSize,
    required this.isVertical,
  });

  final double minSize;
  final double maxSize;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return SafeArea(
        child: Container(
          decoration:
          BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/png/turtleisland.png"),
              fit: BoxFit.cover,
            ),
          ),
          height: minSize * 0.3,
        ),
      );
    }
    else {
      return SafeArea(
        child: Container(
          decoration:
          BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/png/turtleisland.png"),
              fit: BoxFit.cover,
            ),
          ),
          width: maxSize * 0.5,
        ),
      );
    }
  }
}

class TextScrollable extends StatelessWidget {
  const TextScrollable({
    super.key,
    required this.minSize,
    required this.title,
    required this.description,
  });

  final double minSize;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(minSize * 0.05),
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: minSize * 0.1,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: minSize * 0.05),
          Text(
            description,
            style: TextStyle(
              fontSize: minSize * 0.07,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.appState,
    required this.minSize,
    required this.onPressed,
    required this.label,
    required this.labelColor,
    required this.buttonColor,
  });

  final MyAppState appState;
  final double minSize;
  final VoidCallback onPressed;
  final String label;
  final Color labelColor;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: minSize * 0.1, vertical: minSize * 0.02),
        backgroundColor: buttonColor,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: minSize * 0.05,
          color: labelColor,
        ),
      ),
    );
  }
}

class IntroBG extends StatelessWidget {
  const IntroBG({
    super.key,

    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }
}