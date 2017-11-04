Pod::Spec.new do |s|
s.name = "AutomaticKeyboard"
s.version = "1.0.1"
s.summary = "Helper to manage views when the keyboard is visible"
s.homepage = "https://github.com/Digipolitan/automatic-keyboard"
s.authors = "Digipolitan"
s.source = { :git => "https://github.com/Digipolitan/automatic-keyboard.git", :tag => "v#{s.version}" }
s.license = { :type => "BSD", :file => "LICENSE" }
s.source_files = 'Sources/**/*.{swift,h}'
s.ios.deployment_target = '8.0'
s.requires_arc = true
end
