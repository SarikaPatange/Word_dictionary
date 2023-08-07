require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  erb(:search_word)
end

get("/search_meaning") do
  @search_word = params.fetch("search_word").to_s
  @dictionary_url = "https://api.dictionaryapi.dev/api/v2/entries/en/"+@search_word
  @raw_response = HTTP.get(@dictionary_url)
  @parsed_response = JSON.parse(@raw_response)
  @raw_response_array = @parsed_response.at(0)
  @meanings_hash = @raw_response_array.fetch("meanings")
  @definition_array = @meanings_hash.at(0)
  @definition_hash = @definition_array.fetch("definitions")
  @definition_array1 = @definition_hash.at(0)
  @definition_hash2 = @definition_array1.fetch("definition")

  erb(:search_word_results)
end
