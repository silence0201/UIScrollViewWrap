Pod::Spec.new do |s|
  s.name         = "SIScrollViewWrap"
  s.version      = "1.0.2"
  s.summary      = "ScrollViewWrap With Model"
  s.description  = <<-DESC
  						        A ScrollViewWrap With Model
                   DESC
  s.homepage     = "https://github.com/silence0201/UIScrollViewWrap"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Silence" => "374619540@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/silence0201/UIScrollViewWrap.git", :tag => "1.0.2" }

  s.subspec 'UITableView' do |ss|
    ss.source_files = 'UIScrollViewWrap/{UITableView,Common}/**/*.{h,m}'
    ss.public_header_files = 'UIScrollViewWrap/{UITableView,Common}/**/*.{h}'
  end

  s.subspec 'UICollectionView' do |ss|
    ss.source_files = 'UIScrollViewWrap/{UICollection,Common}/**/*.{h,m}'
    ss.public_header_files = 'UIScrollViewWrap/{UICollection,Common}/**/*.{h}'
  end

  s.requires_arc = true
  s.dependency "UITableView+FDTemplateLayoutCell", "~> 1.4"

end
