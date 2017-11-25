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
  spec.source_files =  'Source/*.{swift}'
  spec.requires_arc =  true
end
