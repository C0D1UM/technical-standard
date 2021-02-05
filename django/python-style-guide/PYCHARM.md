# PyCharm Configuration

YAPF can be configured as an “External Tool” inside PyCharm and run on a per-file basis. Go to File -> Settings -> Tools -> External Tools and click +. In the dialog that opens enter the following details:

* Name: YAPF
* Description: Run Yapf formatter on current file
* Program: \<path to yapf>
* Arguments: `-i $FilePath$`
* Working directory: `$ProjectFileDir$`

\<path to yapf> is the full path to the YAPF executable on your system:

* Linux/Mac: `/usr/bin/yapf` if installed with a package manager or `$HOME/.local/bin/yapf` if installed with pip
* Windows: `<PythonPath>\Scripts\yapf.exe`

A YAPF item should now appear in the Tools -> External Tools menu. This can be bound to a shortcut key under File -> Settings -> Keymap -> External Tools.
