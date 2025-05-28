part of 'main.dart';

class StartMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double minSize = screenWidth < screenHeight ? screenWidth : screenHeight;

    return Stack(
      children: [
        MainBG(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainTitle(minSize: minSize * 0.8),
              SizedBox(height: screenHeight * 0.2),
              MainButton(appState: appState, minSize: minSize),
            ],
          ),
        ),
        /*Expanded(
          child: LottieBuilder(
            lottie: AssetLottie("assets/json/mainpalm.json"),
            height: minSize,
            width: minSize,
            fit: BoxFit.none,
          ),
        ),*/
      ],
    );
  }
}

class MainBG extends StatelessWidget {
  const MainBG({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/png/mainbg.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MainTitle extends StatelessWidget {
  const MainTitle({
    super.key,
    required this.minSize,
  });

  final double minSize;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage("assets/png/maintitle.png"),
      width: minSize,
      fit: BoxFit.cover,
    );
  }
}

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.appState,
    required this.minSize,
  });

  final MyAppState appState;
  final double minSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        appState.mainPlay();
      },
      icon: Image(
        image: AssetImage("assets/png/mainbutton.png"),
        width: minSize * 0.5,
      ),
    );
  }
}