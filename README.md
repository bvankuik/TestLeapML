# TestLeapML

This is a demo app that allows you to play around with the [LeapML](https://www.leapml.dev/)
API. See also the [API documentation](https://docs.leapml.dev/).

The logo is a still life with a cabbage. This image was generated with the app.

![Logo of still life with a cabbage](https://raw.githubusercontent.com/bvankuik/TestLeapML/main/logo_still_life_with_a_cabbage.png?raw=true)

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

* No way of searching
* Prompts should be typed in, but perhaps there's a faster way, like in
  [this article](https://sowenjub.me/writes/searchable-vs-textfield-in-a-sheet-deployed-with-presentationdetents)
* When a job is queued, we should periodically refresh; perhaps with Combine?
* There should be a share button for images
* Layout on macOS/iPad is bad
* Some sort of loading indicator should be shown when generating images and loading them
* Fastlane is useful
* Errors are logged but not reported to the user

