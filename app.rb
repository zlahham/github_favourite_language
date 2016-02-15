require 'json'
require 'curl'

puts "\nWelcome to the unofficial favourite programming language checker for Github\n"
puts "Please enter a the Github username that you would like to check:\n"

user_name = gets.chomp
curl = CURL.new
user_name_status = curl.get("https://api.github.com/users/#{user_name}")

while user_name_status == "{\"message\":\"Not Found\",\"documentation_url\":\"https://developer.github.com/v3\"}"
  puts "The username you are looking for is invalid, please try again"
  user_name = gets.chomp
  user_name_status = curl.get("https://api.github.com/users/#{user_name}")
end

all_repos_json = curl.get("https://api.github.com/users/#{user_name}/repos")
all_repos_hash = JSON.parse(all_repos_json)

users_languages = []

all_repos_hash.each do |repo|
  repo_name = repo["name"]
  languages_json = curl.get("https://api.github.com/repos/#{user_name}/#{repo_name}/languages")
  languages_hash = JSON.parse(languages_json)
  if languages_hash.empty?
    next
  else
    main_lang = languages_hash.first.first
    users_languages << main_lang
  end

end


puts "This is #{user_name}'s favourite language!"
p users_languages

