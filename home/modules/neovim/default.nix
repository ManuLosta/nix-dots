{...}: {
  imports = [
    ./plugins/telescope.nix
  ];

  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
    withRuby = true;

    colorschemes.gruvbox.enable = true;

    plugins = {
      lualine.enable = true;
      neo-tree.enable = true;
    };

    plugins.lsp = {
      enable = true;
      servers = {
        tsserver.enable = true;
        lua-ls.enable = true;
      };
    };

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings.sources = [
        {name = "nvim_lsp";}
        {name = "path";}
        {name = "buffer";}
      ];
    };
  };
}
