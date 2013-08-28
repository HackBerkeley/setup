# Windows setup

## Chocolatey

Get [Chocolatey](http://chocolatey.org/).

Chocolatey is a package manager (the only decent one we know of) for Windows
that makes life very easy. Currently, this setup guide will assume you have it
installed.

Installing it is pretty easy.

* Open up cmd.exe
* Paste in the (rather long) command below:
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%systemdrive%\chocolatey\bin - See more at: http://chocolatey.org/#sthash.eIv3pkq4.dpuf
* Close cmd.exe, reopen it. Make sure it's installed by typing in `chocolatey`.
