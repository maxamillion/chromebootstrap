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

I'll discuss various apps I use here. Make sure to `enable Android App Support
<https://support.google.com/chromebook/answer/7021273?hl=en>`_ on your
Chromebook.

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


Termux - local sshd in a chroot
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

While Termux is fantastic, the Android App Support on ChromeOS still leaves
a little to be desired. Such things like native copy/paste don't work and the
font rendering is different. You can control fonts a little in the Android
Settings app under Accessibility but it's just not as good as the font rendering
for Chrome Apps. Therefore we setup this local sshd on the Chromebook for
an over all better experience in the shell (the Chrome SSH client will even copy
your tmux selections to the ChromeOS clipboard).

Setup sshd in a chroot (I haven't figured out how to script this, things get
wonky when you run ``termux-chroot`` in a script):

::

    termux-chroot

    mkdir -p /storage/emulated/0/Download/devbox/ssh
    ln -s /storage/emulated/0/Download/devbox /home/devbox
    ssh-keygen -t rsa -b 4096 -C "maxamillion@fedoraproject.org"


Notes to pay attention to from the ``ssh-keygen`` prompt:

::

    Enter file in which to save the key: /home/devbox/ssh/id_rsa


Continue with the setup:

::

    cat /home/devbox/ssh/id_rsa.pub >> /home/.ssh/authorized_keys

    echo "ssh: $(whoami)@$(ifconfig arc0 | awk '/inet /{print $2}')"

The output from the above command is what you'll use to connect from the ssh
client in the next section (make sure to import the ssh key from
``Downloads/devbox/ssh`` when the time comes).

Now go ahead and run sshd

::

    termux-chroot
    sshd

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

The output from the above command run inside Termux should have been something
like ``u0_a54@100.115.92.2`` and this is what you will ssh into. However, do
note that you will be connecting over port ``8022`` as this is what `sshd will
default to in Termux <https://termux.com/ssh.html>`_.
