#!/usr/bin/env python3

"""List the packages declared by the root Cargo workspace."""

import glob
import json
import sys
import tomllib
from pathlib import Path


def load_toml(path: Path) -> dict:
    with path.open("rb") as source:
        return tomllib.load(source)


def main() -> int:
    root = Path(__file__).resolve().parents[2]
    workspace_manifest = load_toml(root / "Cargo.toml")
    workspace = workspace_manifest.get("workspace")
    if workspace is None:
        raise ValueError("the root Cargo.toml has no [workspace] table")

    excluded = {
        Path(path).resolve()
        for pattern in workspace.get("exclude", [])
        for path in glob.glob(str(root / pattern), recursive=True)
    }
    member_dirs: set[Path] = set()
    for pattern in workspace.get("members", []):
        matches = [
            Path(path).resolve()
            for path in glob.glob(str(root / pattern), recursive=True)
            if (Path(path) / "Cargo.toml").is_file()
        ]
        if not matches:
            raise ValueError(f"workspace member pattern matched no crates: {pattern}")
        member_dirs.update(path for path in matches if path not in excluded)

    workspace_package = workspace.get("package", {})
    packages = []
    for member_dir in sorted(member_dirs):
        package = load_toml(member_dir / "Cargo.toml").get("package")
        if package is None or "name" not in package:
            raise ValueError(f"{member_dir / 'Cargo.toml'} has no package name")

        publish = package.get("publish")
        if isinstance(publish, dict) and publish.get("workspace") is True:
            publish = workspace_package.get("publish")

        packages.append(
            {
                "directory": member_dir.relative_to(root).as_posix(),
                "name": package["name"],
                "publish": publish,
            }
        )

    json.dump(packages, sys.stdout, separators=(",", ":"))
    print()
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except (OSError, ValueError, tomllib.TOMLDecodeError) as error:
        print(f"workspace package discovery failed: {error}", file=sys.stderr)
        sys.exit(1)
