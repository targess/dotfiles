#!/usr/bin/env python3
import json, sys, subprocess, os

data = json.load(sys.stdin)
model = data['model']['display_name'].replace('Claude ', '')
cwd   = os.path.basename(data['workspace']['current_dir'])
ctx   = int(data.get('context_window', {}).get('used_percentage', 0) or 0)
rate  = data.get('rate_limits', {})
fh    = rate.get('five_hour', {}).get('used_percentage')
wd    = rate.get('seven_day',  {}).get('used_percentage')
cost  = data.get('cost', {}).get('total_cost_usd', 0) or 0

def color(pct):
    if pct >= 80: return '\033[31m'
    if pct >= 50: return '\033[33m'
    return '\033[32m'

R  = '\033[0m'
CY = '\033[36m'
YL = '\033[33m'

try:
    branch = subprocess.check_output(
        ['git', 'branch', '--show-current'],
        stderr=subprocess.DEVNULL, text=True
    ).strip()
except Exception:
    branch = ''

location = f"{cwd}" + (f" | {branch}" if branch else "")
parts = [f"{CY}[{model}]{R} {location}"]
parts.append(f"{color(ctx)}context {ctx}%{R}")
if fh is not None:
    p = round(fh)
    parts.append(f"{color(p)}5h {p}%{R}")
if wd is not None:
    p = round(wd)
    parts.append(f"{color(p)}7d {p}%{R}")
parts.append(f"{YL}${cost:.3f}{R}")

print("  ".join(parts))
