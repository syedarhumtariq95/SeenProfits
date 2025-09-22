class CustomImagesPath {
  CustomImagesPath._();

  ///Folders
  final String folderAssets = 'assets';
  final String folderImages = 'images';
  final String folderHome = 'home';
  final String folderLogo = 'logo';
  final String folderOnboarding = 'onboarding';

  ///IconNames
  final String logo = 'logo.png';
  final String onboarding = 'onboarding.png';

  ///Getters for custom images
  String get logoImagePath => '$folderAssets/$folderLogo/$logo';

  String get onboardingImagePath =>
      '$folderAssets/$folderImages/$folderOnboarding/$onboarding';
}
