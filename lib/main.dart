import 'package:find_best_route/pages/home.dart';
import 'package:find_best_route/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceUtil().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static Future<_MyAppState?> of(BuildContext context) async {
    return context.findAncestorStateOfType<_MyAppState>();
  }
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Locale _locale = const Locale('en');

  @override
  void initState() {
    super.initState();
    prepare();
  }

  Future<void> prepare() async {
    var languageCode = await SharedPreferenceUtil().getLanguageCode();
    _locale = Locale(languageCode);
    print('KhaiTQ-languageCode:$languageCode');
    print('KhaiTQ-locale:$_locale');
  }

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
      SharedPreferenceUtil().setLanguageCode(value.languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English, USA
        Locale('vi'), // Vietnamese, Vietname
      ],
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool _isVietnamese = false;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(_handleTabIndexChanged);
    prepare();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndexChanged);
    super.dispose();
  }

  Future<void> prepare() async {
    var languageCode = await SharedPreferenceUtil().getLanguageCode();
    setState(() {
      _isVietnamese = (languageCode == 'vi');
    });
    print('KhaiTQ-isVietnamese:$_isVietnamese');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Best Route'),
        bottom: TabBar(controller: _tabController, tabs: [
          Tab(
            text: AppLocalizations.of(context).home,
            icon: const Icon(Icons.home),
          ),
          Tab(
            text: AppLocalizations.of(context).tracking,
            icon: const Icon(Icons.track_changes),
          ),
          Tab(
            text: AppLocalizations.of(context).settings,
            icon: const Icon(Icons.settings),
          ),
        ]),
      ),
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            HomePage(),
            Center(child: Text(AppLocalizations.of(context).tracking)),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Ngôn ngữ tiếng việt'),
                  Switch(
                      value: _isVietnamese,
                      onChanged: (value) {
                        setState(() {
                          _isVietnamese = value;
                        });
                        MyApp.of(context).then((app) {
                          app!.setLocale(_isVietnamese
                              ? const Locale('vi')
                              : const Locale('en'));
                        });
                      })
                ],
              ),
            )
          ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _handleTabIndexChanged() {}
}
