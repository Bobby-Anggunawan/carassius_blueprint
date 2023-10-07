import "package:flutter/material.dart";

enum _ErrorType{
  Forbidden,
  NotFound,
  NotImplemented,
  ImATeapot,
  Error
}

class KoiPageError extends StatelessWidget {

  KoiPageError.Forbidden({Key? key, this.errorType = _ErrorType.Forbidden}) : super(key: key);
  KoiPageError.NotFound({Key? key, this.errorType = _ErrorType.NotFound}) : super(key: key);
  KoiPageError.NotImplemented({Key? key, this.errorType = _ErrorType.NotImplemented}) : super(key: key);
  KoiPageError.ImATeapot({Key? key, this.errorType = _ErrorType.ImATeapot}) : super(key: key);
  KoiPageError.Error({Key? key, this.errorType = _ErrorType.Error}) : super(key: key);

  final _ErrorType errorType;

  @override
  Widget build(BuildContext context) {

    // APRIL MOP!!!
    if(DateTime.now().month == 4 && DateTime.now().day == 1){
      return _ErrorImATeapot();
    }

    else if(errorType == _ErrorType.Forbidden){
      return _ErrorForbidden();
    }
    else if(errorType == _ErrorType.NotFound){
      return _ErrorNotFound();
    }
    else if(errorType == _ErrorType.NotImplemented){
      return _ErrorNotImplemented();
    }
    else if(errorType == _ErrorType.ImATeapot){
      return _ErrorImATeapot();
    }
    else if(errorType == _ErrorType.Error){
      return _Error();
    }

    throw RangeError("KoiPageError: errorType tidak dikenali");
  }
}

class _ErrorForbidden extends StatelessWidget {
  const _ErrorForbidden({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Error 403: Forbidden"),
      ),
    );
  }
}

class _ErrorNotFound extends StatelessWidget {
  const _ErrorNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Error 404: Not Found"),
      ),
    );
  }
}

class _ErrorNotImplemented extends StatelessWidget {
  const _ErrorNotImplemented({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Error 501: Not Implemented"),
      ),
    );
  }
}

class _ErrorImATeapot extends StatelessWidget {
  const _ErrorImATeapot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Error 418: Don't mind me.. I'm a teapot."),
      ),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Error 500: Internal Server Error"),
      ),
    );
  }
}
