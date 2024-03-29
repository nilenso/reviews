# Reviews

- Rails app to do internal reviews at Nilenso.

### Dev setup
```bash
rbenv install 2.7.2
gem install bundler
bundle install
```

### Deployment guide
* Create an app on Heroku.
* Add the Heroku Postgres add-on under the Resources tab.
* Go to the Deploy tab and set the Heroku git remote as instructed.
* Log in to https://console.developers.google.com using your nilenso e-mail.
* Create a project under the nilenso organization, to manage OAuth credentials for the app.
* Enable the Contacts API and the Google+ API for the project.
* Under the Credentials tab, create a new "Client ID for Web Application".
* You'll be asked to enter the authorized Javascript origin and the redirect URI. The redirect path
for the app is `/users/auth/google_oauth2/callback`. Thus, the redirect URI will look something like
`http[s]://domain.com/users/auth/google_oauth2/callback`.
* After you save, you will be presented with a client ID and a client secret. On the Heroku
dashboard under Settings, add the `google_client_id` and `google_client_secret` config variables.
* Run `bundle exec rake secret` to generate a secret key. On the Heroku dashboard, add it under the
`secret_key_base` config variable.
* Run `git push heroku master` to deploy. That's it!

#### Since 2019

* We use heroku Review Apps (not to be confused with the name of this repo itself) to generate new installs of the reviews apps
* This is done by making a pull request on this repo, which in turn auto-creates a new instance for the app
* For consistency, please name these PRs as "create-new-for-<year>"


#### Since March 2022
* We have shifted to use render.com since Heroku became unusable in India.
* The steps for creating a new install for this app are the same. Refer to "Since 2019" section of this README.