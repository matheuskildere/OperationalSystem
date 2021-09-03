enum Flavor { dev, stage, prod }

Flavor? appFlavor;

extension FlavoreExt on Flavor {
  String get title {
    switch (this) {
      case Flavor.prod:
        return 'Production';
      case Flavor.stage:
        return 'Stage';
      case Flavor.dev:
      default:
        return 'Develop';
    }
  }

  bool get isDev => this == Flavor.dev;
  bool get isProd => this == Flavor.prod;
  bool get isStage => this == Flavor.stage;
}
