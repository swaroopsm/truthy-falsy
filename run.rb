#!/usr/bin/env ruby

require "hirb"
require "json"

result = []
truthy_falsy_values = [ "empty_string", "true", "{}", "null", "nil", "undefined", "[]", "NaN", "zero", "false", "true", "None"]
lang_dirs = Dir.glob(File.expand_path("../src/*", __FILE__))
lang_dirs.each_with_index do |lang_dir, index|
  cmd = "#{lang_dir}/app"
  lang = lang_dir.split("/")[-1].upcase
  `"#{cmd}"`
  json_data = { LANG: lang }
  json_data.merge! JSON.parse(File.read("#{lang_dir}/result.json"))
  

  result << json_data
end

puts Hirb::Helpers::AutoTable.render(result,
                                     headers: {
                                       lang: "Language",
                                     } 
                                    )
