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
// To use two words insert \\ after the first word, eg: "Daily\\ Log"

let dayOneJournal = "log"

// the default tag(s) to add to all entries. If you don't
// add at least one default tag, you'll have to modify the code below.
// tags *can* have spaces

let defaultTags = ["dolog", "completed tasks"]

// the entry prefix

let entryPrefix = "completed task:"

/* ********************************* */


// requires Swift 4.0

//-- get parameter input
// `argument` holds the text entered in Alfred by the user
// I initialize it with an example of something the user could enter
// for testing. 

var argument = "-t workflow @Switched to Mailmate as my email client"
#if swift(>=4.0)
	if CommandLine.arguments.count > 1 {
		argument = CommandLine.arguments[1]
	}
#elseif swift(>=1.0)
	print("Unsupported version of Swift (<= 4.0) please update to Swift 4.0")
	break
#endif

// MARK: - Utilities

func replaceSpaces(in tag: String) -> String {
	return tag.replacingOccurrences(of: "_", with: "\\ ")
}

func removeSpecialCharacters(in tag: String) -> String {
	// escape special characters
	// ! ? $ % # & * ( ) blank tab | ' ; " < > \ ~ ` [ ] { }
	var returnedTag = tag
	returnedTag = returnedTag.replacingOccurrences(of: "!", with: "\\!")
	returnedTag = returnedTag.replacingOccurrences(of: "?", with: "\\?")
	returnedTag = returnedTag.replacingOccurrences(of: "$", with: "\\$")
	returnedTag = returnedTag.replacingOccurrences(of: "%", with: "\\%")
	returnedTag = returnedTag.replacingOccurrences(of: "#", with: "\\#")
	returnedTag = returnedTag.replacingOccurrences(of: "&", with: "\\&")
	returnedTag = returnedTag.replacingOccurrences(of: "*", with: "\\*")
	returnedTag = returnedTag.replacingOccurrences(of: "(", with: "\\(")
	returnedTag = returnedTag.replacingOccurrences(of: ")", with: "\\)")
	returnedTag = returnedTag.replacingOccurrences(of: "|", with: "\\|")
	returnedTag = returnedTag.replacingOccurrences(of: "'", with: "\\'")
	returnedTag = returnedTag.replacingOccurrences(of: ";", with: "\\;")
	returnedTag = returnedTag.replacingOccurrences(of: "<", with: "\\<")
	returnedTag = returnedTag.replacingOccurrences(of: ">", with: "\\>")
	returnedTag = returnedTag.replacingOccurrences(of: "\\", with: "\\\\")
	returnedTag = returnedTag.replacingOccurrences(of: "~", with: "\\~")
	returnedTag = returnedTag.replacingOccurrences(of: "`", with: "\\`")
	returnedTag = returnedTag.replacingOccurrences(of: "[", with: "\\[")
	returnedTag = returnedTag.replacingOccurrences(of: "]", with: "\\]")
	returnedTag = returnedTag.replacingOccurrences(of: "{", with: "\\{")
	returnedTag = returnedTag.replacingOccurrences(of: "}", with: "\\}")

	return returnedTag
}

// MARK: - Properties

// variable 'task' will hold the completed task passed in

var task  = ""

// `outputString` is the result of the script that will be passed to the CLI, 
// we initialize it with the Day One CLI command, setting the default journal
// and the default tags.

var outputString = "dayone2 --journal "

// MARK: - Process

// add journal name and default tags

outputString += dayOneJournal + " --tags "

for defaulTag in defaultTags {
	let tag = defaulTag.replacingOccurrences(of: " ", with: "\\ ")
	outputString += tag + " "
}

// MARK: - Process input

//-- Process tags if present, otherwise just pass the input

if argument.hasPrefix("-t") {
	
	// find the index of the tags separator
	
	if let endOfTags = argument.index(of: "@") {

		// Map the tags into an array. The first tag (index 0) will be the tag option marker (-t) and will be
		// omitted
		
		let tags = String(argument.prefix(upTo: endOfTags)).split(separator: " ").map{ String($0) }
		
		// Now process the task part to remove the end of tags marker
		
		// get the task part of the input
		
		let taskSection = String(argument.suffix(from: endOfTags))
		
		// find the index of the tags separator in this string (different than above)
		
		let endTagIndex = taskSection.index(of: "@")!
		
		// The task proper starts after the tags separator
		
		let tagIndex = taskSection.index(after: endTagIndex)

		// get the task
		
		task = String(taskSection.suffix(from: tagIndex))
		
		// Now we have the task, we then process and format the tags
		// Add the tags to the output string separated by spaces
		// skipping the first one which is the `-t` marker
			
		for tag in tags.dropFirst() {
			
			// first we process underscores (_) in tags to replace them with escaped spaces so they're
			// treated as a single tag
			
			var processedTag = replaceSpaces(in: tag)
			processedTag = removeSpecialCharacters(in: processedTag)

			// add this processed tag to the output string
			
			outputString += processedTag + " "
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
