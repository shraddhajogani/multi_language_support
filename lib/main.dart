import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  runApp(EasyLocalization(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This Widget is the root of our App
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    // Get the data
    // EasyLocalizationProvider({Key key, Widget child, _EasyLocalizationState data })

    return EasyLocalizationProvider(
        data: data,
        child: MaterialApp(
          title: 'Flutter Multi-Language',
          theme: ThemeData(
            primarySwatch: Colors.yellow,
          ),
          home: MyHomePage(),
          localizationsDelegates: [   //This is the true Localization class from our app,and provide this resources to our app
            GlobalMaterialLocalizations.delegate,  // provides localized strings and other values for the Material Components library.
            GlobalWidgetsLocalizations.delegate, //  defines the default text direction, either left to right or right to left, for the widgets library
            // app-specific localization(eg.en - English, de - German (plus one country variation) )
            EasylocaLizationDelegate(    // EasylocaLizationDelegate({@required Locale locale, String path, String loadPath, bool useOnlyLangCode: false })
              // which provides material localizations for many languages. // The delegates collectively define all of the localized resources for this application's Localizations widget.
              locale: data.locale,
              path: 'assets', // path where our translated files are
            ),
          ],
          supportedLocales: [Locale('de', 'DE'), Locale('en', 'US')], // By default only the American English locale is supported. Apps should configure this list to match the locales they support. Locale.languageCode and Locale.countryCode only
          locale: data.savedLocale,
        ));
  }
}

// TO make our App visible
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              AppLocalizations.of(context).tr('title'), // Title of translated file
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Center(child: Text(AppLocalizations.of(context).tr('content'))), // display content from translated file
              RaisedButton(
                padding: EdgeInsets.all(10.0),
                color: Colors.yellow.shade600,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    data.changeLocale(Locale('en', 'US')); // It will change the language
                  });
                },
                child: Text(
                  AppLocalizations.of(context).tr('Übersetzen nach Englische'),
                ),
              ),
      RaisedButton(
        padding: EdgeInsets.all(10.0),
        color: Colors.yellow.shade600,
        textColor: Colors.white,
        onPressed: () {
          setState(() {
            data.changeLocale(Locale('de', 'DE'));
          });
        },
        child: Text(
          AppLocalizations.of(context).tr('Change it to Deutsch'),
        ),
      ),
            ],
          ),
        ),
      ),
    );
  }
}
