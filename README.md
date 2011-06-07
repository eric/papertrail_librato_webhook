# Papertrail Silverline Webhook #

Initial work on a webhook to send metrics to Silverline from Papertrail.

## Webhook endpoint ##

The webhook endpoint is `/submit`. It only accepts `POST`.


## Parameters for customization ##

The parameters it takes are:

* `user`: The email address you have registered with Silverline
* `token`: Your Silverline API token
* `name`: The name of the gauge to use

An example URL would be:

    http://papertrail-silverline-webhook.heroku.com/submit?name=twitter.stars&user=eric%40sevenscale.com&token=9958e97ca21114f2efe74ad6f978fa89db7ecb4d


## Using on Papertrail ##

I have an instance currently running on 
http://papertrail-silverline-webhook.heroku.com/ .

The webhook endpoint is:

    http://papertrail-silverline-webhook.heroku.com/submit

