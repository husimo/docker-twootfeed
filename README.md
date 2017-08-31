# husimo/twootfeed

A simple python alpine container configured to run twootfeed script.

You just have to set your parameters in `docker-compose.yml` : 

```yaml
version: "3"
services:
  twootfeed:
    build: .
    ports:
      # You can change to "1234:5000" if you don't want to use 5000.
      - "5000:5000"
    environment:
      # URL of your mastodon instance
      - API_BASE_URL=https://mamot.fr
      # Email used by your account
      - EMAIL=xxxx
      # Password
      - PASSWORD=xxxx
```

Then, launch your container : 

```
$ docker-compose up -d
```

# python-twootfeed
**Python script to generate a rss feed from parsed Twitter or Mastodon search, using Flask.**  

The RSS feed displays only the original tweets (not the retweets) and :
- links to :  
  -- the original tweet on Twitter or toot on Mastodon
  -- hashtags  
  -- usernames  
- URLs 
- images (only for Twitter for now)
- source  (only for Twitter for now)
- location  (only for Twitter)
- numbers of retweets (or reblogs for Mastodon) and favorites  
  (see examples below).  

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/14d1c00121c04cd2b81453c597639ca6)](https://www.codacy.com/app/SamR1/python-twootfeed?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=SamR1/python-twootfeed&amp;utm_campaign=Badge_Grade)

## **Requirements :**
- Python 3 (tested with 3.6)
- [Flask](http://flask.pocoo.org/)
- [Feedgenerator](https://pypi.python.org/pypi/feedgenerator)
- [Tweepy](https://github.com/tweepy/tweepy)
- [pytz](https://pypi.python.org/pypi/pytz/)
- [BeautifulSoup](https://pypi.python.org/pypi/beautifulsoup4)
- [Mastodon.py](https://github.com/halcy/Mastodon.py)
- API keys Twitter and/or Mastodon 

  ​
## **Steps :**
- install Python packages : flask, BeautifulSoup, Mastodon.py, feedgenerator, tweepy and pytz
```bash
$ pip3 install flask bs4 feedgenerator tweepy pytz Mastodon.py
```

- clone this repo :
```bash
$ git clone https://github.com/SamR1/python-twootfeed.git
```

- API Keys
    - for **Twitter** : see https://dev.twitter.com  
      copy/paste the Twitter API key values in **config.yml.example** ('_consumerKey_' and '_consumerSecret_')
    - for **Mastodon** : see [Python wrapper for the Mastodon API](https://github.com/halcy/Mastodon.py)  
       - generate client and user credentials files :  
        ```python
        from mastodon import Mastodon
        
        # Register app - only once!        
        Mastodon.create_app(
             'pytooterapp',
              to_file = 'tootrss_clientcred.txt'
        )        
        
        # Log in - either every time, or use persisted        
        mastodon = Mastodon(client_id = 'tootrss_clientcred.txt')
        mastodon.log_in(
            'my_login_email@example.com',
            'incrediblygoodpassword',
            to_file = 'tootrss_usercred.txt'
        )
        ```
        - copy/paste file names in **config.yml.example** ('_client_id_file_' and '_access_token_file_')

Rename the config file **config.yml**.

- Start the server
```bash
$ export FLASK_APP=app.py
$ python3 -m flask run --host=0.0.0.0
```

- the RSS feeds are available on these urls :  
   - for Twitter : http://localhost:5000/_keywords_ or http://localhost:5000/tweets/_keywords_
   - for Mastodon : http://localhost:5000/toots/_keywords_

## Examples :  
### Search on Twitter :  
![Twitter search](images/twitter.png)  

Results in RSS Feed :  
![RSS Feed](images/RSSFeed.png)  

Display on FreshRSS, a great free self-hosted aggregator (https://github.com/FreshRSS/FreshRSS):    
![FreshRSS](images/FreshRSS.png)  

### Search on Mastodon : 
![Mastodon search](images/mastodon.png)

Results in RSS Feed :  
![Mastodon Feed](images/MastodonRSSFeed.png) 

Display on FreshRSS :
![Mastodon FreshRSS](images/MastodonFreshRSS.png)  

## **Todo :**
- [ ] handle the tweeperror "Rate limit exceeded" #2
- [ ] handle the different exceptions properly 
