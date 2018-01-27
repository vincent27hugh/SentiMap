import sys
import json
from operator import itemgetter
def main():
    tweet_file = open(sys.argv[1],"r")

    hashtags = {}
    data = []
            
    for line in tweet_file:
        data.append(json.loads(line))
    count = 0.0
    for i in range(len(data)):

        if(data[i].has_key('entities')):
            if(data[i]['entities'].has_key('hashtags')):
                if(data[i]['entities']['hashtags']):
                    if(data[i]['entities']['hashtags'][0].has_key('text')):
                        string = data[i]['entities']['hashtags'][0]['text']
                        
                        if string in hashtags:
                            hashtags[string]+= 1.0
                        else:
                            hashtags[string] = 1.0
    hashtags = sorted(hashtags.items(),key=itemgetter(1))
    for i in range(len(hashtags)-10,len(hashtags)):
       print str(hashtags[i][0].encode('utf-8')),hashtags[i][1]

    tweet_file.close()

    
if __name__ == '__main__':
    main()
