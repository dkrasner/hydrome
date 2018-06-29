# HydroMe API

## Overview
This package directory contains all source code necessary for the Hydro
backend API server and related services/functionalities.


## Requirements
Python 3.6.0 or later. The development server is run with Python3 Flask Note:
this might be changed for a production version at a later date.).

## Installation
We recommend using python virtual environments. You can create one by running
`python3 -m venv --system-site-packages VENVNAME` and replace `VENVNAME` by
a name/location of your choosing. Exclude the `--system-site-packages` flag if you do
not want the environment to have access to local system site packages.
Start up the environment by running `source VENVNAME/bin/activate`. Run
`deactivate` to exit the environment.

Run `pip install -r requirements.txt` to install packages.


## Starting the server
Run `python api.py` in the `./scripts` directory (user `--help` for options).

## Styles etc
For python code we stick to PEP8 standards.

Make sure you have a reasonable gitignore file and don't commit anything
strictly unnecessary.
