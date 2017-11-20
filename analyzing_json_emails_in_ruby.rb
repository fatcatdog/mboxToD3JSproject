require 'json'
# create a variable for our clunkly json file
  data = File.read('json_emails.json')
# create a ruby hash to store our json which will make it more easily navigateable
  ruby_hash = JSON.parse(data)
  email_addresses_hash = Hash.new(0)

# convert messy sender titles to plain old email addressess in a ruby hash

  changing_email_index = 0
  while changing_email_index < ruby_hash.length
    real_senders = ruby_hash[changing_email_index]["Sender"]
  if real_senders.rindex("<") != nil
    start = real_senders.index("@")
    last = real_senders.rindex(">")
    temp_email_address_we_need_to_store = real_senders[start...last]
    email_addresses_hash[temp_email_address_we_need_to_store] += 1
    changing_email_index += 1
  else
    changing_email_index += 1
  end
  end



freq_of_email_senders  = email_addresses_hash.sort_by {|actual_email_address, amount_of_times_emailed| amount_of_times_emailed }
  # to view email addresses sorted by frequency of times emailed uncomment the line below
  # print freq_of_email_senders





# counting most common words in the subject lines
  dictionary_of_words_from_subject_lines = Hash.new(0)

  email_index_for_subject_lines = 0
  while email_index_for_subject_lines < ruby_hash.length
    real_subject = ruby_hash[email_index_for_subject_lines]["Subject"]
    words = real_subject.downcase.split(" ")
    words.each do |add_to_dic_count|
      if add_to_dic_count.gsub(/\W+/, '') != ''
        dictionary_of_words_from_subject_lines[(add_to_dic_count.gsub(/\W+/, ''))] += 1
      end
    end
    email_index_for_subject_lines += 1
  end
most_of_our_words_and_how_often_used = dictionary_of_words_from_subject_lines.select {|actual_word, freq_of_word| freq_of_word > 5}.sort_by { |actual_word, freq_of_word| freq_of_word }
# to see the most common words used in subject lines (of at least 5 times used) uncomment the line below
# print dictionary_of_words_from_subject_lines.select {|actual_word, freq_of_word| freq_of_word > 10}.sort_by { |actual_word, freq_of_word| freq_of_word }


# organize times, and try sort what hour they were sent in

times_in_seconds = []
time_index = 0

while time_index < ruby_hash.length
unformatted_time = ruby_hash[time_index]["Time_Sent"]
if !unformatted_time.include?(":")
  time_index += 1
else
  start = unformatted_time.index(":")
  slightly_more_formatted_time = 0

  if (unformatted_time[(start - 2)...(start)]).to_i > 0
    number_post_math = unformatted_time[(start - 2)...(start)].to_i
    number_post_math *= 3600
    slightly_more_formatted_time += number_post_math
  end

  if (unformatted_time[(start + 1)...(start + 3)]).to_i > 0
    number_post_math = unformatted_time[(start + 1)...(start + 3)].to_i
    number_post_math *= 60
    slightly_more_formatted_time += number_post_math
  end

  if (unformatted_time[(start + 4)...(start + 6)]).to_i > 0
    number_post_math = unformatted_time[(start + 4)...(start + 6)].to_i
    slightly_more_formatted_time += number_post_math
  end

    times_in_seconds << slightly_more_formatted_time
    time_index += 1
  end
end

all_of_our_times_in_seconds = times_in_seconds.sort
# to see all of the times in seconds just uncomment the line below
# print all_of_our_times_in_seconds

time_hour_hash = {"12AM" => 0, "1AM" => 0, "2AM" => 0, "3AM" => 0, "4AM" => 0, "5AM" => 0, "6AM" => 0, "7AM" => 0, "8AM" => 0, "9AM" => 0, "10AM" => 0, "11AM" => 0, "12PM" => 0, "1PM" => 0, "2PM" => 0, "3PM" => 0, "4PM" => 0, "5PM" => 0, "6PM" => 0, "7PM" => 0, "8PM" => 0, "9PM" => 0, "10PM" => 0, "11PM" => 0}

times_in_seconds.each do |convert_to_hour_block|

if convert_to_hour_block < 3600
  time_hour_hash["12AM"] += 1
elsif convert_to_hour_block < 7200
  time_hour_hash["1AM"] += 1
elsif convert_to_hour_block < 10800
  time_hour_hash["2AM"] += 1
elsif convert_to_hour_block < 14400
  time_hour_hash["3AM"] += 1
elsif convert_to_hour_block < 18000
  time_hour_hash["4AM"] += 1
elsif convert_to_hour_block < 21600
  time_hour_hash["5AM"] += 1
elsif convert_to_hour_block < 25200
  time_hour_hash["6AM"] += 1
elsif convert_to_hour_block < 28800
  time_hour_hash["7AM"] += 1
elsif convert_to_hour_block < 32400
  time_hour_hash["8AM"] += 1
elsif convert_to_hour_block < 36000
  time_hour_hash["9AM"] += 1
elsif convert_to_hour_block < 39600
  time_hour_hash["10AM"] += 1
elsif convert_to_hour_block < 43200
  time_hour_hash["11AM"] += 1
elsif convert_to_hour_block < 46800
  time_hour_hash["12PM"] += 1
elsif convert_to_hour_block < 50400
  time_hour_hash["1PM"] += 1
elsif convert_to_hour_block < 54000
  time_hour_hash["2PM"] += 1
elsif convert_to_hour_block < 57600
  time_hour_hash["3PM"] += 1
elsif convert_to_hour_block < 61200
  time_hour_hash["4PM"] += 1
elsif convert_to_hour_block < 64800
  time_hour_hash["5PM"] += 1
elsif convert_to_hour_block < 68400
  time_hour_hash["6PM"] += 1
elsif convert_to_hour_block < 72000
  time_hour_hash["7PM"] += 1
elsif convert_to_hour_block < 75600
  time_hour_hash["8PM"] += 1
elsif convert_to_hour_block < 79200
  time_hour_hash["9PM"] += 1
elsif convert_to_hour_block < 82800
  time_hour_hash["10PM"] += 1
elsif convert_to_hour_block < 86400
  time_hour_hash["11PM"] += 1
end
end

time_blocks_sorted_by_frequency = time_hour_hash.sort_by {|time, quant| quant}
# to view the time blocks, sorted by frequency of business in terms of emails sent, uncomment the line below
# print time_blocks_sorted_by_frequency

# array of integers
  all_of_our_times_in_seconds
  # File.open("time_of_emails_sent_in_seconds.txt", "w+") do |f|
  #   all_of_our_times_in_seconds.each { |element| f.puts(element) }
  # end

# array of key value pairs: ["4PM", 267], maybe put this in json?
# i guess it already is, i pasted my 24 key value pairs, i put it in https://jsonlint.com/, says its valid json
# i just copied that and pasted it in a json file in our directory
  time_blocks_sorted_by_frequency

# check that no personal emails get published
# array of key value pairs: ["@gmail.com", 488], maybe put this in json?
# i put it in https://jsonlint.com/, says its valid json
# i just copied that and pasted it in a json file in our directory
  freq_of_email_senders

# array of key value pairs: ["job", 163], maybe put this in json?
# i put it in https://jsonlint.com/, says its valid json
# i just copied that and pasted it in a json file in our directory
   most_of_our_words_and_how_often_used

