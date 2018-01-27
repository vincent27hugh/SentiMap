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
    state = {}        
    for i in range(0,len(sent_list)-1,2):
        dictionary[sent_list[i]] = int(sent_list[i+1])
        
    for line in tweet_file:
        data.append(json.loads(line))

    for i in range(len(data)):
        count = 0
        if(data[i].has_key('text')):
            tweet = data[i]['text']
            tweet_list = tweet.split()
            
            for j in tweet_list:
                if j in dictionary:
                    count += dictionary[j]
        if(data[i].has_key('place')):
            if(data[i]['place']):
                if(data[i]['place']['country_code'] == "US"):
                    if(data[i].has_key('user')):
                        if(data[i]['user']['location']):
                            loc = data[i]['user']['location']
                            state_list = loc.split(", ")
                            if(len(state_list)>1):
                                if(len(state_list[1])==2):
                                    if state_list[1] in state:
                                        state[state_list[1]] += count
                                    else:
                                        state[state_list[1]] = count
    for i in state:
        max = state[i]
        break
    for i in state:
        if(state[i] > max):
            max = state[i]
    for i in state:
        if(state[i]==max):
            print i
    
    tweet_file.close()
    sent_file.close()
    
if __name__ == '__main__':
    main()
