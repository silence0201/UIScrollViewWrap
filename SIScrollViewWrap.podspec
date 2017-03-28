Pod::Spec.new do |s|
  s.name         = "SIScrollViewWrap"
  s.version      = "1.0.0"
  s.summary      = "ScrollViewWrap With Model"
  s.description  = <<-DESC
  						        A ScrollViewWrap With Model
                   DESC
  s.homepage     = "https://github.com/silence0201/UIScrollViewWrap"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Silence" => "374619540@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/silence0201/UIScrollViewWrap.git", :tag => "1.0.0" }
  s.source_files  = "UIScrollViewWrap", "UIScrollViewWrap/*/*.{h,m}"
  s.public_header_files = "UIScrollViewWrap/**/*.h"
  s.exclude_files = "UIScrollViewWrap/Exclude"
  s.requires_arc = true
  s.dependency "UITableView+FDTemplateLayoutCell", "~> 1.4"

end
