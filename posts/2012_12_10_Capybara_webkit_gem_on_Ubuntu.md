Hey Guys,

Tried installing the *capybara-webkit* gem today on Ubuntu *(Precise 12.04.1 LTS (GNU/Linux 3.2.0-32-virtual x86_64))* and ran into the following error

	Gem::Installer::ExtensionBuildError: ERROR: Failed to build gem native extension.
    
I needed to install the libqt4-dev package, after running the following my problems were gone :)

	sudo apt-get install libqt4-dev
    
-Matt