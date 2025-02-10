require 'find'
require 'digest'
require 'fileutils'

def collect_files(path, mask)
  matching_files = {}
  pole = []
  filtered = {}


  # Recursively find files matching the mask
  Find.find(path) do |file|
    test = file if File.file?(file) && File.fnmatch(mask, File.basename(file))
    if test != nil
      hash = Digest::MD5.file(test).hexdigest
      #puts hash
      #puts test
      if matching_files.include?(hash)
        matching_files[hash] << test
      else
        matching_files[hash] = [test]
      end
    end
  end

  matching_files
end

# Example Usage
path = "C:/work/modulesro/test-same-hash" # Change this to your target directory
mask = "*.bin" # Change this to your desired file mask (e.g., "*.txt", "*.log", etc.)

files = collect_files(path, mask)



puts ARGV[1]
puts "Matching files:"

for file in files
  if file[1].length > 1
    #puts file
    pracovny = file[1]
    #puts pracovny[0]
    #puts pracovny[1]
    for i in 0..pracovny.length - 1
       for j in (i+1)..pracovny.length - 1
         puts pracovny[i] + " " + pracovny[j]
         if File.size(pracovny[i]) === File.size(pracovny[j]) && FileUtils.identical?(pracovny[i], pracovny[j]) == true
           puts "duplikat"
         end
       end
     end
  end
end
#puts files
