namespace :diagram do
  desc 'Generate class diagram'
  task :classes do
    require 'railroady'
    require 'railroady/railtie'
    
    RailRoady::Diagrams::ClassDiagram.new.generate
  end
end 