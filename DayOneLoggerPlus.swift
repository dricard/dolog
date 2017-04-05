#!/usr/bin/env xcrun swift

import Foundation

/* *********************************
	 		DOLOG Script
   ********************************* */


/* *********************************
	 MODIFY THESE 3 PROPERTIES
	         AS NEEDED
********************************* */

// the journal to log to in Day One

let dayOneJournal = "log"

// the default tag(s) to add to all entries. If you don't
// add at least one default tag, you'll have to modify the code below.
// tags *can* have spaces

let defaultTags = ["dolog", "completed tasks"]

// the entry prefix

let entryPrefix = "completed task:"

/* ********************************* */


// requires Swift 3.0
// might work with Swift 2.0 but is untested
// Will not work with Swift 1.0


//-- get parameter input
// `argument` holds the text entered in Alfred by the user
// I initialize it with an example of something the user could enter
// for testing. 

var argument = "-t workflow@Switched to Mailmate as my email client"
#if swift(>=3.0)
	if CommandLine.arguments.count > 1 {
		argument = CommandLine.arguments[1]
	}
#elseif swift(>=2.0)
	if Process.arguments.count > 1 {
		argument = Process.arguments[1]
	}
#elseif swift(>=1.0)
	print("Unsupported version of Swift (<= 2.0) please update to Swift 3.0")
	break
#endif

// MARK: - Properties

// variable 'task' will hold the completed task passed in

var task  = ""

// `outputString` is the result of the script that will be passed to the CLI, 
// we initialize it with the Day One CLI command, setting the default journal
// and the default tags.

var outputString: String = "dayone2 --journal "

// add journal name and default tags

outputString += dayOneJournal + " --tags "

for defaulTag in defaultTags {
	let tag = defaulTag.replacingOccurrences(of: " ", with: "\\ ")
	outputString += tag + " "
}

// MARK: - Process input

//-- Test if tags are present

// weHaveTags is true if there are tags present

let weHaveTags = argument.hasPrefix("-t")

//-- Process tags if present, otherwise just pass the input

if weHaveTags {
	
	// find the index of the tags separator
	
	if let endOfTags = argument.characters.index(of: "@") {

		// Map the tags into an array. The first tag (index 0) will be the tag option marker (-t) and will be
		// omitted
		
		let tags = String(argument.characters.prefix(upTo: endOfTags)).characters.split(separator: " ").map{ String($0) }
		
		// Now process the task part to remove the end of tags marker
		
		// get the task part of the input
		
		let taskSection = String(argument.characters.suffix(from: endOfTags))
		
		// find the index of the tags separator in this string (different than above)
		
		let endTagIndex = taskSection.characters.index(of: "@")!
		
		// The task proper starts after the tags separator
		
		let tagIndex = taskSection.characters.index(after: endTagIndex)

		// get the task
		
		task = String(taskSection.characters.suffix(from: tagIndex))
		
		// Now we have the task, we then process and format the tags
		// Add the tags to the output string separated by spaces
		// skipping the first one which is the `-t` marker
			
		for i in 1..<tags.count {
			
			// first we process underscores (_) in tags to replace them with escaped spaces so they're
			// treated as a single tag
			
			let tag = tags[i].replacingOccurrences(of: "_", with: "\\ ")
			
			// add this processed tag to the output string
			
			outputString += tag + " "
		}
	} else {

		// user forgot the '@' separator so just pass the input string (task) as received
	
		task = argument
		
	}
		
} else {
	
	// no tags, so just pass the input string (task) as received
	
	task = argument
}

// Add the task to the output string (enclosed in quotes to prevent the CLI to interpret special characters)

outputString += " -- new" + " \"" + entryPrefix + " " + task + "\""

// pass the result of the script, we suppress the newline character in the output

print(outputString, terminator:"")
