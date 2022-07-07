#!/usr/bin/env python3
#-*- coding: utf-8 -*-

import os
import sys
import shutil
import subprocess
import tempfile

from pathlib import Path

ROOT = Path(os.path.dirname(__file__)).absolute()

PLUGINS = {
    "auto-pairs": {
        "url": "https://github.com/jiangmiao/auto-pairs",
        "files": [
            "doc/",
            "plugin/",
        ],
    },
    "minicommenter": {
        "url": "https://github.com/qdebroise/minicommenter",
        "files": [
            "doc/",
            "plugin/",
        ],
    },
    "fzf": {
        "url": "https://github.com/junegunn/fzf",
        "files": [
            "doc/",
            "plugin/",
            "install",
        ],
    },
}

if __name__ == "__main__":
    proc = subprocess.run(["git", "status", "--porcelain=v1"],
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL)

    if proc.stdout != "":
        print("Failed: there are untracked, unstaged or non committed changes.")
        sys.exit(1)
    
    with tempfile.TemporaryDirectory(prefix="temp-", dir=ROOT) as tmpdir_name:
        tmpdir = Path(tmpdir_name).absolute()

        for name, info in PLUGINS.items():
            print(f"Updating '{name}'...", end="")
            plugin_dir = tmpdir / name
            os.makedirs(plugin_dir)

            proc = subprocess.run(["git", "clone", info.get("url", ""), plugin_dir],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE)
            if proc.returncode != 0:
                print("[FAILED]")
                print(f"Failed to update '{name}': {proc.stdout}")
                continue

            dst_dir = ROOT / "pack/plugins/start" / name
            shutil.rmtree(dst_dir)
            os.makedirs(dst_dir)

            for file in info.get("files", []):
                shutil.move(str(plugin_dir / file), str(dst_dir))

            print("[DONE]")


