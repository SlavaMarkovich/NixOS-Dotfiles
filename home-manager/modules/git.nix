{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "SlavaMarkovich";
        email = "slavamarkovich@proton.me";
      };
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true; # Tells Git to use gh for authentication
  };
}
