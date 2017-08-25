===============
chromebootstrap
===============

Bootstrap scripts and docs for setting up a ChromeOS device after first login
from a PowerWash


Motivation
==========

I've been interested in a `Chromebook
<https://www.google.com/chromebook/about/>`_ as a travel companion device for
quite some time but I'd never really sorted out how to answer the question of,
"How can I truly be productive with one of these without going into Dev Mode
and effectively negating the security features?"

Thankfully a very brave person by the name of Kenneth White was the trailblazer
on the topic (or at least the first to publish about it), and he wrote `My $169
development Chromebook
<https://blog.lessonslearned.org/building-a-more-secure-development-chromebook/>`_
which inspired me to finally pull the trigger.

Scope
=====

The scope of this currently is pretty minimal. It's at this time all about
bootstrapping the `Termux <https://termux.com/>`_ setup.

I'm not going to discuss things like SSH or GPG Key management, a really solid
approach to that is in Kenneth's blog post listed above and I suspect most
people who are going to have their own custom setup they have to cater to if
it's far outside what Kenneth recommends (my setup is extremely similar to his)
and I'm not realistically going to be able to satisfy such concerns here.

Apps
====

I'll discuss various apps I use here.

Termux
------

Install `Termux <https://termux.com/>`_ from the app store and then run the following:

::

    termux-setup-storage

    # Manage ssh keys (however you desire)

    apt update
    apt upgrade
    apt install git
    git clone https://github.com/maxamillion/chromebootstrap.git

    bash chromebootstrap/bootstrap-termux.sh

Setup sshd in a chroot:

::

    bash chromebootstrap/termux-setup-chroot.sh

To run local sshd in a chroot:

::

    bash chromebootstrap/termux-run-chroot-sshd.sh

Secure Shell
------------

Install the `Secure Shell
<https://chrome.google.com/webstore/detail/secure-shell/pnhechapfaindjhompbnflcldabbghjo>`_
Chrome app.

Configure `Secure Shell Powerline Fonts
<https://github.com/wernight/powerline-web-fonts>`_.

In the Secure Shell Options page, set the following:

    font-family: ``"Hack", monospace``
    user-css: ``https://cdn.rawgit.com/wernight/powerline-web-fonts/4c2fbd9a52a443fbdf00c9eb79e615f1bed3a55c/PowerlineFonts.css``
