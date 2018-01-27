import sys
import json
import re

def main():
    sent_file = open(sys.argv[1],"r")
    tweet_file = open(sys.argv[2],"r")

    dictionary = {}
    sent_string = str(sent_file.read())
    sent_list = re.split('\t|\n',sent_string)
    data = []
            
    for i in range(0,len(sent_list)-1,2):
        dictionary[sent_list[i]] = int(sent_list[i+1])
        
    for line in tweet_file:
        data.append(json.loads(line))
    nonterm = {}
    for i in range(len(data)):
        count = 0
        if(data[i].has_key('text')):
            tweet = data[i]['text']
            tweet_list = tweet.split()
            
            for i in tweet_list:
                if i in dictionary:
                    count += dictionary[i]
            
            for i in tweet_list:
                if i not in dictionary:
                    nonterm[i] = float(count)
                        
#            print float(count)
    for i in nonterm:
        print str(i.encode('utf-8')),nonterm[i]
    tweet_file.close()
    sent_file.close()
    
if __name__ == '__main__':
    main()
