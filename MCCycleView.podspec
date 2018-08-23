Pod::Spec.new do |s|

  s.name         = "MCCycleView"
  s.version      = "0.0.1"
  s.summary      = "MCCycleView."

  s.description  = 'MCCycleView by MC'

  s.homepage     = "https://github.com/mancongiOS/MCCycleView"

  s.license      = "MIT"


  s.author             = { "MC" => "562863544@qq.com" }

  s.platform     = :ios

  s.source       = { :git => "https://github.com/mancongiOS/MCCycleView.git", :tag => "#{s.version}" }


  s.source_files  = "MCCycleView/*"

  s.frameworks = "Foundation", "UIKit"


end
