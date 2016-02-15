require 'json'
require 'curl'

class FavouriteLanguage
  def initialize
    @curl = CURL.new
    @users_languages = []
    @token = ENV["FAV_LANG"]
    @user_name = ""
  end

  def initial_messages
    puts "\nHi there! I'm the the unofficial oracle of Github.\nI'm going to find out the favourite programming language for any Github user!\n"
    puts "Please enter a the Github username that you would like me to check:\n"
  end

  def name_checker
    @user_name = gets.chomp
    user_name_status = @curl.get("https://api.github.com/users/#{@user_name}?access_token=#{@token}")
    while user_name_status == "{\"message\":\"Not Found\",\"documentation_url\":\"https://developer.github.com/v3\"}"
      puts "\n Hmmm... Looks like the username you are looking for is invalid, please try again"
      @user_name = gets.chomp
      @user_name_status = @curl.get("https://api.github.com/users/#{@user_name}?access_token=#{@token}")
    end
  end

  def create_repo_hash
    user_repos_json = @curl.get("https://api.github.com/users/#{@user_name}/repos?access_token=#{@token}")
    JSON.parse(user_repos_json)
  end

  def patience_message
    puts "\nThis might take a few seconds... please bear with me :)\n"
  end

  def fill_language_array
    hash = create_repo_hash
    hash.each do |repo|
      repo_name = repo["name"]
      languages_json = @curl.get("https://api.github.com/repos/#{@user_name}/#{repo_name}/languages?access_token=#{@token}")
      languages_hash = JSON.parse(languages_json)
      next if languages_hash.empty?
      main_lang = languages_hash.first.first
      @users_languages << main_lang
    end
  end

  def count_languages
    lang_count = @users_languages.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }
    lang_count.sort { |a, b| b[1] <=> a[1] }
  end

  def final_message(langs)
    puts "\n\nThis is #{@user_name}'s favourite language!"
    puts langs.first[0]
  end
end

fav_lang = FavouriteLanguage.new
fav_lang.initial_messages
fav_lang.name_checker
fav_lang.patience_message
fav_lang.fill_language_array
langs = fav_lang.count_languages
fav_lang.final_message(langs)
