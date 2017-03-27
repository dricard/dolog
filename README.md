# DOLOG Script for Alfred.app

[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift/)  [![Twitter](https://img.shields.io/badge/twitter-@hexaedre-blue.svg?style=flat)](https://twitter.com/hexaedre)  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**DOLOG** is a script, written in **Swift**, that is used in an [Alfred][alfred] / [workflow][workflows].

#### What it does

It takes an input string and creates an entry in the `log` journal of [Day One][dayone] with the content of the entry formated as `completed task:` plus the input string.

The idea is to be able to quickly log the tasks that you complete during the day with as little friction as possible. Many things can be logged automatically with IFTTT, but some things fall outside of the automation capabilities. This is for those tasks you complete.

#### Installation

You need a few things to make use of this script:

##### What you need

- you need the latest version of [Day One 2][dayone]
- you must have installed the Day One CLI: menu `/Day One/Install Command Line Tools.../` and follow the instructions.
- you need to have [Aldred][alfred] installed, with a [PowerPack][powerpack] license (required to use [workflows][workflows])

##### Installation

- download and unzip the `dolog` package.
- double-click the `.alfredworkflow` file to install the workflow in Alfred.
- open the workflow and double-click the `external script` module.
- click the `open workflow folder in finder` button to the left of the `cancel`button. ![button](http://hexaedre.com/resources/alfredOpenFolder.png)
- copy the `DayOneLoggerPlus` file from the `dolog` package to the workflow folder.
- you can close the workflow folder and Alfred's preferences window.
- you're good to go!

#### Usage

Invoke Alfred (for me this is `⌘-space`), type `dolog` (although I can usually just type `do`) then `return` to select the workflow, then type the text you want to log, and press `return`.

##### Optional tags

The input string can include tags for the Day One entry. The format to use is the following:

`-t tag1 tag_2 tag3 @ <completed task text>`

To include tags, the input string must start with `-t `, followed by one or more space-separated tags, then the `end of tags` special character: `@`, then the text of the completed task.

To include spaces in tags, use the underscore `_` character where the space should be and the script will convert those while processing the tags. For example, the following:

`-t day_one @ something` 

Will create an entry with a tag `day one`

#### Default tags

All entries will have the `completed tasks` and the `dolog` tags added by default.

#### Swift version

This script is made for **Swift 3.0**. It has not been tested with Swift 2.0.

#### Modifying the script

You can modify for example the default journal to log into, the default tags, etc. by modifying the script in the included `DayOneLoggerPlus.swift` file. You must then compile the script and make it executable and put it in the workflow folder.

#### License

Dolog is Copyright © 2017 Denis Ricard. It is free software, and may be redistributed under the terms specified in the LICENSE file.

#### About

I'm an iOS developer. You can find my web site at [hexaedre.com](http://hexaedre.com), find me on Twitter under [@hexaedre](http://twitter.com/hexaedre), or [contact me](http://hexaedre.com/contact/).

[dayone]: http://dayoneapp.com
[alfred]: https://www.alfredapp.com
[workflows]: https://www.alfredapp.com/workflows/
[powerpack]: https://www.alfredapp.com/powerpack/
[dolog]: http://hexaedre.com/scripts/dolog/