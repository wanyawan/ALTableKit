Pod::Spec.new do |s|
  s.name = 'ALTableKit'
  s.version = '1.1.2'
  s.summary = 'A data-driven UITableView framework.'
  s.homepage = 'https://github.com/wanyawan/ALTableKit'
  # s.documentation_url = 'https://github.com/wanyawan/ALTableKit'
  s.description = 'A data-driven UITableView framework for building fast and Low coupling, Similar to the IGList CollectionView framework.'

  s.license = { :type => "MIT", :file => "LICENSE" }
  s.authors = { "Alex" => "duanzw@vip.qq.com" } 
  # s.social_media_url = 'https://twitter.com/'
  s.source = {
    :git => 'https://github.com/wanyawan/ALTableKit.git',
    :tag => s.version.to_s,
  }

  s.requires_arc = true

  s.source_files  = "ALTableKit/**/*.{h,m,mm}"
  s.public_header_files = "ALTableKit/*.h"
  s.private_header_files = "ALTableKit/ALTableKitInternal/*.h"

  s.platform     = :ios, "8.0"
  s.frameworks = "UIKit" ,"Foundation"

  s.library = 'c++'
  s.pod_target_xcconfig = {
       'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
       'CLANG_CXX_LIBRARY' => 'libc++'
  }
end
