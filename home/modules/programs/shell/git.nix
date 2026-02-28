{ ... }:

{
  programs.git = {
    settings = {
      user.name = "kbnopro";
      user.email = "tuankhanhb00@gmail.com";
    };
    ignores = [
      ".envrc"
    ];
  };
}
