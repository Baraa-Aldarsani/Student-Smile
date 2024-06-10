import 'package:flutter/material.dart';
import 'package:student_smile/core/core.dart';

ThemeData themeLight(BuildContext context) => ThemeData(
      useMaterial3: true,
      primaryColor: Palette.primary,
      scaffoldBackgroundColor: Palette.background,
      textTheme: TextTheme(
        displayLarge: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: Dimens.displayLarge,
              color: Palette.text,
            ),
        displayMedium: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: Dimens.displayMedium,
              color: Palette.text,
            ),
        displaySmall: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: Dimens.displaySmall,
              color: Palette.text,
            ),
        headlineMedium: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: Dimens.headlineMedium,
              color: Palette.text,
            ),
        headlineSmall: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: Dimens.headlineSmall,
              color: Palette.text,
            ),
        titleLarge: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: Dimens.titleLarge,
              color: Palette.text,
            ),
        titleMedium: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: Dimens.titleMedium,
              color: Palette.text,
            ),
        titleSmall: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: Dimens.titleSmall,
              color: Palette.text,
            ),
        bodyLarge: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: Dimens.bodyLarge,
              color: Palette.text,
            ),
        bodyMedium: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: Dimens.bodyMedium,
              color: Palette.text,
            ),
        bodySmall: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: Dimens.bodySmall,
              color: Palette.text,
            ),
        labelLarge: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: Dimens.labelLarge,
              color: Palette.text,
            ),
        labelSmall: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: Dimens.labelSmall,
              letterSpacing: 0.25,
              color: Palette.text,
            ),
      ),
      
      brightness: Brightness.light,
      iconTheme: const IconThemeData(color: Palette.primary),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      extensions:  const <ThemeExtension<dynamic>>[
        EXTColors(
          background: Palette.background,
          buttonText: Palette.primary,
          card: Palette.orgCard,
          subtitle: Palette.text,
          shadow: Palette.grey,
          red: Palette.red,
          black: Palette.black,
        ),
      ],
    );

class EXTColors extends ThemeExtension<EXTColors> {
  final Color? background;
  final Color? card;
  final Color? buttonText;
  final Color? subtitle;
  final Color? shadow;
  final Color? green;
  final Color? roseWater;
  final Color? flamingo;
  final Color? pink;
  final Color? mauve;
  final Color? maroon;
  final Color? peach;
  final Color? yellow;
  final Color? teal;
  final Color? sky;
  final Color? sapphire;
  final Color? blue;
  final Color? lavender;
  final Color? red;
  final Color? black;

  const EXTColors({
    this.background,
    this.card,
    this.buttonText,
    this.subtitle,
    this.shadow,
    this.green,
    this.roseWater,
    this.flamingo,
    this.pink,
    this.mauve,
    this.maroon,
    this.peach,
    this.yellow,
    this.teal,
    this.sapphire,
    this.sky,
    this.blue,
    this.lavender,
    this.red,
    this.black,
  });

  @override
  ThemeExtension<EXTColors> copyWith({
    Color? background,
    Color? card,
    Color? buttonText,
    Color? subtitle,
    Color? shadow,
    Color? green,
    Color? roseWater,
    Color? flamingo,
    Color? pink,
    Color? mauve,
    Color? maroon,
    Color? peach,
    Color? yellow,
    Color? teal,
    Color? sky,
    Color? sapphire,
    Color? blue,
    Color? lavender,
    Color? red,
    Color? black,
  }) {
    return EXTColors(
      background: background ?? this.background,
      card: card ?? this.card,
      buttonText: buttonText ?? this.buttonText,
      subtitle: subtitle ?? this.subtitle,
      shadow: shadow ?? this.shadow,
      green: green ?? this.green,
      roseWater: roseWater ?? this.roseWater,
      flamingo: flamingo ?? this.flamingo,
      pink: pink ?? this.pink,
      mauve: mauve ?? this.mauve,
      maroon: maroon ?? this.maroon,
      peach: peach ?? this.peach,
      yellow: yellow ?? this.yellow,
      teal: teal ?? this.teal,
      sky: sky ?? this.sky,
      sapphire: sapphire ?? this.sapphire,
      blue: blue ?? this.blue,
      lavender: lavender ?? this.lavender,
      red: red ?? this.red,
      black: black ?? this.black,
    );
  }

  @override
  ThemeExtension<EXTColors> lerp(
    covariant ThemeExtension<EXTColors>? other,
    double t,
  ) {
    if (other is! EXTColors) {
      return this;
    }
    return EXTColors(
      background: Color.lerp(background, other.background, t),
      card: Color.lerp(card, other.card, t),
      buttonText: Color.lerp(buttonText, other.buttonText, t),
      subtitle: Color.lerp(subtitle, other.subtitle, t),
      shadow: Color.lerp(shadow, other.shadow, t),
      green: Color.lerp(green, other.green, t),
      roseWater: Color.lerp(roseWater, other.roseWater, t),
      flamingo: Color.lerp(flamingo, other.flamingo, t),
      pink: Color.lerp(pink, other.pink, t),
      mauve: Color.lerp(mauve, other.mauve, t),
      maroon: Color.lerp(maroon, other.maroon, t),
      peach: Color.lerp(peach, other.peach, t),
      yellow: Color.lerp(yellow, other.yellow, t),
      teal: Color.lerp(teal, other.teal, t),
      sapphire: Color.lerp(sapphire, other.sapphire, t),
      blue: Color.lerp(blue, other.blue, t),
      lavender: Color.lerp(lavender, other.lavender, t),
      sky: Color.lerp(sky, other.sky, t),
      red: Color.lerp(red, other.red, t),
      black: Color.lerp(black, other.black, t),
    );
  }
}

class BoxDecorations {
  BoxDecorations(this.context);

  final BuildContext context;

  BoxDecoration get button => BoxDecoration(
        color: Palette.primary,
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimens.cornerRadius)),
        boxShadow: [BoxShadows(context).button],
      );

  BoxDecoration get card => BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimens.cornerRadius)),
        boxShadow: [BoxShadows(context).card],
      );
}

class BoxShadows {
  BoxShadows(this.context);

  final BuildContext context;

  BoxShadow get button => BoxShadow(
        color: Theme.of(context)
            .extension<EXTColors>()!
            .shadow!
            .withOpacity(0.5),
        blurRadius: 16.0,
        spreadRadius: 1.0,
      );

  BoxShadow get card => BoxShadow(
        color: Theme.of(context)
            .extension<EXTColors>()!
            .shadow!
            .withOpacity(0.5),
        blurRadius: 5.0,
        spreadRadius: 0.5,
      );

  BoxShadow get dialog => BoxShadow(
        color: Theme.of(context).extension<EXTColors>()!.shadow!,
        offset: const Offset(0, -4),
        blurRadius: 16.0,
      );

  BoxShadow get dialogAlt => BoxShadow(
        color: Theme.of(context).extension<EXTColors>()!.shadow!,
        offset: const Offset(0, 4),
        blurRadius: 16.0,
      );

  BoxShadow get buttonMenu => BoxShadow(
        color: Theme.of(context).extension<EXTColors>()!.shadow!,
        blurRadius: 4.0,
      );
}
