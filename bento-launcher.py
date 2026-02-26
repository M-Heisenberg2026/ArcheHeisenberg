#!/usr/bin/env python3
"""
ArcheHeisenberg Bento Launcher
Öffnet das Bento-Menu im Browser
"""
import webbrowser
import os
from pathlib import Path

def main():
    script_dir = Path(__file__).parent.resolve()
    index_file = script_dir / "index.html"
    
    if index_file.exists():
        url = f"file://{index_file}"
        print(f"🧬 Öffne ArcheHeisenberg Bento Menu...")
        print(f"   {url}")
        webbrowser.open(url)
    else:
        print("❌ index.html nicht gefunden!")
        print(f"   Erwartet: {index_file}")

if __name__ == "__main__":
    main()
