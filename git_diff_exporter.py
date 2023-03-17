#!/usr/bin/env python3

import argparse
import os
import shutil
import subprocess
from datetime import datetime

parser = argparse.ArgumentParser(description='Export diff files between two commits.')
parser.add_argument('commit1', help='The first commit hash')
parser.add_argument('commit2', help='The second commit hash')
parser.add_argument('-o', '--output', help='Output path', default='..')
parser.add_argument('-f', '--format', help='Output name format (ex. OUTPUT-%Y%m%d)', default=None)
args = parser.parse_args()

if not args.commit1 or not args.commit2:
    print("Please provide two commit hashes")
    exit(1)

diff_files_output = subprocess.check_output(['git', 'diff', '--name-only', args.commit1, args.commit2]).decode('utf-8').strip()
diff_files = diff_files_output.split('\n')

if not diff_files_output:
    print("No files to export")
    exit(0)

output_name = args.format.format() if args.format else f"diff-{args.commit1[0:7]}-{args.commit2[0:7]}"
output_path = os.path.abspath(args.output)

if not os.path.exists(output_path):
    os.makedirs(output_path)

for file in diff_files:
    source_path = os.path.join(os.getcwd(), file)
    target_path = os.path.join(output_path, output_name, file)

    if os.path.exists(source_path):
        os.makedirs(os.path.dirname(target_path), exist_ok=True)
        shutil.copy2(source_path, target_path)
        print(f"Copied: {source_path} -> {target_path}")

print(f"Exported diff to {os.path.join(output_path, output_name)}")