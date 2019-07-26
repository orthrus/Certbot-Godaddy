# Certbot GoDaddy Wildcard scripts

These scripts allow the creation of Let's Encrypt wildcard certificates on GoDaddy managed domains. Certificates created using these scripts will have the Common Name (CN) set to the wildcard domain (e.g. "*.example.com") and a Subject Alternative Name (SAN) for the root domain (e.g. "example.com").

Note that these scripts require storing the credentials to the GoDaddy API on your server, which is generally not a very good idea.

## Usage
- Enter you [GoDaddy API](https://developer.godaddy.com/keys) and domain information in the api-settings.sh file
- [OPTIONAL] Edit the certbot-renew-post-hook.sh script to execute actions after renewing a certificate (e.g. nginx reload)
- Request a new certificate by calling the certbot-godaddy-request.sh script
	- ```/path/to/certbot-godaddy-request.sh```
- Create a daily cronjob to automatically renew your certificate:
	- ```0 4 * * * /path/to/certbot-godaddy-renew.sh```
- Modify the permissions of the api-settings.sh file so only the user running the cronjob is able to read it
	- ```chown root:root /path/to/api-settings.sh```
	- ```chmod 600 /path/to/api-settings.sh```


Your new certificate should be stored in /etc/letsencrypt/live/[DOMAIN]/
