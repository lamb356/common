#!/usr/bin/env python3

"""List the packages Cargo reports in the root workspace."""

import json
import subprocess
import sys
from pathlib import Path


def main() -> int:
    root = Path(__file__).resolve().parents[2]
    metadata = json.loads(
        subprocess.run(
            [
                "cargo",
                "metadata",
                "--format-version",
                "1",
                "--no-deps",
                "--locked",
            ],
            cwd=root,
            check=True,
            text=True,
            stdout=subprocess.PIPE,
        ).stdout
    )
    workspace_members = set(metadata["workspace_members"])
    packages = []
    for package in metadata["packages"]:
        if package["id"] not in workspace_members:
            continue
        member_dir = Path(package["manifest_path"]).resolve().parent
        packages.append(
            {
                "directory": member_dir.relative_to(root).as_posix(),
                "name": package["name"],
                "publish": package.get("publish"),
            }
        )

    packages.sort(key=lambda package: package["directory"])
    json.dump(packages, sys.stdout, separators=(",", ":"))
    print()
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except (
        json.JSONDecodeError,
        OSError,
        subprocess.CalledProcessError,
        ValueError,
    ) as error:
        print(f"workspace package discovery failed: {error}", file=sys.stderr)
        sys.exit(1)
