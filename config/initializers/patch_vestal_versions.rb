VestalVersions::Version.module_eval do     
  attr_accessible :modifications, :number, :user,:reverted_from,:tag
end 