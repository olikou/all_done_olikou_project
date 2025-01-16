#!/bin/bash

colors[1]="(white)"
colors[2]="(red)"
colors[3]="(green)"
colors[4]="(blue)"
colors[5]="(purple)"
colors[6]="(black)"

default_columnn1_background=6
default_columnn1_font_color=1
default_columnn2_background=2
default_columnn2_font_color=4

columnn1_background=2
columnn1_font_color=4
columnn2_background=5
columnn2_font_color=1

output_columnn1_background=${columnn1_background:-"default"}
output_columnn1_font_color=${columnn1_font_color:-"default"}
output_columnn2_background=${columnn2_background:-"default"}
output_columnn2_font_color=${columnn2_font_color:-"default"}

columnn1_background=${columnn1_background:- $default_columnn1_background}
columnn1_font_color=${columnn1_font_color:- $default_columnn1_font_color}
columnn2_background=${columnn2_background:- $default_columnn2_background}
columnn2_font_color=${columnn2_font_color:- $default_columnn2_font_color}
