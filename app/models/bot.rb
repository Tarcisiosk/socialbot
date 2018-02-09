class Bot < ApplicationRecord

  def self.search_words words 
    CLIENT.search(words, lang: "en").first.text 
  end

  def self.tweet status 
    CLIENT.update(status)
  end

  def self.follow_user name
    CLIENT.follow(name)
  end

  def self.find_tweet id
    CLIENT.status(id)
  end
end
