{ ... }:
{
  vim.spellcheck = {
    # Temporary disabled, waiting for dirty talk fix
    # https://github.com/psliwka/vim-dirtytalk/issues/46
    enable = false;
    languages = [
      "en"
    ];
    programmingWordlist.enable = false;
  };
}
