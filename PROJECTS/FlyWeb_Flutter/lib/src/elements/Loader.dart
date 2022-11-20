import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatefulWidget {
  String type;
  Color color;

  Loader({Key? key, this.type = "", this.color = Colors.white})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _Loader();
  }
}

class _Loader extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    String type = widget.type;
    Color color = widget.color;
    double size = 60.0;

    Widget loader;

    print("Type : ${type}");
    switch (type) {
      case "ContextLoader1":
        loader = Image.asset('assets/loaders/ContextLoader1.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader2":
        loader = Image.asset('assets/loaders/ContextLoader2.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader3":
        loader = Image.asset('assets/loaders/ContextLoader3.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader4":
        loader = Image.asset('assets/loaders/ContextLoader4.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader5":
        loader = Image.asset('assets/loaders/ContextLoader5.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader6":
        loader = Image.asset('assets/loaders/ContextLoader6.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader7":
        loader = Image.asset('assets/loaders/ContextLoader7.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader8":
        loader = Image.asset('assets/loaders/ContextLoader8.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader9":
        loader = Image.asset('assets/loaders/ContextLoader9.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader10":
        loader = Image.asset('assets/loaders/ContextLoader10.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader11":
        loader = Image.asset('assets/loaders/ContextLoader11.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader12":
        loader = Image.asset('assets/loaders/ContextLoader12.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader13":
        loader = Image.asset('assets/loaders/ContextLoader13.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader14":
        loader = Image.asset('assets/loaders/ContextLoader14.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader15":
        loader = Image.asset('assets/loaders/ContextLoader15.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader16":
        loader = Image.asset('assets/loaders/ContextLoader16.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader17":
        loader = Image.asset('assets/loaders/ContextLoader17.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "ContextLoader18":
        loader = Image.asset('assets/loaders/ContextLoader18.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);
        break;
      case "RotatingPlain":
        loader = SpinKitRotatingPlain(
          color: color,
          size: size,
        );
        break;
      case "ContextLoader":
        loader = Lottie.asset('assets/loaders/shimmer.json',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill);

        break;
      case "FadingFour":
        loader = SpinKitFadingFour(
          color: color,
          size: size,
        );
        break;

      case "FadingCube":
        loader = SpinKitFadingCube(
          color: color,
          size: size,
        );
        break;
      case "Pulse":
        loader = SpinKitPulse(
          color: color,
          size: size,
        );
        break;
      case "ChasingDots":
        loader = SpinKitChasingDots(
          color: color,
          size: size,
        );
        break;
      case "ThreeBounce":
        loader = SpinKitThreeBounce(
          color: color,
          size: size,
        );
        break;
      case "Circle":
        loader = SpinKitCircle(
          color: color,
          size: size,
        );
        break;
      case "CubeGrid":
        loader = SpinKitCubeGrid(
          color: color,
          size: size,
        );
        break;
      case "FadingCircle":
        loader = SpinKitFadingCircle(
          color: color,
          size: size,
        );
        break;
      case "FoldingCube":
        loader = SpinKitFoldingCube(
          color: color,
          size: size,
        );
        break;
      case "PumpingHeart":
        loader = SpinKitPumpingHeart(
          color: color,
          size: size,
        );
        break;
      case "DualRing":
        loader = SpinKitDualRing(
          color: color,
          size: size,
        );
        break;
      case "HourGlass":
        loader = SpinKitHourGlass(
          color: color,
          size: size,
        );
        break;
      case "FadingGrid":
        loader = SpinKitFadingGrid(
          color: color,
          size: size,
        );
        break;
      case "Ring":
        loader = SpinKitRing(
          color: color,
          size: size,
        );
        break;
      case "Ripple":
        loader = SpinKitRipple(
          color: color,
          size: size,
        );
        break;
      case "SpinningCircle":
        loader = SpinKitSpinningCircle(
          color: color,
          size: size,
        );
        break;
      case "SquareCircle":
        loader = SpinKitSquareCircle(
          color: color,
          size: size,
        );
        break;
      case "WanderingCubes":
        loader = SpinKitWanderingCubes(
          color: color,
          size: size,
        );
        break;
      case "Wave":
        loader = SpinKitWave(
          color: color,
          size: size,
        );
        break;
      case "DoubleBounce":
        loader = SpinKitDoubleBounce(
          color: color,
          size: size,
        );
        break;
      case "empty":
        loader = Container();
        break;
      default:
        loader = Container();
        break;
    }

    return loader;
  }
}
