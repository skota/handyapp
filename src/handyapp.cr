# require "option_parser"
require "file_utils"
require "toml"
require "colorize"

toml = TOML.parse(File.read("settings.toml"))
source = toml["source"].as(Hash)
source_folders = source["source_folder"].as(Array)

target = toml["cleanup_folders"].as(Hash)
target_folders = target["remove_list"].as(Array)

source_folders.each do |source_folder|
  src_folder = source_folder.to_s
  Dir.cd(src_folder)
  list = Dir.glob("*")

  list.each do |f|
    target_folders.each do |target|
      target = target.to_s
      if Dir.exists?(src_folder+"/"+target)
        str = "Found #{target} in #{src_folder} "
        puts str.colorize.green
        FileUtils.rm_r(src_folder+"/"+target)
        puts ": deleted #{target}".colorize.blue
      end  
    end  
  end
end 