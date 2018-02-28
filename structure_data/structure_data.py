'''
Time: 20180228
Author: Kai Yang
Function: To load and structurize twitter data, then generate a CSV file.
'''
import sys
import json
import re
import csv
import pdb
import chardet

#load twitter & sentiment file data
#input: path of twitter & sent_file
#output: data ([{attr: value},...]), sent_dir ({sent_word: sent_value})
def load_data(sent_file_path, tweet_file_path):
	#output
	data = []
	sent_dir = {}
	sent_file = open(sent_file_path,"r")
	tweet_file = open(tweet_file_path,"r")
	
	sent_string = str(sent_file.read())
	sent_list = re.split('\t|\n',sent_string)
	
	for i in range(0,len(sent_list)-1,2):
		sent_dir[sent_list[i]] = int(sent_list[i+1])

	for line in tweet_file:
		line = line.strip()
		data_item = json.loads(line)
		if data_item.has_key("delete"):
			continue
		data.append(json.loads(line))
		
	return data, sent_dir

#sentiment analysis
def sentiment_analysis(tweet, sent_dir):
	tweet_list = tweet.split()
	
	count = 0
	
	for j in tweet_list:
		if j in sent_dir:
			count += sent_dir[j]
			
	return count


#generate file
def generate_file(sent_file_path, tweet_file_path):
	data, sent_dir = load_data(sent_file_path, tweet_file_path)
	twitter_keys_set = set(data[0].keys()) | set(['sentiment'])
	user_keys_set = set(data[0]['user'])
	fieldnames_set = twitter_keys_set | user_keys_set
	fieldnames_set = fieldnames_set - set(['user', 'entities', 'text', 'name', 'retweeted_status', 'description', 'coordinates', 'geo'])
	
	#generate file with text
	
	with open("\\".join(sys.argv[0].split("\\")[:-1]) + "\\twitter_file_with_text.csv", "wb") as csvfile:
		writer = csv.DictWriter(csvfile, fieldnames=list(fieldnames_set))
		
		writer.writeheader()
		for data_item in data:
			
					
			#writer.writerow(data_item['user'])
			input_dir = data_item
			input_dir = dict(input_dir.items() + data_item['user'].items())
			
			input_dir['sentiment'] = sentiment_analysis(data_item['text'], sent_dir)
			
			input_dir = {f:input_dir[f] for f in fieldnames_set if f in input_dir}
			
			for f in input_dir:
				if isinstance(input_dir[f], (str, unicode)):
					input_dir[f] = input_dir[f].encode("utf-8").replace(",", "").replace("\n", "")
					#print chardet.detect(input_dir[f])['encoding']
			
			writer.writerow(input_dir)
	

		
	
	pass

if __name__ == "__main__":
	root_path = "\\".join(sys.argv[0].split("\\")[:-2])
	sent_file_path = root_path + "\\twitter_sentiment_analysis\\data\\AFINN-111.txt"
	tweet_file_path = root_path + "\\twitter_sentiment_analysis\\data\\tweet_sample.json"
	generate_file(sent_file_path, tweet_file_path)

	pass