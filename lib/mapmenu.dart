part of 'main.dart';

class MapMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double minSize = screenWidth < screenHeight ? screenWidth : screenHeight;
    double maxSize = screenWidth > screenHeight ? screenWidth : screenHeight;

    if (screenHeight > screenWidth) return MapMenuVertical(minSize: minSize, maxSize: maxSize);
    else return MapMenuHorizontal(minSize: minSize, maxSize: maxSize);
  }
}

class MapMenuVertical extends StatelessWidget {
  const MapMenuVertical({
    super.key,
    required this.minSize,
    required this.maxSize,
  });

  final double minSize;
  final double maxSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MapBG(),
        Center(
          child: Column(
            children: [
              Spacer(),
              MapIsland(
                minSize: minSize,
                maxSize: maxSize,
                islandImage: "assets/png/turtleislandtransparent.png",
                islandName: "Turtle Island",
                islandColor: Colors.green,
              ),
              Row(
                children: [
                  MapIsland(
                    minSize: minSize,
                    maxSize: maxSize,
                    islandImage: "assets/png/treasureislandtransparent.png",
                    islandName: "Treasure Island",
                    islandColor: Colors.amber,
                  ),
                  Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  MapIsland(
                    maxSize: maxSize,
                    minSize: minSize,
                    islandImage: "assets/png/sharkislandtransparent.png",
                    islandName: "Shark Island",
                    islandColor: Colors.deepPurple,
                  ),
                  Spacer(),
                  MapIsland(
                    maxSize: maxSize,
                    minSize: minSize,
                    islandImage: "assets/png/ghostislandtransparent.png",
                    islandName: "Ghost Island",
                    islandColor: Colors.grey,
                  ),
                ],
              ),
              MapIsland(
                maxSize: maxSize,
                minSize: minSize,
                islandImage: "assets/png/skullislandtransparent.png",
                islandName: "Skull Island",
                islandColor: Colors.deepOrange,
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class MapMenuHorizontal extends StatelessWidget {
  const MapMenuHorizontal({
    super.key,
    required this.minSize,
    required this.maxSize,
  });

  final double minSize;
  final double maxSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MapBG(),
        Center(
          child: Row(
            children: [
              Spacer(),
              MapIsland(
                minSize: minSize,
                maxSize: maxSize,
                islandImage: "assets/png/turtleislandtransparent.png",
                islandName: "Turtle Island",
                islandColor: Colors.green,
              ),
              Spacer(),
              Column(
                children: [
                  MapIsland(
                    minSize: minSize,
                    maxSize: maxSize,
                    islandImage: "assets/png/treasureislandtransparent.png",
                    islandName: "Treasure Island",
                    islandColor: Colors.amber,
                  ),
                  Spacer(),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Spacer(),
                  MapIsland(
                    maxSize: maxSize,
                    minSize: minSize,
                    islandImage: "assets/png/sharkislandtransparent.png",
                    islandName: "Shark Island",
                    islandColor: Colors.deepPurple,
                  ),
                  Spacer(),
                  MapIsland(
                    maxSize: maxSize,
                    minSize: minSize,
                    islandImage: "assets/png/ghostislandtransparent.png",
                    islandName: "Ghost Island",
                    islandColor: Colors.grey,
                  ),
                ],
              ),
              Spacer(),
              MapIsland(
                maxSize: maxSize,
                minSize: minSize,
                islandImage: "assets/png/skullislandtransparent.png",
                islandName: "Skull Island",
                islandColor: Colors.deepOrange,
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class MapIsland extends StatelessWidget {
  const MapIsland({
    super.key,
    required this.maxSize,
    required this.minSize,
    required this.islandImage,
    required this.islandName,
    required this.islandColor,
  });

  final double maxSize;
  final double minSize;
  final String islandImage;
  final String islandName;
  final Color islandColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: (){
          },
          icon: Image(
            image: AssetImage(islandImage),
            width: maxSize * 0.15,
          ),
        ),
        TextWithShadow(
          minSize: minSize,
          labelText: islandName,
          textColor: islandColor,
          shadowColor: Colors.black54,
        ),
      ],
    );
  }
}

class TextWithShadow extends StatelessWidget {
  const TextWithShadow({
    super.key,
    required this.minSize,
    required this.labelText,
    required this.textColor,
    required this.shadowColor,
  });

  final double minSize;
  final String labelText;
  final Color textColor;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: minSize * 0.07,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = minSize * 0.01
              ..color = shadowColor,
          ),
        ),
        Text(
          labelText,
          style: TextStyle(
            fontSize: minSize * 0.07,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }
}

class MapBG extends StatelessWidget {
  const MapBG({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/gif/sea.gif"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}