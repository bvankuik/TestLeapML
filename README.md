# TestLeapML

This is a demo app that allows you to play around with the [LeapML](https://www.leapml.dev/)
API. See also the [API documentation](https://docs.leapml.dev/).

# Current capabilities

* Request an image
* List all results
* View a single result

# Install and build

First create an API key by [signing up](https://www.leapml.dev/signup). 

Then create a file called Config.xcconfig in the root directory of the project, and add the key:

    API_KEY = YOUR-KEY-HERE-0123456789012345678901

# Shortcomings

* No SwiftLint
* No documentation
* No fastlane
* print() statements all over the place
* When a job is queued, we should not navigate
* Errors are thrown and not reported
