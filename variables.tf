variable "aws_region" {
  default = "us-west-2"
}

variable "instance_type" {
  default = "t3.nano"
}

variable "key_name" {
  default = "movienight"
}

variable "ssh_username" {
  default = "ubuntu"
}

variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3ALdHROdfkDMvCP1/Cu/sYzNF0G7jvLpkWfQg17xF+Z9Q2G4Pl/G5B+Bdoln+YfCJWSaL2rVGLeUEjb/SRpBveHuWG5jXh0/yGhO4/37aSL2Q2/JEabKhmDCzOqeIlQpkT0Vak23JrQPldu40KGbd55Q7wB7dSg6Cy3Jn0k50PlRqUoitpp3i3wRxyhnP+WagvHagGT/Wp8LV/9L1x1pDRQGo4iQsXcp4UexdzLhcgY92rouuGpm15Ui3cuxA3vjijRSFdBMkY+D9Ul8Ep0qiaHwXbw66Clt2XnFcyYCqt2vKkslWhWOAhwRkiFfaP5ICmXTWJRxnpsFcc1PLI/Y+GS9TG/h9GmS/w6ClcpBnU+Abaf3xw8j8aZ/rWUcbC5O897V08hVYoKy8zZsi5RriysZR5K2xlsBY8Z5zQQwg+M9DeIrQHjwrH/lTSwTFPFJthQcccg8r+pnrCCjeHHQ3/sUtSIMIUeUUiO/dhPIzDt+Si4jnWDltXLcMm0n496Gx0LpHk6hOfXnfX+Cy6tvLS7pVXz9R94eKRWipL49yl1BubK0wAu4sbJXfguXXOa+XrXIzeB8Qn7tv/7nX0IUu3Ho1tiZ2zacGYjaxuaCNAqyLXeEOJytRBEGbZbrG8iAZ8zl/A0LIiZOrAkKG2YOIeW3lEj9HmRW5rn6w20fYSw=="
}

variable "route53_domain" {
  default = "pookflix.com"
}

variable "route53_domain_id" {
  default = "Z3KWZLYIS252KU"
}
