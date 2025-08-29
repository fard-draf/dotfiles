#!/usr/bin/env python3
#
# Auteur: SYS_ADMIN_helper (Version finale et fonctionnelle)
# Lit le texte depuis l'entrée standard (pipe), le filtre,
# et le sauvegarde ou l'affiche dans un onglet.

import os
import sys
import re
import tempfile

def send_command(command):
    """Envoie une commande à Qutebrowser via le FIFO."""
    fifo_path = os.environ.get('QUTE_FIFO')
    if fifo_path:
        with open(fifo_path, 'w') as f:
            f.write(command + '\n')

# --- CONFIGURATION ---
DEFAULT_WORD_THRESHOLD = 5
DEFAULT_MODE = 'download'
# ---------------------

# --- Analyse des arguments ---
word_threshold = DEFAULT_WORD_THRESHOLD
mode = DEFAULT_MODE
for arg in sys.argv[1:]:
    if arg == '--tab':
        mode = 'tab'
    else:
        try:
            word_threshold = int(arg)
        except ValueError:
            pass

# --- Logique Principale ---
try:
    raw_text = sys.stdin.read()
    page_title = os.environ.get('QUTE_TITLE', 'qute_page')
    safe_filename = re.sub(r'[^a-zA-Z0-9_-]', '', page_title.replace(' ', '_')) + '.txt'

    filtered_lines = [
        line.strip() for line in raw_text.split('\n')
        if line.strip() and len(line.strip().split()) >= word_threshold
    ]
    final_text = '\n'.join(filtered_lines)

    if mode == 'download':
        output_path = os.path.join(os.path.expanduser('~/Downloads'), safe_filename)
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(final_text)
        send_command(f"message-info 'Texte sauvegardé dans {output_path}'")
    elif mode == 'tab':
        with tempfile.NamedTemporaryFile(delete=False, mode='w', suffix='.html', encoding='utf-8') as f:
            escaped_text = final_text.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
            f.write(f"<html><head><title>Texte de - {page_title}</title>")
            f.write("<style>body { font-family: monospace; white-space: pre-wrap; background-color: #282a36; color: #f8f8f2; padding: 2em; }</style>")
            f.write("</head><body>{escaped_text}</body></html>")
            temp_file_path = f.name
        send_command(f"open -t file://{temp_file_path}")

except Exception as e:
    send_command(f"message-error 'Erreur dans qute-extract.py: {e}'")
