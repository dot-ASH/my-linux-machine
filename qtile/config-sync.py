import os
import shutil
import sys

SRC_DIR = os.path.expanduser("~")
DOT_DIR = os.path.join(SRC_DIR, "Downloads/my-linux-machine/qtile")

ITEMS = [
    "dunst",
    "kitty",
    "nvim",
    "picom",
    "qtile",
    "rofi",
    "starship.toml",
]

HOME_ITEMS = [
    ".zshrc",
    ".vimrc",
    "config-sync.py",
]


def sync_items(src_dir, dest_dir, items, direction):
    for item in items:
        if direction == "push":
            src_path = os.path.join(src_dir, item)
            dest_path = os.path.join(dest_dir, "dotfiles" if item in ITEMS else "")
        else:  # pull
            src_path = os.path.join(dest_dir, "dotfiles" if item in ITEMS else "", item)
            dest_path = os.path.join(src_dir, item)

        if os.path.exists(src_path):
            if direction == "push":
                if os.path.isdir(src_path):
                    shutil.copytree(
                        src_path,
                        os.path.join(dest_path, os.path.basename(item)),
                        dirs_exist_ok=True,
                    )
                else:
                    os.makedirs(dest_path, exist_ok=True)
                    shutil.copy2(src_path, dest_path)
            elif direction == "pull":
                if os.path.isdir(src_path):
                    shutil.copytree(src_path, dest_path, dirs_exist_ok=True)
                else:
                    os.makedirs(os.path.dirname(dest_path), exist_ok=True)
                    shutil.copy2(src_path, dest_path)
            print(f"Synced ({direction}): {src_path} -> {dest_path}")
        else:
            print(f"Skipping ({direction}): {src_path} (does not exist)")


def main(direction):
    if direction not in ["push", "pull"]:
        print(
            "Invalid direction. Use 'push' to sync to destination or 'pull' to sync back."
        )
        sys.exit(1)

    sync_items(
        os.path.join(SRC_DIR, ".config") if direction == "push" else DOT_DIR,
        DOT_DIR if direction == "push" else os.path.join(SRC_DIR, ".config"),
        ITEMS,
        direction,
    )

    sync_items(
        SRC_DIR if direction == "push" else DOT_DIR,
        DOT_DIR if direction == "push" else SRC_DIR,
        HOME_ITEMS,
        direction,
    )

    vesktop_theme_src = os.path.join(
        SRC_DIR, ".var/app/dev.vencord.Vesktop/config/vesktop/themes/theme.css"
    )
    vesktop_theme_dest = os.path.join(DOT_DIR, "utils/discord", "theme.css")
    if direction == "push":
        if os.path.exists(vesktop_theme_src):
            os.makedirs(os.path.dirname(vesktop_theme_dest), exist_ok=True)
            shutil.copy2(vesktop_theme_src, vesktop_theme_dest)
            print(f"Synced (push): {vesktop_theme_src} -> {vesktop_theme_dest}")
        else:
            print(f"Skipping (push): {vesktop_theme_src} (does not exist)")
    elif direction == "pull":
        if os.path.exists(vesktop_theme_dest):
            os.makedirs(os.path.dirname(vesktop_theme_src), exist_ok=True)
            shutil.copy2(vesktop_theme_dest, vesktop_theme_src)
            print(f"Synced (pull): {vesktop_theme_dest} -> {vesktop_theme_src}")
        else:
            print(f"Skipping (pull): {vesktop_theme_dest} (does not exist)")

    print(f"Sync ({direction}) complete!")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python sync.py <push|pull>")
        sys.exit(1)

    sync_direction = sys.argv[1]
    main(sync_direction)
