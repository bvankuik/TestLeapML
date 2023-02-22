# TestLeapML

This is a demo app that allows you to play around with the [LeapML](https://www.leapml.dev/)
API. See also the [API documentation](https://docs.leapml.dev/).

# Current capabilities

* Request an image
* List all results
* View a single result

# Building and running

First create an API key by [signing up](https://www.leapml.dev/signup). 

Then create a file called Config.xcconfig in the root directory of the project, and add the key:

    API_KEY = YOUR-KEY-HERE-0123456789012345678901

If you don't have this file, Xcode will emit the following error:

    Config.xcconfig:1:1 unable to open configuration settings file

If you see the following line in the Xcode console, there's something wrong with the API key:

    2023-02-22 11:45:25.604125+0100 TestLeapML[5371:134771] Server error 401

# Shortcomings

* There's a weird info.plist warning when compiling
* Automatic  refresh upon startup is missing
* Some sort of loading indicator should be shown
* When a job is queued, we should indicate this, and not navigate
* We should use SwiftLint
* Fastlane is useful
* print() statements all over the place
* Errors are thrown and not reported
