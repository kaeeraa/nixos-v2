{
  pkgs,
  settings,
  ...
}: {
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "ru_RU.UTF-8";

  services.xserver.xkb = {
    layout = settings.xkb.layout;
    variant = settings.xkb.variant;
    options = settings.xkb.options;
  };

  console = {
    useXkbConfig = true;
    font = "ter-v16n";
    packages = [pkgs.terminus_font];
  };
}
