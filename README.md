# Toggle-Terminator
#### Make Terminator Terminal Act Like Guake/Yakuake Terminal in UBUNTU

Clone the repository
```
git clone https://github.com/sonus/toggle-terminator.git ~/toggle-terminator
```
Change Directory to toggle-terminator
```
cd toggle-terminator

```
Make the python script an executable
```
chmod +x toggle_visibility.sh

```
Copy the Realpath of the python script
```
realpath toggle_visibility.sh #Copy the output text

```

#### Now we need to create a custom keyboard shortcut using System settings


* Find "Keyboard" inside System Settings
* Click on the Shortcuts tab
* Click on the Custom Shortcuts under Categories section
* Now click on the 'Add custom shortcut' Button
* In the Pop-up menu add any name and then paste the copied python script(/home/sonus/toggle-terminator/toggle_visibility.sh) in the command box
* Then Add "terminator" after a space in the command box the click Add.
* Now a new row will be added inside 'Keyboard Shortcuts' select the newly added shortcut
* under the Keyboard binding double click on first row 'unassigned' the it will change to 'Pick an accelerator'
* now press F12 and close the window

Thats it :)

Just press F12, terminator will appear in front of you. Pressing it once more it will hide.


#### Note
* You can also add other application along with this, ex: subl for Sublime Text ...
* For mutiple instance application /path_to/toggle_visibility.sh application_name
* For single instance application /path_to/toggle_visibility.sh application_name 1

All credits License own by the following folks
* [Andrew@webupd8.org](http://www.webupd8.org/2011/07/install-terminator-with-built-in-quake.html)
* [bytefreaks.net](http://bytefreaks.net/gnulinux/bash/howto-make-terminator-terminal-act-like-guake-terminal-in-fedora-20ubuntu-14-10)
