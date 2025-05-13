{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "anton";
  home.homeDirectory = "/home/anton";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # nixpkgs.config.allowUnfree = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "obsidian"
      "discord"
    ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    pkgs.alejandra
    pkgs.bat
    pkgs.btop
    pkgs.cookiecutter
    # pkgs.discord
    pkgs.duf
    pkgs.dust
    pkgs.eza
    # pkgs.fd
    pkgs.fzf
    pkgs.go
    pkgs.go-task
    pkgs.htop
    pkgs.kanata
    # pkgs.lazydocker
    # pkgs.lazygit
    pkgs.neovim
    pkgs.nixd
    # pkgs.obsidian
    pkgs.oh-my-posh
    pkgs.poetry
    pkgs.ripgrep
    pkgs.rustup
    pkgs.stow
    pkgs.tldr
    # pkgs.tmux
    pkgs.vim
    pkgs.yazi-unwrapped
    pkgs.zoxide
  ];

  # programs.tmux = {
  #   enable = true;
  #   # Дополнительная конфигурация
  #   extraConfig = ''
  #     # Установка tmux plugin manager
  #     set -g @plugin 'tmux-plugins/tpm'

  #     # Добавьте свои плагины здесь
  #     set -g @plugin 'tmux-plugins/tmux-sensible'
  #     set -g @plugin 'tmux-plugins/tmux-yank'
  #     set -g @plugin 'janoamaral/tokyo-night-tmux'

  #     # Инициализация плагин менеджера
  #     run '~/.tmux/plugins/tpm/tpm'
  #   '';
  # };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # # My configuration
    # ".config/nvim".source = "${builtins.getEnv "HOME"}/dotfiles/nvim";
    ".zshrc".source = ../zshrc/.zshrc;
    ".vimrc".source = ../vimrc/.vimrc;
    # ".config/nvim".source = ../nvim;
    # ".config/nvim" = {
    #   source = ./nvim;
    #   recursive = true;
    # };
    ".config/kitty".source = ../kitty;
    ".config/ohmyposh".source = ../ohmyposh;
    ".config/nix".source = ../nix;
    ".config/tmux".source = ../tmux;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/anton/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
