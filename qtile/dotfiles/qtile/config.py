from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, hook, Screen, KeyChord
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.dgroups import simple_key_binder
from time import sleep

mod = "mod4"
terminal = "kitty"
min_gap = 3

base00 = "#1e2122"
base01 = "#202222"
base02 = "#36393a"
base03 = "#404344"
base04 = "#d4be98"
base05 = "#c0b196"
base06 = "#c3b499"
base07 = "#c9b100"
base08 = "#ec6b64"
base09 = "#e78a4e"
base0A = "#e0c080"
base0B = "#a9b665"
base0C = "#86b17f"
base0D = "#7daea3"
base0E = "#d3869b"
base0F = "#d65d0e"

dark_bg = "#0F1212"
bg = "#202222"
accent = ""
border = "#b7e4c7"
text = "#d7dbc7"
font_main = "CaskaydiaCove Nerd Font"
font_main_bold = "CaskaydiaCove Nerd Font Bold"
font_sc = "FiraCode Nerd Font"

keys = [
    #  D E F A U L T
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key(
        [mod, "shift"],
        "space",
        lazy.layout.previous(),
        desc="Move window focus to other window",
    ),
    Key(
        [mod, "control"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "control"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "control"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "shift"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "shift"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "shift"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "t", lazy.spawn(terminal), desc="Launch terminal"),
    Key(
        [mod],
        "b",
        lazy.spawn("flatpak run io.github.zen_browser.zen"),
        desc="Launch browser",
    ),
    # Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key(
        [mod],
        "r",
        lazy.spawn("sh -c ~/.config/rofi/scripts/launcher"),
        desc="Spawn a command using a prompt widget",
    ),
    Key([mod], "p", lazy.spawn("sh -c ~/.config/rofi/scripts/power"), desc="powermenu"),
    # Key([mod], "t", lazy.spawn("sh -c ~/.config/rofi/scripts/theme_switcher"), desc='theme_switcher'),
    # C U S T O M
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume 0 +5%"),
        desc="Volume Up",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume 0 -5%"),
        desc="volume down",
    ),
    Key(
        [], "XF86AudioMute", lazy.spawn("pulsemixer --toggle-mute"), desc="Volume Mute"
    ),
    Key(
        [mod, "control"],
        "space",
        lazy.spawn("playerctl play-pause"),
        desc="playerctl",
    ),
    Key([mod, "shift"], "n", lazy.spawn("playerctl previous"), desc="playerctl"),
    Key([mod], "n", lazy.spawn("playerctl next"), desc="playerctl"),
    Key(
        [mod],
        "Tab",
        lazy.spawn("sh -c ~/.config/qtile/scripts/toggle_audio.sh"),
        desc="Toggle between audio ports",
    ),
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl s 10%+"),
        desc="brightness UP",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl s 10%-"),
        desc="brightness Down",
    ),
    Key([mod], "e", lazy.spawn("thunar"), desc="file manager"),
    Key([mod], "s", lazy.spawn("flameshot gui"), desc="Screenshot"),
    Key(
        ["control", "mod1"],
        "Right",
        lazy.screen.next_group(),
        desc="Move to the next workspace",
    ),
    Key(
        ["control", "mod1"],
        "Left",
        lazy.screen.prev_group(),
        desc="Move to the previous workspace",
    ),
    Key(
        ["control", "shift"],
        "Right",
        lazy.window.to_next_workspace(),
        desc="Move window to next workspace",
    ),
    Key(
        ["control", "shift"],
        "Left",
        lazy.window.to_previous_workspace(),
        desc="Move window to previous workspace",
    ),
    Key(
        [mod],
        "v",
        lazy.spawn("sh -c ~/.config/rofi/scripts/cliphistory"),
        desc="clipboard",
    ),
]


# █▀▀ █▀█ █▀█ █░█ █▀█ █▀
# █▄█ █▀▄ █▄█ █▄█ █▀▀ ▄█


groups = [Group(f"{i+1}", label="") for i in range(8)]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )


lay_config = {
    "border_width": 2,
    "margin": min_gap,
    "border_focus": border,
    "border_normal": "#3b4252",
    "font": "FiraCode Nerd Font",
    "grow_amount": 2,
}

layouts = [
    layout.Bsp(**lay_config, fair=False, border_on_single=True),
    layout.Columns(
        **lay_config,
        border_on_single=True,
        num_columns=2,
        split=False,
    ),
    layout.Floating(**lay_config),
    layout.Max(**lay_config),
]


widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = [widget_defaults.copy()]


def search():
    qtile.cmd_spawn(
        "rofi -show drun -theme ~/.config/rofi/settings/listitem/everforest.rasi"
    )


def power():
    qtile.cmd_spawn("sh -c ~/.config/rofi/scripts/power")


screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(
                    length=15,
                    background=dark_bg,
                ),
                widget.Image(
                    filename="~/.config/qtile/Assets/launch_Icon.png",
                    margin=2,
                    background=dark_bg,
                    mouse_callbacks={"Button1": power},
                ),
                widget.Image(
                    filename="~/.config/qtile/Assets/6.png",
                ),
                widget.GroupBox(
                    font=font_main,
                    fontsize=23,
                    borderwidth=3,
                    highlight_method="block",
                    active=base04,
                    block_highlight_text_color=base09,
                    highlight_color=base02,
                    # inactive=dark_bg,
                    foreground=base02,
                    background=bg,
                    this_current_screen_border=bg,
                    this_screen_border=bg,
                    other_current_screen_border=bg,
                    other_screen_border=bg,
                    urgent_border=bg,
                    rounded=True,
                    disable_drag=True,
                ),
                widget.Image(
                    filename="~/.config/qtile/Assets/5.png",
                ),
                widget.TextBox(
                    text=" ",
                    font=font_main,
                    fontsize=13,
                    background=dark_bg,
                    foreground=text,
                    mouse_callbacks={"Button1": search},
                ),
                widget.TextBox(
                    fmt="Search",
                    background=dark_bg,
                    font=font_main_bold,
                    fontsize=15,
                    foreground=text,
                    mouse_callbacks={"Button1": search},
                ),
                widget.Image(
                    filename="~/.config/qtile/Assets/4.png",
                ),
                widget.WindowName(
                    background=bg,
                    font=font_main_bold,
                    fontsize=14,
                    empty_group_string="Desktop",
                    max_chars=130,
                    foreground=text,
                ),
                widget.Image(
                    filename="~/.config/qtile/Assets/3.png",
                ),
                widget.Systray(background=dark_bg, padding=10, icon_size=15),
                widget.TextBox(
                    text="󰎆",
                    font=font_main,
                    fontsize=14,
                    background=dark_bg,
                    foreground=border,
                    mouse_callbacks={"Button1": search},
                    padding=10,
                ),
                widget.Mpris2(
                    background=dark_bg,
                    max_chars=40,
                    foreground=text,
                    font=font_main_bold,
                    fontsize=14,
                    padding=10,
                ),
                widget.Image(
                    filename="~/.config/qtile/Assets/6.png",
                    background=bg,
                ),
                widget.TextBox(
                    text="󰍛",
                    font=font_main,
                    fontsize=15,
                    background=bg,
                    foreground=text,
                ),
                widget.Memory(
                    background=bg,
                    format="{MemUsed: .0f}{mm}",
                    foreground=text,
                    font=font_main_bold,
                    fontsize=15,
                    update_interval=5,
                ),
                widget.Spacer(
                    length=8,
                    background=bg,
                ),
                widget.Net(
                    format="↑ {down:>2.1f}{down_suffix}",
                    background=bg,
                    font=font_main_bold,
                    fontsize=15,
                    foreground=text,
                    prefix="M",
                    # update_interval=1,
                ),
                widget.Image(
                    filename="~/.config/qtile/Assets/2.png",
                ),
                widget.Spacer(
                    length=8,
                    background=bg,
                ),
                widget.GenPollText(
                    func=lambda: subprocess.check_output(
                        "~/.config/qtile/scripts/audio_icon.sh", shell=True
                    )
                    .decode("utf-8")
                    .strip(),
                    update_interval=5,
                    background=bg,
                    foreground=text,
                    mouse_callbacks={
                        "Button1": lazy.spawn(
                            "sh -c ~/.config/qtile/scripts/toggle_audio.sh"
                        )
                    },
                    fontsize=14,
                ),
                widget.Spacer(
                    length=5,
                    background=bg,
                ),
                widget.TextBox(
                    text=" ",
                    font=font_main,
                    fontsize=14,
                    background=bg,
                    foreground=text,
                ),
                widget.Volume(
                    font=font_main_bold,
                    fontsize=15,
                    background=bg,
                    foreground=text,
                ),
                widget.Image(
                    filename="~/.config/qtile/Assets/5.png",
                    background=bg,
                ),
                widget.TextBox(
                    text=" ",
                    font=font_main,
                    fontsize=14,
                    background=dark_bg,
                    foreground=text,
                ),
                widget.Clock(
                    format="%I:%M %p",
                    background=dark_bg,
                    foreground=text,
                    font=font_main_bold,
                    fontsize=15,
                ),
                widget.Spacer(
                    length=18,
                    background=dark_bg,
                ),
            ],
            33,
            border_color="#3b4252",
            border_width=[0, 0, 0, 0],
            # t,r,b,l
            margin=[min_gap * 2, min_gap * 4, min_gap * 1, min_gap * 4],
        ),
        right=bar.Gap(min_gap * 2),
        bottom=bar.Gap(min_gap),
        left=bar.Gap(min_gap * 2),
    ),
]

mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.toggle_floating()),
]

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    border_focus="#1F1D2E",
    border_normal="#1F1D2E",
    border_width=0,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ],
)


import os
import subprocess


@hook.subscribe.startup_once
def autostart():
    subprocess.call([os.path.expanduser(".config/qtile/autostart_once.sh")])


auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

auto_minimize = True

wl_input_rules = None

wmname = "LG3D"


# E O F
