# Uncomment the next line to define a global platform for your project
source 'git@bitbucket.org:bitsfabrik/bitspods.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '15.0'

target 'ImaginaryNationalPark' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ImaginaryNationalPark
  pod 'Alamofire'
  pod 'SnapKit'
  pod 'BIFiOSUtils'
  pod 'AlamofireImage'


  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
    end
  end

end
