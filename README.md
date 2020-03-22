# MovieNight Deploy

A terraform based deploy for Movie Night (https://github.com/zorchenhimer/MovieNight).

## Deploy
Before deploying, generate a random key with the character set:
\[a-zA-Z0-9-_\]+
This will be the private key you use in OBS.
Place this key in the file "movie_night.service"
### Instance Options
This deploys as a a1.medium, however it can be deployed as a t3.small by updating the variables. See the vars file for more info

### iPhone Redirection
Due to limitations, iPhones cannot correctly display the stream. There is a redirect in the movie_night.conf config to redirect iPhone users to a page (by default example.com)

If you want you can redirect to a static page that informs users to switch to either a computer or iPad.

