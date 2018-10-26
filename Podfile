platform :ios, '10.0'

target 'CrossNoonTraining' do
  
  use_frameworks!
  
  source 'https://github.com/CocoaPods/Specs.git'
  source 'https://github.com/jarnal/PodsRepository.git'

  # Pods for CrossNoonTraining
  pod 'RealmSwift', :git => 'https://github.com/realm/realm-cocoa', :branch => 'master', submodules: true
  pod 'ObjectMapper', '~> 3.3'
  pod 'ObjectMapper+Realm'
  pod 'ListDataSourcesKit'

  target 'CrossNoonTrainingTests' do
    inherit! :search_paths
  end

  target 'CrossNoonTrainingUITests' do
    inherit! :search_paths
  end

end
