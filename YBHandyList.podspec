

Pod::Spec.new do |s|


  s.name         = "YBHandyList"
  s.version      = "1.0.2"
  s.summary      = "让 UITableView / UICollectionView 更加简单优雅，轻易实现列表动态化、模块化、MVVM 架构"
  s.description  = <<-DESC
  					让 UITableView / UICollectionView 更加简单优雅，轻易实现列表动态化、模块化、MVVM 架构。
                   DESC

  s.homepage     = "https://github.com/indulgeIn"

  s.license      = "MIT"

  s.author       = { "杨波" => "1106355439@qq.com" }
 
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/indulgeIn/YBHandyList.git", :tag => "#{s.version}" }

  s.source_files  = "YBHandyList/**/*.{h,m}"

  s.requires_arc = true

end
