{ ... }:
{
  vim.spellcheck = {
    enable = true;
    languages = [
      "en"
    ];
    # Temporary disabled, waiting for dirty talk fix
    # https://github.com/psliwka/vim-dirtytalk/issues/46
    # programmingWordlist.enable = false;
  };
}
