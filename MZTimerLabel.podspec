#
# Be sure to run `pod lib lint MZTimerLabel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MZTimerLabel'
  s.version          = '1.0.0'
  s.summary          = 'A handy class to use UILabel as a countdown timer or stopwatch just like in Apple Clock App.'

  s.description      = <<-DESC
MZTimerLabel is a UILabel subclass, which is a handy way to use UILabel as a countdown timer or stopwatch just like that in Apple Clock App with just 2 lines of code. MZTimerLabel also provides delegate method for you to define the action when the timer finished.
                       DESC

  s.homepage        = "https://github.com/mineschan/MZTimerLabel"
  s.screenshots     = "https://raw.githubusercontent.com/mineschan/MZTimerLabel/master/MZTimerLabel_Demo.png"
  s.license         = { :type => 'MIT', :file => 'LICENSE' }
  s.author          = { "MineS Chan" => "mineschan@gmail.com" }
  s.source          = { :git => "https://github.com/mineschan/MZTimerLabel.git", :tag => s.version.to_s }

  s.ios.deployment_target = '12.4'
  s.swift_version = '5.0'

  s.source_files  = 'Classes', 'MZTimerLabel/*'
  s.exclude_files = 'Classes/Exclude'

end
