platform :ios, '10.0'

target 'CrossTrainingWorkout' do
  
  use_frameworks!
  
  source 'https://github.com/CocoaPods/Specs.git'
  source 'https://github.com/jarnal/PodsRepository.git'

  # Pods for CrossNoonTraining
  pod 'RealmSwift', :git => 'https://github.com/realm/realm-cocoa', :branch => 'master', submodules: true
  pod 'ListDataSourcesKit'

  target 'CrossTrainingWorkoutTests' do
    inherit! :search_paths
  end

  target 'CrossTrainingWorkoutUITests' do
    inherit! :search_paths
  end

end
