platform :ios, '16.0'
use_frameworks!
inhibit_all_warnings!

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod 'Sourcery'
  pod 'SwiftFormat/CLI'
end

target 'Surveys' do
  # UI
  pod 'Kingfisher'
  pod 'SnapKit'

  # Storage
  pod 'KeychainAccess'

  # Tools
  pod 'Firebase/Crashlytics'
  pod 'IQKeyboardManagerSwift'
  pod 'NimbleExtension', :git => 'https://github.com/nimblehq/NimbleExtension', :branch => 'master'
  pod 'R.swift'
  pod 'Resolver'
  pod 'Moya/Combine', '~> 15.0'

  # Development
  pod 'SwiftLint'
  pod 'Wormholy', :configurations => ['Debug Staging', 'Debug Production']

  target 'SurveysTests' do
    inherit! :search_paths
    testing_pods
  end

  target 'SurveysUITests' do
    testing_pods
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      # Fixing resources signing for xcode 14 sdk
      if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
        target.build_configurations.each do |config|
          config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
        end
      end
    end
  end
end
