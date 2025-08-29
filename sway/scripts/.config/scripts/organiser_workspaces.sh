#!/bin/bash
#
# Script pour organiser les workspaces sur des moniteurs spécifiques.
swaymsg 'workspace number 1; move workspace to output "AOC 1601W MMEM1JA000545"'
swaymsg 'workspace number 3; move workspace to output "Samsung Electric Company Odyssey G5 HK7X400599"'
swaymsg 'workspace number 2; move workspace to output "Samsung Electric Company LS32CG51x H9JX201723"'

# Optionnel : revenir au workspace 1
swaymsg 'workspace number 2'

