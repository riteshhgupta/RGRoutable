Pod::Spec.new do |spec|
  spec.name         =  'RGRoutable'
  spec.version      =  '1.0'
  spec.summary   =  'RGRoutable'
  spec.author = {
    'Ritesh Gupta' => 'rg.riteshh@gmail.com'
  }
  spec.license          =  'MIT' 
  spec.homepage         =  'https://github.com/riteshhgupta/RGRoutable'
  spec.source = {
    :git => 'https://github.com/riteshhgupta/RGRoutable.git',
    :tag => '1.0'
  }
  spec.ios.deployment_target = "9.0"
  spec.requires_arc =  true

  spec.subspec 'Core' do |core|
    core.source_files =  'Source/**/*.swift'
    core.exclude_files = 'Source/Reactive/*.swift'
  end

  spec.subspec 'ReactiveSwift' do |reactiveswift|
    reactiveswift.dependency 'RGRoutable/Core'
    reactiveswift.dependency 'ReactiveSwift', '~> 4.0'
    reactiveswift.dependency 'ReactiveCocoa', '~> 8.0'
    reactiveswift.source_files =  'Source/**/*.swift'
  end

  spec.default_subspec = 'Core'

end
