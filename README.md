### DOLOG Script for Alfred.app

**DOLOG** is a script, written in **Swift** (3.0), that is used in an [Alfred](https://www.alfredapp.com) / [workflow](https://www.alfredapp.com/workflows/).

#### What it does

It takes an input string and creates an entry in the `log` journal of [Day One](http://dayoneapp.com) with the content of the entry formated as `completed task:` plus the input string.

The idea is to be able to quickly log the tasks that you complete during the day with as little friction as possible. Many things can be logged automatically with IFTTT, but some things fall outside of the automation capabilities. This is for those tasks you complete.

#### Usage

Invoke Alfred (for me this is `⌘-space`), type `dolog` (although I can usually just type `do`) then `return` to select the workflow, then type the text you want to log, and press `return`.

#### Optional tags

The input string can include tags for the Day One entry. The format to use is the following:

`-t tag1 tag_2 tag3 @ <completed task text>`

To include tasks, the input string must start with `-t `, followed by one or more space-separated tags, then the `end of tags` special character: `@`, then the text of the completed task.

To include spaces in tags, use the underscore `_` character where the space should be and the script will convert those while processing the tags. For example, the following:

`-t day_one @ something` 

Will create an entry with a tag `day one`

#### Default tags

All entries will have the `completed tasks` and the `dolog` tags added by default.

#### Swift version

This script is made for **Swift 3.0**. It has not been tested with Swift 2.0.

#### License

On the Map is Copyright © 2017 Denis Ricard. It is free software, and may be redistributed under the terms specified in the LICENSE file.

#### About

I'm an iOS developer. You can find my web site at [hexaedre.com](http://hexaedre.com), find me on Twitter under [@hexaedre](http://twitter.com/hexaedre), or [contact me](http://hexaedre.com/contact/).
