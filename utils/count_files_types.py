#!/usr/bin/env python3

import sys
from pathlib import Path
from collections import Counter


def scan_extensions(folder: str) -> None:
    root = Path(folder)
    if not root.is_dir():
        print(f"Error: '{folder}' is not a valid directory", file=sys.stderr)
        sys.exit(1)

    counts = Counter(
        p.suffix.lower() if p.suffix else "(no extension)"
        for p in root.rglob("*")
        if p.is_file()
    )

    if not counts:
        print("No files found.")
        return

    width = max(len(ext) for ext in counts)
    for ext, count in sorted(counts.items(), key=lambda x: -x[1]):
        print(f"{ext:<{width}}  {count}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <folder>", file=sys.stderr)
        sys.exit(1)
    scan_extensions(sys.argv[1])
