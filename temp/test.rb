require 'yaml'
require 'pp'

compose_file = "docker-compose.yml"
compose = YAML.load_file(compose_file)
compose.each do |k, v|
  v.each do |k2, v2|
    if k2 == "restart"
      compose[k].delete(k2)
    end
    puts "#{k2} / #{v2} \n\n"
  end

end
