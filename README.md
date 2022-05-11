# LogSwift

LogSwift is a lightweight library which allows you not to be crazy with logging in your apps, but stay flexible.



## How to use

```swift

// Register and use

Logger.addDestination(.debugArea)
Logger.addDestination(.file(logFilePath: logFileURL))

Log(.error) {
	"Some error"
	error
	reponse
	data
}


```


## Requirements

ReactSwift supports **iOS 11 and up**, and can be compiled with **Swift 4.2 and up**.



## Installation

### Swift Package Manager

The ReactSwift package URL is:

```
`https://github.com/alobanov11/LogSwift`
```



## License

LogSwift is licensed under the [Apache-2.0 Open Source license](http://choosealicense.com/licenses/apache-2.0/).

You are free to do with it as you please.  We _do_ welcome attribution, and would love to hear from you if you are using it in a project!
