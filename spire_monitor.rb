require 'builder'
require 'sys/proctable'

PROCESSES_NAMES = %w(nginx mongrel_rails)

loop do
  
  date, time = Time.now.strftime("%d.%m.%Y %H:%M").split(' ')

  xml_dir_path = File.dirname(__FILE__) + "/xml"
  filename = xml_dir_path + "/#{date}.xml"

  Dir::mkdir(xml_dir_path) unless File.directory?(xml_dir_path)

  unless File.exists?(filename)
    xml = Builder::XmlMarkup.new :indent => 2
    xml.instruct!
    xml.spire_data{|sd|}
    File.open(filename, "a"){|f| f.write xml.target!}
  end

  xml = Builder::XmlMarkup.new :indent => 2
  xml.record :time => time do |x_r|
      Sys::ProcTable.ps do |p|
          if PROCESSES_NAMES.include? p['comm']
              x_r.process do |x_p|
                  pcpu,vsz,rssize = %x[ps -p #{p['pid']} -o pcpu,vsz,rssize | grep -v RSS].split(' ')
                  x_p.pid p['pid']
                  x_p.name p['comm']
                  x_p.pcpu pcpu
                  x_p.vsz vsz
                  x_p.rssize rssize
              end
          end
      end
  end

  File.open(filename, "r+") do |f|
      f.seek(-14, IO::SEEK_END)
      f.write xml.target!
      f.write "</spire_data>\n"
  end

  sleep(60)

end
