# Twitter Sentiment Analysis in Python
This project has an implementation of estimating the sentiment of a given tweet based on sentiment scores of terms in the tweet (sum of scores). The AFINN-111 list of pre-computed sentiment scores for English words/pharses is used.

## Derive sentiment of each tweet (tweet_sentiment.py)
This script prints to stdout the sentiment of each tweet in a given file, where the sentiment is computed by summing the sentiment scores of words/phares in the tweet taken from the AFINN-111 list, but if not present in the list it is given a sentiment score of 0.

The script can be executed using the following command:
```
python tweet_sentiment.py <sentiment_file> <tweet_file>
```
The tweet_file contains data formatted in the same way as the livestream data.

## Derive sentiment of new terms (term_sentiment.py)
This script computes the sentiment for terms that do not appear in the AFINN-111 list. The intuition is that once we use certain words/phrases to deduce the sentiment of a tweet, we can assign this sentiment score to other words in the tweet not present in the AFINN-111 list.

The script can be executed using the following command:
```
python term_sentiment.py <sentiment_file> <tweet_file>
```

## Which state is happiest in the U.S? (happiest_state.py)
This script determines the happiest state based on the sum total of the sentiment scores of the tweets originating from that state. The tweets are limited to the ones in the United States using the location information encoded with the tweet.

The script can be executed using the following command:
```
python happiest_state.py <sentiment_file> <tweet_file>
```

## Top ten hash tags (top_ten.py)
This script computes the ten most frequently occuring hash tags from the data in the tweet_file.

The script can be executed using the following command:
```
python top_ten.py <tweet_file>
```
