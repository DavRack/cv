#!/bin/bash

# expects a name as a parameter that name should be the yaml file

typst compile --input cvdata="$1.yaml" cv.typ "$1_cv.pdf"
