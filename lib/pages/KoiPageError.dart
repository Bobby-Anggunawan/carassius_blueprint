import "package:carassius_blueprint/carassius_blueprint.dart";
import "package:flutter/material.dart";

enum _ErrorType{
  Forbidden,
  NotFound,
  NotImplemented,
  ImATeapot,
  Error
}

class KoiPageError extends StatelessWidget {

  KoiPageError.Forbidden({Key? key, this.message, this.resolution}) : errorType = _ErrorType.Forbidden, super(key: key);
  KoiPageError.NotFound({Key? key, this.message, this.resolution}) : errorType = _ErrorType.NotFound, super(key: key);
  KoiPageError.NotImplemented({Key? key, this.message, this.resolution}) : errorType = _ErrorType.NotImplemented, super(key: key);
  KoiPageError.ImATeapot({Key? key, this.message, this.resolution}) : errorType = _ErrorType.ImATeapot, super(key: key);
  KoiPageError.Error({Key? key, this.message, this.resolution}) : errorType = _ErrorType.Error, super(key: key);

  final _ErrorType errorType;

  /// pesan yang ditampilkan
  final String? message;


  /// widget yang diletakkan dibawah pesan. Dapat berupa petunjuk cara mengatasi error ini
  final Widget? resolution;

  @override
  Widget build(BuildContext context) {

    // APRIL MOP!!!
    if(DateTime.now().month == 4 && DateTime.now().day == 1){
      return _ErrorImATeapot(message: message, resolution: resolution);
    }

    else if(errorType == _ErrorType.Forbidden){
      return _ErrorForbidden(message: message, resolution: resolution);
    }
    else if(errorType == _ErrorType.NotFound){
      return _ErrorNotFound(message: message, resolution: resolution);
    }
    else if(errorType == _ErrorType.NotImplemented){
      return _ErrorNotImplemented(message: message, resolution: resolution);
    }
    else if(errorType == _ErrorType.ImATeapot){
      return _ErrorImATeapot(message: message, resolution: resolution);
    }
    else if(errorType == _ErrorType.Error){
      return _Error(message: message, resolution: resolution);
    }

    throw RangeError("KoiPageError: errorType tidak dikenali");
  }
}

class _ErrorForbidden extends StatelessWidget {
  const _ErrorForbidden({Key? key, required this.message, required this.resolution}) : super(key: key);

  final String? message;
  final Widget? resolution;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(context.koiSpacing.autoFromScreenEdge),
        child: Center(
          child: SingleChildScrollView(
            child: Flex(
              direction: Axis.vertical,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Error 403: Forbidden",
                  style: context.koiThemeText.display(size: TextStyleSize.Large),
                ),

                Builder(builder: (context){
                  if(message != null){
                    return Text(
                      message!,
                      style: context.koiThemeText.display(size: TextStyleSize.Small),
                    );
                  }
                  return Container();
                }),
                
                resolution
              ].koiRemoveNull<Widget>().koiAddBetweenElement(
                SizedBox(width: context.koiSpacing.autoBeetweenPane,)
              ),
            ),
          ),
        ),
      )
    );
  }
}

class _ErrorNotFound extends StatelessWidget {
  const _ErrorNotFound({Key? key, required this.message, required this.resolution}) : super(key: key);

  final String? message;
  final Widget? resolution;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(context.koiSpacing.autoFromScreenEdge),
          child: Center(
            child: SingleChildScrollView(
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Error 404: Not Found",
                    style: context.koiThemeText.display(size: TextStyleSize.Large),
                  ),

                  Builder(builder: (context){
                    if(message != null){
                      return Text(
                        message!,
                        style: context.koiThemeText.display(size: TextStyleSize.Small),
                      );
                    }
                    return Container();
                  }),

                  resolution
                ].koiRemoveNull<Widget>().koiAddBetweenElement(
                    SizedBox(width: context.koiSpacing.autoBeetweenPane,)
                ),
              ),
            ),
          ),
        )
    );
  }
}

class _ErrorNotImplemented extends StatelessWidget {
  const _ErrorNotImplemented({Key? key, required this.message, required this.resolution}) : super(key: key);

  final String? message;
  final Widget? resolution;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(context.koiSpacing.autoFromScreenEdge),
          child: Center(
            child: SingleChildScrollView(
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Error 501: Not Implemented",
                    style: context.koiThemeText.display(size: TextStyleSize.Large),
                  ),

                  Builder(builder: (context){
                    if(message != null){
                      return Text(
                        message!,
                        style: context.koiThemeText.display(size: TextStyleSize.Small),
                      );
                    }
                    return Container();
                  }),

                  resolution
                ].koiRemoveNull<Widget>().koiAddBetweenElement(
                    SizedBox(width: context.koiSpacing.autoBeetweenPane,)
                ),
              ),
            ),
          ),
        )
    );
  }
}

class _ErrorImATeapot extends StatelessWidget {
  const _ErrorImATeapot({Key? key, required this.message, required this.resolution}) : super(key: key);

  final String? message;
  final Widget? resolution;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(context.koiSpacing.autoFromScreenEdge),
          child: Center(
            child: SingleChildScrollView(
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Error 418: Don't mind me.. I'm a teapot.",
                    style: context.koiThemeText.display(size: TextStyleSize.Large),
                  ),

                  Builder(builder: (context){
                    if(message != null){
                      return Text(
                        message!,
                        style: context.koiThemeText.display(size: TextStyleSize.Small),
                      );
                    }
                    return Container();
                  }),

                  resolution
                ].koiRemoveNull<Widget>().koiAddBetweenElement(
                    SizedBox(width: context.koiSpacing.autoBeetweenPane,)
                ),
              ),
            ),
          ),
        )
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({Key? key, required this.message, required this.resolution}) : super(key: key);

  final String? message;
  final Widget? resolution;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(context.koiSpacing.autoFromScreenEdge),
          child: Center(
            child: SingleChildScrollView(
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Error!!",
                    style: context.koiThemeText.display(size: TextStyleSize.Large),
                  ),

                  Builder(builder: (context){
                    if(message != null){
                      return Text(
                        message!,
                        style: context.koiThemeText.display(size: TextStyleSize.Small),
                      );
                    }
                    return Container();
                  }),

                  resolution
                ].koiRemoveNull<Widget>().koiAddBetweenElement(
                    SizedBox(width: context.koiSpacing.autoBeetweenPane,)
                ),
              ),
            ),
          ),
        )
    );
  }
}
