# MovieNight Deploy

A terraform based deploy for Movie Night (https://github.com/zorchenhimer/MovieNight).

## Deploy
Before deploying, generate a random key with the character set:
\[a-zA-Z0-9-_\]+
This will be the private key you use in OBS.
Place this key in the file "movie_night.service"
### Instance Options
This deploys as a a1.medium, however it can be deployed as a a1.medium by updating the variables to:
```
variable "aws_image" {
  # this is Ubuntu 19.10 for arm
  default = "ami-0e2b33aeed6565ce7"
}
variable "instance_type" {
  # requires a arm to run
  default = "a1.medium"
}
```
