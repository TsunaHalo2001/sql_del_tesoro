part of 'main.dart';

class TreasureIsland extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double minSize = screenWidth < screenHeight ? screenWidth : screenHeight;
    double maxSize = screenWidth > screenHeight ? screenWidth : screenHeight;

    if (screenHeight > screenWidth) {
      return TreasureIslandVertical(appState: appState, minSize: minSize);
    }
    else {
      return TreasureIslandHorizontal(appState: appState, minSize: minSize);
    }
  }
}

class TreasureIslandVertical extends StatelessWidget {
  const TreasureIslandVertical({
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
        IntroBG(color: Colors.limeAccent),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: minSize,
                    height: minSize * 0.33,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/png/shop.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: minSize * 0.4,
                    height: minSize * 0.33,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/webp/seller.webp"),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: minSize * 0.15,
                          ),
                          TextWithShadow(
                            minSize: minSize,
                            labelText: "Cañones",
                            textColor: Colors.white,
                            shadowColor: Colors.black,
                          ),
                          TextWithShadow(
                            minSize: minSize,
                            labelText: appState.cannons.toString(),
                            textColor: Colors.white,
                            shadowColor: Colors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TextScrollable(
              minSize: minSize,
              title: "Nombre - Tesoros",
              description: appState.printTreasures(),
            ),
            TextWithShadow(
              minSize: minSize * 0.8,
              labelText: "UPDATE records SET cañones = <cantidad> WHERE id = 1;",
              textColor: Colors.amber,
              shadowColor: Colors.black
            ),
            Form(
              child: Padding(
                padding: EdgeInsets.all(minSize * 0.05),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Escribe el nombre del tesoro",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    appState.actualTreasure = value;
                  },
                ),
              ),
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
                    onPressed: () {appState.purchaseCannon(appState.actualTreasure);},
                    label: "Comprar",
                    labelColor: Colors.white,
                    buttonColor: Colors.black
                  ),
                ]
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TreasureIslandHorizontal extends StatelessWidget {
  const TreasureIslandHorizontal({
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
        IntroBG(color: Colors.limeAccent),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    fit: StackFit.loose,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: minSize * 1.1,
                        height: minSize * 0.5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/png/shop.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: minSize * 0.33,
                        height: minSize * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/webp/seller.webp"),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: minSize * 0.8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextWithShadow(
                                minSize: minSize,
                                labelText: "Cañones",
                                textColor: Colors.white,
                                shadowColor: Colors.black,
                              ),
                              TextWithShadow(
                                minSize: minSize,
                                labelText: appState.cannons.toString(),
                                textColor: Colors.white,
                                shadowColor: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: minSize * 0.8,
                    child: TextWithShadow(
                      minSize: minSize * 0.7,
                      labelText: '''UPDATE records SET cañones = <cantidad> WHERE id = 1;''',
                      textColor: Colors.amber,
                      shadowColor: Colors.black
                    ),
                  ),
                  SizedBox(
                    width: minSize * 0.8,
                    height: minSize * 0.2,
                    child: Form(
                      child: Padding(
                        padding: EdgeInsets.all(minSize * 0.05),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Escribe el nombre del tesoro",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            appState.actualTreasure = value;
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: minSize,
                    height: minSize * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          onPressed: () {appState.purchaseCannon(appState.actualTreasure);},
                          label: "Comprar",
                          labelColor: Colors.white,
                          buttonColor: Colors.black
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            TextScrollable(
              minSize: minSize,
              title: "Nombre - Tesoros",
              description: appState.printTreasures(),
            ),
          ],
        ),
      ],
    );
  }
}