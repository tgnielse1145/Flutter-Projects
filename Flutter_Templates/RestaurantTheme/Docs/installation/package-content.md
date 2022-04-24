# System Requirements {#system-requirements}

* **Operating Systems**: macOS \(64-bit\).

* **Disk Space**: 700 MB \(does not include disk space for Xcode or Android Studio\).

* **Tools**: Flutter depends on these command-line tools being available in your environment.

  * `bash`, `mkdir`, `rm`, `git`, `curl`, `unzip`, `which`

## Get the Flutter SDK {#get-the-flutter-sdk}

To get Flutter, use `git` to clone the repository and then add the  `flutter` tool to your path. Running  `flutter doctor` shows any remaining dependencies you may need to install.

### Clone the repo {#clone-the-repo}

If this is the first time you’re installing Flutter on your machine, clone the`beta`branch of the repository and then add the `flutter` tool to your path:

    $ git clone -b beta https://github.com/flutter/flutter.git

    $ export PATH=`pwd`/flutter/bin:$PATH

The above command sets your PATH variable temporarily, for the current terminal window. To permanently add Flutter to your path, see [Update your path](https://flutter.io/setup-macos/#update-your-path).

To update an existing version of Flutter, see [Upgrading Flutter](https://flutter.io/upgrading/).

### Run flutter doctor {#run-flutter-doctor}

Run the following command to see if there are any dependencies left that you need to install to complete the setup:

```
$ flutter doctor
```



