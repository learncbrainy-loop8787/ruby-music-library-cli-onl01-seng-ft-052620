require 'pry'

class MusicLibraryController

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    input = ""
    until input == "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'." 
      puts "To list all of the songs of a particular genre, enter 'list genre'." 
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'." 
      puts "What would you like to do?"
      input = gets.chomp
      case input
      when "list songs"
        list_songs
      when "list artists" 
        list_artists
      when "list genres"
        list_genres
      when "play song"
        play_song
      when "list artist"
        list_artist
      when "list genre"
        list_genre
      
      end
    end
  end
  def list_songs
    Song.all.sort{ |a, b| a.name <=> b.name } .each_with_index {|song,index|puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end
  
def list_artists
    Artist.all.sort{|a, b| a.name <=> b.name}.each_with_index do |artist, index|
      puts "#{index+1}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort{|a, b| a.name <=> b.name}.each_with_index do |genre, index|
      puts "#{index+1}. #{genre.name}"
    end
  end

  def play_song
    song = Song.all[gets.to_i - 1]
    puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    specific_artist = gets.chomp
    if Artist.find_by_name(specific_artist) != nil
      Artist.find_by_name(specific_artist).songs.sort{|a, b| a.name <=> b.name}.each_with_index {|song,index| 
      puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
    else
  #    puts "Artist does not exist"
    end
  end

  def list_genre
    puts "Enter genre"
    specific_genre = gets.chomp
    if Genre.find_by_name(specific_genre) != nil
      Genre.find_by_name(specific_genre).songs.each {|song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
    else
      puts "Genre does not exist"
    end
  end

end