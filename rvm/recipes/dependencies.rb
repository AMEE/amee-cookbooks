%w{curl build-essential zlib1g-dev libreadline5-dev libssl-dev libxml2-dev}.each do |p|
  package p do
    action :install
  end
end
