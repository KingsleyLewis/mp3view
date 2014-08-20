require 'mp3info'
require 'fileutils'
require 'shellwords'

Dir.glob("/mnt/sdb1/Music/*.mp3", File::FNM_CASEFOLD) do |f|
  Mp3Info.open(f) do |mp3info|
    #binding.pry
    if mp3info.hastag1?
      mp3 = mp3info.tag1
    elsif mp3info.hastag?
      mp3 = mp3info.tag
    elsif mp3info.hastag2?
      mp3 = mp3info.tag2
    else
      next
    end
    next if mp3.artist.nil?
    next if mp3.title.nil?
    artist = mp3.artist
    title = mp3.title
    new_dir = "/mnt/sdb1/Music/#{artist}/"
    p new_dir
    FileUtils.mkdir(new_dir) unless Dir.exists? new_dir
    FileUtils.move(mp3info.filename, new_dir+title+".mp3")
  end
end
