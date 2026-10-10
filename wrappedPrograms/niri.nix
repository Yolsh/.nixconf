{ self, inputs, ... }: {
    flake.wrappersModules.niri = { config, lib, pkgs, ... }: {
		options.terminal = lib.mkOption {
			type = lib.types.str;
			default = "ghostty";
		};

        config = {
            settings = let
				noctaliaExe = lib.getExe self.packages.${config.pkgs.stdenv.hostPlatform.system}.noctalia;
			in {
				input = {
					keyboard = {
						xkb = {
							layout = "gb";
							options = "ctrl:nocaps";
						};
						numlock = _:{};
					};
					touchpad = {
						tap = _:{};
						natural-scroll = _:{};
					};
					warp-mouse-to-focus = _:{};
					focus-follows-mouse = _:{ max-scroll-amount = "0%"; };
				};

				gestures.hot-corners.off = _:{};
				
				layout = {
					gaps = 16;
					background-color = "transparent";
					center-focused-column = "never";
					preset-column-widths = [
						{ proportion = 0.33333; }
						{ proportion = 0.5; }
						{ proportion = 0.66667; }
					];
					default-column-width.proportion = 0.5;
					focus-ring = {
					width = 2;
					inactive-color = "#595959aa";
					active-color = "#83a598";
					};
					border = {
					off = _:{};
					};
					shadow = {
					on = _:{};
					softness = 30;
					spread = 5;
					color = "#0007";
					};
				};
				xwayland-satellite.path = lib.getExe config.pkgs.xwayland-satellite;
				spawn-at-startup = [
					(noctaliaExe)
				];
				prefer-no-csd = _:{};
				screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
				animations.slowdown = 0.65;
				window-rule = []; # find out how to do this
				binds = {
					"Mod+Q".spawn = config.terminal;
					"Mod+Space".spawn-sh = "${noctaliaExe} msg panel-toggle launcher";
					"Mod+Alt+L".spawn-sh = "${noctaliaExe} msg session lock";
					XF86AudioRaiseVolume.spawn-sh = "${noctaliaExe} msg volume-up";
					XF86AudioLowerVolume.spawn-sh = "${noctaliaExe} msg volume-down";
					XF86AudioMute.spawn-sh = "${noctaliaExe} msg volume-mute";
					XF86AudioMicMute.spawn-sh = "${noctaliaExe} msg mic-mute";
					XF86MonBrightnessUp.spawn-sh = "${noctaliaExe} msg brightness-up";
					XF86MonBrightnessDown.spawn-sh = "${noctaliaExe} msg brightness-down";
					"Mod+Tab".toggle-overview = _:{};
					"Mod+C".close-window = _:{};
					"Mod+H".focus-column-left = _:{};
					"Mod+J".focus-window-down = _:{};
					"Mod+K".focus-window-up = _:{};
					"Mod+L".focus-column-right = _:{};
					"Mod+Ctrl+H".move-column-left = _:{};
					"Mod+Ctrl+J".move-window-down = _:{};
					"Mod+Ctrl+K".move-window-up = _:{};
					"Mod+Ctrl+L".move-column-right = _:{};
					"Mod+Shift+H".focus-monitor-left = _:{};
					"Mod+Shift+J".focus-monitor-down = _:{};
					"Mod+Shift+K".focus-monitor-up = _:{};
					"Mod+Shift+L".focus-monitor-right = _:{};
					"Mod+Shift+Ctrl+H".move-column-to-monitor-left = _:{};
					"Mod+Shift+Ctrl+J".move-column-to-monitor-down = _:{};
					"Mod+Shift+Ctrl+K".move-column-to-monitor-up = _:{};
					"Mod+Shift+Ctrl+L".move-column-to-monitor-right = _:{};
					"Mod+Home".focus-column-first = _:{};
					"Mod+End".focus-column-last = _:{};
					"Mod+Ctrl+Home".move-column-to-first = _:{};
					"Mod+Ctrl+End".move-column-to-last = _:{};
					"Mod+U".focus-workspace-down = _:{};
					"Mod+I".focus-workspace-up = _:{};
					"Mod+Ctrl+U".move-column-to-workspace-down = _:{};
					"Mod+Ctrl+I".move-column-to-workspace-up = _:{};
					"Mod+Shift+Page_Down".move-workspace-down = _:{};
					"Mod+Shift+Page_Up".move-workspace-up = _:{};
					"Mod+Shift+U".move-workspace-down = _:{};
					"Mod+Shift+I".move-workspace-up = _:{};
					"Mod+1".focus-workspace = 1;
					"Mod+2".focus-workspace = 2;
					"Mod+3".focus-workspace = 3;
					"Mod+4".focus-workspace = 4;
					"Mod+5".focus-workspace = 5;
					"Mod+6".focus-workspace = 6;
					"Mod+7".focus-workspace = 7;
					"Mod+8".focus-workspace = 8;
					"Mod+9".focus-workspace = 9;
					"Mod+Shift+1".move-column-to-workspace = 1;
					"Mod+Shift+2".move-column-to-workspace = 2;
					"Mod+Shift+3".move-column-to-workspace = 3;
					"Mod+Shift+4".move-column-to-workspace = 4;
					"Mod+Shift+5".move-column-to-workspace = 5;
					"Mod+Shift+6".move-column-to-workspace = 6;
					"Mod+Shift+7".move-column-to-workspace = 7;
					"Mod+Shift+8".move-column-to-workspace = 8;
					"Mod+Shift+9".move-column-to-workspace = 9;
					"Mod+BracketLeft".consume-or-expel-window-left = _:{};
					"Mod+BracketRight".consume-or-expel-window-right = _:{};
					"Mod+Comma".consume-window-into-column = _:{};
					"Mod+Period".expel-window-from-column = _:{};
					"Mod+R".switch-preset-column-width = _:{};
					"Mod+Shift+R".switch-preset-window-height = _:{};
					"Mod+Ctrl+R".reset-window-height = _:{};
					"Mod+F".maximize-column = _:{};
					"Mod+Shift+F".fullscreen-window = _:{};
					"Mod+Ctrl+F".expand-column-to-available-width = _:{};
					"Mod+Minus".set-column-width = "-10%";
					"Mod+Equal".set-column-width = "+10%";
					"Mod+Shift+Minus".set-window-height = "-10%";
					"Mod+Shift+Equal".set-window-height = "+10%";
					"Mod+V".toggle-window-floating = _:{};
					"Mod+Shift+V".switch-focus-between-floating-and-tiling = _:{};
					"Mod+W".toggle-column-tabbed-display = _:{};
					Print.screenshot = _:{};
					"Ctrl+Print".screenshot-screen = _:{};
					"Alt+Print".screenshot-window = _:{};
					"Ctrl+Alt+Delete".quit = _:{};
				};
				layer-rules = [
					{
						matches = [{ namespace = "^noctalia-wallpaper"; }];
						place-within-backdrop = true;
					}
				];
				switch-events = {
					lid-close.spawn = "${noctaliaExe} msg session lock-and-suspend";
				};
				overview.workspace-shadow.off = _:{};
				environment = {
					DISPLAY = ":0";
					XDG_CURRENT_DESKTOP = "wlroots";
				};
				hotkey-overlay.skip-at-startup = _:{};
			};
    	};
	};

    perSystem = { pkgs, ... }: {
		packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
			inherit pkgs;
			imports = [self.wrappersModules.niri];
		};
    };

	flake.nixosModules.niri = { pkgs, lib, ... }: {
		programs.niri = {
			enable = true;
			package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
		};
	};
}

