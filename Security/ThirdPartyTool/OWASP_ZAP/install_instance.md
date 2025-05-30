Welcome to the Zed Attack Proxy
=====================================
The Zed Attack Proxy (ZAP) is one of the world’s most popular free
security tools and is actively maintained by hundreds of international
volunteers.
It can help you automatically find security vulnerabilities in your web
applications while you are developing and testing your applications.
Its also a great tool for experienced pentesters to use for manual security
testing.

For more details on ZAP please goto the home page:
        https://www.zaproxy.org/

We welcome feedback, either via the Issues, User Group or Developer Group.
ZAP is also a community based project, and contributions are welcomed.
See the ZAP website for more information.

How to start ZAP
----------------
There are 3 options on Windows:

* Via the desktop icon (assuming you selected this option during installation)
* Via the 'Start' menu:
    All Programs / ZAP / Zed Attack Proxy / ZAP <version>
* Via the 'zap.bat' command line script in the installation directory

Linux

On Linux there's just a 'zap.sh' script in the installation directory, although
you can create a desktop icon manually as well.

Mac OS

Generally, most user's tend to use the Mac OS build, which is a ordinary Mac OS
app that can be started as any other app: Double-Click on the app to start it.
You can use the 'zap.sh' script, as per linux.

Docker

ZAP is available as Docker images. For more details of how you can use them see
https://www.zaproxy.org/docs/docker/

Headless Environment
--------------------

By default ZAP will be started with a GUI which is not supported in headless
environments, in those cases ZAP needs to be started inline, using the command
line argument '-cmd', or in daemon mode, using '-daemon'.
For more information about the command line arguments use '-help'.
ZAP will show an information message and exit, if still started with GUI.

Java API
--------

The Java API is no longer packaged with this release.

You can download the latest version from:
https://github.com/zaproxy/zap-api-java/releases

It is also available on Maven Central:
 - GroupId: 'org.zaproxy'
 - ArtifactId: 'zap-clientapi'