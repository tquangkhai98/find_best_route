import 'package:find_best_route/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../my_app.dart';
import '../util/shared_preferences_util.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isVietnamese = false;

  @override
  void initState() {
    super.initState();
    prepare();
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
      appBar: AppBar(title: Text(AppLocalizations.of(context).settings)),
      body: Center(
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
      ),
    );
  }
}
