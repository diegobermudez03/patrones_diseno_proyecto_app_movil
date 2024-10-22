import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4281557389),
      surfaceTint: Color(4281557389),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4291880191),
      onPrimaryContainer: Color(4278197557),
      secondary: Color(4283588720),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292273399),
      onSecondaryContainer: Color(4279180586),
      tertiary: Color(4285159289),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294040575),
      onTertiaryContainer: Color(4280554802),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294507007),
      onSurface: Color(4279835680),
      onSurfaceVariant: Color(4282533710),
      outline: Color(4285757311),
      outlineVariant: Color(4290955215),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281151797),
      inversePrimary: Color(4288596732),
      primaryFixed: Color(4291880191),
      onPrimaryFixed: Color(4278197557),
      primaryFixedDim: Color(4288596732),
      onPrimaryFixedVariant: Color(4279585140),
      secondaryFixed: Color(4292273399),
      onSecondaryFixed: Color(4279180586),
      secondaryFixedDim: Color(4290431195),
      onSecondaryFixedVariant: Color(4282075223),
      tertiaryFixed: Color(4294040575),
      onTertiaryFixed: Color(4280554802),
      tertiaryFixedDim: Color(4292198117),
      onTertiaryFixedVariant: Color(4283514976),
      surfaceDim: Color(4292401888),
      surfaceBright: Color(4294507007),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112249),
      surfaceContainer: Color(4293717748),
      surfaceContainerHigh: Color(4293322990),
      surfaceContainerHighest: Color(4292928232),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4279190896),
      surfaceTint: Color(4281557389),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283136165),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281812051),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285036167),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4283251804),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4286672272),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294507007),
      onSurface: Color(4279835680),
      onSurfaceVariant: Color(4282270538),
      outline: Color(4284178279),
      outlineVariant: Color(4285954946),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281151797),
      inversePrimary: Color(4288596732),
      primaryFixed: Color(4283136165),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281360267),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285036167),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283456877),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4286672272),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4284962166),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292401888),
      surfaceBright: Color(4294507007),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112249),
      surfaceContainer: Color(4293717748),
      surfaceContainerHigh: Color(4293322990),
      surfaceContainerHighest: Color(4292928232),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278199359),
      surfaceTint: Color(4281557389),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4279190896),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279640881),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281812051),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281015097),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283251804),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294507007),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280230954),
      outline: Color(4282270538),
      outlineVariant: Color(4282270538),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281151797),
      inversePrimary: Color(4292996607),
      primaryFixed: Color(4279190896),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278202192),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281812051),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280364604),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283251804),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281738820),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292401888),
      surfaceBright: Color(4294507007),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112249),
      surfaceContainer: Color(4293717748),
      surfaceContainerHigh: Color(4293322990),
      surfaceContainerHighest: Color(4292928232),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4288596732),
      surfaceTint: Color(4288596732),
      onPrimary: Color(4278202966),
      primaryContainer: Color(4279585140),
      onPrimaryContainer: Color(4291880191),
      secondary: Color(4290431195),
      onSecondary: Color(4280561984),
      secondaryContainer: Color(4282075223),
      onSecondaryContainer: Color(4292273399),
      tertiary: Color(4292198117),
      onTertiary: Color(4282001992),
      tertiaryContainer: Color(4283514976),
      onTertiaryContainer: Color(4294040575),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279243800),
      onSurface: Color(4292928232),
      onSurfaceVariant: Color(4290955215),
      outline: Color(4287402393),
      outlineVariant: Color(4282533710),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292928232),
      inversePrimary: Color(4281557389),
      primaryFixed: Color(4291880191),
      onPrimaryFixed: Color(4278197557),
      primaryFixedDim: Color(4288596732),
      onPrimaryFixedVariant: Color(4279585140),
      secondaryFixed: Color(4292273399),
      onSecondaryFixed: Color(4279180586),
      secondaryFixedDim: Color(4290431195),
      onSecondaryFixedVariant: Color(4282075223),
      tertiaryFixed: Color(4294040575),
      onTertiaryFixed: Color(4280554802),
      tertiaryFixedDim: Color(4292198117),
      onTertiaryFixedVariant: Color(4283514976),
      surfaceDim: Color(4279243800),
      surfaceBright: Color(4281743678),
      surfaceContainerLowest: Color(4278914578),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280756783),
      surfaceContainerHighest: Color(4281480506),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4288990975),
      surfaceTint: Color(4288596732),
      onPrimary: Color(4278196012),
      primaryContainer: Color(4285043907),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290694367),
      onSecondary: Color(4278785829),
      secondaryContainer: Color(4286878372),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4292461290),
      onTertiary: Color(4280225580),
      tertiaryContainer: Color(4288580013),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279243800),
      onSurface: Color(4294638335),
      onSurfaceVariant: Color(4291283923),
      outline: Color(4288652203),
      outlineVariant: Color(4286546827),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292928232),
      inversePrimary: Color(4279716725),
      primaryFixed: Color(4291880191),
      onPrimaryFixed: Color(4278194724),
      primaryFixedDim: Color(4288596732),
      onPrimaryFixedVariant: Color(4278204511),
      secondaryFixed: Color(4292273399),
      onSecondaryFixed: Color(4278522400),
      secondaryFixedDim: Color(4290431195),
      onSecondaryFixedVariant: Color(4280956742),
      tertiaryFixed: Color(4294040575),
      onTertiaryFixed: Color(4279831079),
      tertiaryFixedDim: Color(4292198117),
      onTertiaryFixedVariant: Color(4282396494),
      surfaceDim: Color(4279243800),
      surfaceBright: Color(4281743678),
      surfaceContainerLowest: Color(4278914578),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280756783),
      surfaceContainerHighest: Color(4281480506),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294638335),
      surfaceTint: Color(4288596732),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4288990975),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294638335),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290694367),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965755),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4292461290),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279243800),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294638335),
      outline: Color(4291283923),
      outlineVariant: Color(4291283923),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292928232),
      inversePrimary: Color(4278201420),
      primaryFixed: Color(4292405503),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4288990975),
      onPrimaryFixedVariant: Color(4278196012),
      secondaryFixed: Color(4292536572),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290694367),
      onSecondaryFixedVariant: Color(4278785829),
      tertiaryFixed: Color(4294238463),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4292461290),
      onTertiaryFixedVariant: Color(4280225580),
      surfaceDim: Color(4279243800),
      surfaceBright: Color(4281743678),
      surfaceContainerLowest: Color(4278914578),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280756783),
      surfaceContainerHighest: Color(4281480506),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
