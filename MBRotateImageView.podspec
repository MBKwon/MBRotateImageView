Pod::Spec.new do |s|  
  s.name 	= 'MBRotateImageView'
  s.version = '0.9.2'
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  s.license = 'MIT License'
  s.homepage = 'https://github.com/MBKwon/MBRotateImageView'
  s.authors = {'MB Kyle' => 'maskkwon@gmail.com'}
  s.summary  = 'A ImageView that is rotating'
  s.source   = {:git => 'https://github.com/MBKwon/MBRotateImageView.git', :tag => s.version.to_s}  
  s.source_files = 'MBRotateImageView/MBRotateImageView.swift'
  s.frameworks = 'UIKit'
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
end
