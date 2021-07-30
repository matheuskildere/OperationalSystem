enum Flavor { dev, prod }

Flavor? appFlavor;

extension FlavoreExt on Flavor {
  String get title {
    switch (this) {
      case Flavor.prod:
        return 'Production';
      case Flavor.dev:
      default:
        return 'Develop';
    }
  }

  bool get isDev => this == Flavor.dev;
  bool get isProd => this == Flavor.prod;
}
