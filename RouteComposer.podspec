Pod::Spec.new do |s|
  s.name             = 'RouteComposer'
  s.version          = '1.1.3'
  s.summary          = 'Protocol oriented library that helps to handle view controllers composition, routing and deeplinking tasks.'
  s.swift_version    = '5.0'

  s.description      = <<-DESC
    RouteComposer is the protocol oriented, Cocoa UI abstractions based library that helps to handle view controllers composition, routing
    and deep linking tasks in the iOS application.
                       DESC

  s.homepage         = 'https://github.com/saksdirect/route-composer'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Evgeny Kazaev' => 'eugene.kazaev@hbc.com' }
  s.source           = { :git => 'https://github.com/saksdirect/route-composer.git', :tag => s.version }

  s.ios.deployment_target = '9.0'
  s.source_files = 'RouteComposer/Classes/**/*'
  s.frameworks = 'UIKit'
end
