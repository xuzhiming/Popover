Pod::Spec.new do |s|
	s.name 			= "Popover.OC"
	s.version 	= "2.2"
	s.summary 	= "A simple popover of menu."
	s.license 	= { :type => "MIT", :file => "LICENSE" }
	s.homepage	= "https://code.tiejin.cn/closer/Popover"
	s.author		= { "AllenLee" => "https://github.com/lifution" }
	s.source 		= { 
		:git => "https://code.tiejin.cn/closer/Popover.git", 
		:tag => s.version.to_s 
	}
	s.requires_arc = true
	s.platform 		 = :ios, "6.0"
	s.source_files = "PopoverView/*", "*.{h,m}"
end