import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal/providers/theme_provider.dart';
import 'package:meal/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class ThemesScreen extends StatelessWidget {
  static const String routeName = "Themes_Screen";

  Widget builRadioListTile({
    required ThemeMode themeMode,
    required String text,
    required IconData? icon,
    required BuildContext context,
  }) {
    return RadioListTile(
      value: themeMode,
      onChanged: (newThemeVal) => {
        Provider.of<ThemeProvider>(context, listen: false)
            .themeModeChanged(newThemeVal)
      },
      secondary: Icon(
        icon,
        color: Theme.of(context).buttonColor,
      ),
      title: Text("$text"),
      groupValue: Provider.of<ThemeProvider>(context).themeMode,
    );
  }

  ListTile buildListTile(BuildContext context, String text) {
    var primaryColor = Provider.of<ThemeProvider>(context).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context).accentColor;

    return ListTile(
        title: Text(
          "Choose your $text color",
          style: Theme.of(context).textTheme.headline6,
        ),
        trailing: CircleAvatar(
            backgroundColor: text == "primary" ? primaryColor : accentColor),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                elevation: 4,
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(0.0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: text == "primary"
                        ? Provider.of<ThemeProvider>(ctx).primaryColor
                        : Provider.of<ThemeProvider>(ctx).accentColor,
                    onColorChanged: (newColor) => {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .onChanged(newColor, text == "primary" ? 1 : 2),
                    },
                    colorPickerWidth: 300.0,
                    pickerAreaHeightPercent: 0.7,
                    enableAlpha: false,
                    displayThumbColor: true,
                    showLabel: false,
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Your Themes"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text("Adjust your theme selection"),
          ),
          Expanded(
              child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Choose your theme mode",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              builRadioListTile(
                  context: context,
                  themeMode: ThemeMode.system,
                  icon: null,
                  text: "System Theme"),
              builRadioListTile(
                  context: context,
                  themeMode: ThemeMode.light,
                  icon: Icons.wb_sunny_outlined,
                  text: "Light Theme"),
              builRadioListTile(
                  context: context,
                  themeMode: ThemeMode.dark,
                  icon: Icons.nights_stay_outlined,
                  text: "Dark Theme"),
              buildListTile(context, "primary"),
              buildListTile(context, "accent"),
            ],
          ))
        ],
      ),
    );
  }
}
