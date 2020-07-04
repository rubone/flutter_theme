import 'package:flutter/material.dart';
import 'package:fluttertheme/models/theme_preferences.dart';
import 'package:fluttertheme/providers/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  MyApp({ Key key}) : super (key : key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  ThemeProvider themeChangeProvider = new ThemeProvider();

  @override
  void initState(){
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.setTheme = await themeChangeProvider
        .themePreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: themeChangeProvider,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Theme',
          home: MyHomePage(title: 'Flutter Theme'),
        ),
    );
  }
}


class MyHomePage extends StatefulWidget{
  MyHomePage({ Key key, this.title}) : super (key : key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{


  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: currentTheme.theme == ThemePreferences.DARK
        ? Color(0xff2a293d)
        : Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: currentTheme.theme == ThemePreferences.DARK
        ? Colors.black12
        : Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Toca para cambiar el tema',
              style: TextStyle(
                color: currentTheme.isDarkTheme ()
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(
                  Icons.wb_sunny,
                  color: currentTheme.isDarkTheme ()
                    ? Colors.white
                    : Colors.black,
                ),
                Switch (
                  value: currentTheme.isDarkTheme (),
                  onChanged: (value) {
                    String newTheme = value ? ThemePreferences.DARK : ThemePreferences.LIGHT;
                    currentTheme.setTheme = newTheme;
                  },
                ),
                Icon(
                  Icons.brightness_2,
                  color: currentTheme.theme == ThemePreferences.DARK
                      ? Colors.white
                      : Colors.black,
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
