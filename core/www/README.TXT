The .htaccess file in reason_package directs any web request as follows:

First try www/core/*

If that doesn't exist, try www/local/*

Apache should not need to write anywhere within the www folder.
