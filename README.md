#Favourite Language Checker

This is a command line program that allows you to enter the username of a Github profile, which then returns that users "favourite" programming language.

Summary
-------

Favourite languages, in this case means that this is the most used language by that particular User. 
Also, bear in mind that this is according to the public repos only.


Installation
------------

```
git clone https://github.com/zlahham/github_favourite_language.git

cd github_favourite_language

bundle

```

Usage
-----
In order to get access to Github's API increased limit of 5000 requests, you must do the following steps:
- Go to your Github account settings
- Select the "Personal access tokens" tab
- Click on "Generate new token"
- Fill in the "Token description" field and then generate the token
- COPY the number that you will then see and keep it safe for the next step
- Create an environment variable that can be accessed from your $PATH and call it `FAV_LANG`
- A sample of how it should look: `export FAV_LANG=THISISADUMMYACCESSTOKEN`
- After you are done, make sure to restart your terminal or just call `source ~/.bash_profile` or its equivalent on your system
- Fire up the app with `ruby app.rb`


