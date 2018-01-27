import sys
import json

def main():
    tweet_file = open(sys.argv[1],"r")

    dictionary = {}
    data = []
            
    for line in tweet_file:
        data.append(json.loads(line))
    count = 0.0
    for i in range(len(data)):

        if(data[i].has_key('text')):
            tweet = data[i]['text']
            tweet_list = tweet.split()
            count += float(len(tweet_list))
            for i in tweet_list:
                if i in dictionary:
                    dictionary[i] += 1.0
                else:
                    dictionary[i] = 1.0
            
    for i in dictionary:
        dictionary[i] = dictionary[i]/count
        print str(i.encode('utf-8')),dictionary[i]    

    tweet_file.close()

    
if __name__ == '__main__':
    main()
