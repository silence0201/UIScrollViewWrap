Pod::Spec.new do |s|
  s.name = "SIScrollViewWrap"
  s.version = "1.0.5"
  s.summary = "ScrollViewWrap With Model"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Silence"=>"374619540@qq.com"}
  s.homepage = "https://github.com/silence0201/UIScrollViewWrap"
  s.description = "A ScrollViewWrap With Model"
  s.requires_arc = true
  s.source = { :path => '.' }

  s.ios.deployment_target    = '7.0'
  s.ios.vendored_framework   = 'ios/SIScrollViewWrap.framework'
end
