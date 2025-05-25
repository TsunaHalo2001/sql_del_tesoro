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
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/png/mainbg.png"),
                fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/png/maintitle.png"),
                width: minSize,
                fit: BoxFit.cover,
              ),
              SizedBox(height: screenHeight * 0.2),
              IconButton(
                onPressed: () {
                  print(screenHeight);
                  print(screenWidth);
                },
                icon: Image(
                  image: AssetImage("assets/png/mainbutton.png"),
                  width: minSize * 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}