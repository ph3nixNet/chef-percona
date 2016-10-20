#
# Cookbook Name:: percona
# Attributes:: package_repo
#

default["percona"]["use_percona_repos"] = true

arch = node["kernel"]["machine"] == "x86_64" ? "x86_64" : "i386"
pversion = value_for_platform(
  "amazon" => { "default" => "latest" },
  "default" => node["platform_version"].to_i
)

# select GPG key based on Ubuntu version
case node['platform']
when 'ubuntu', 'debian'
  if node['platform_version'].to_f < 16
    default["percona"]["apt"]["key"] = "0x1C4CBDCDCD2EFD2A"
  else
    default["percona"]["apt"]["key"] = "9334A25F8507EFA5"
  end
end

default["percona"]["apt"]["keyserver"] = "hkp://keyserver.ubuntu.com"
default["percona"]["apt"]["uri"] = "http://repo.percona.com/apt"

default["percona"]["yum"]["description"] = "Percona Packages"
default["percona"]["yum"]["baseurl"] = "http://repo.percona.com/centos/#{pversion}/os/#{arch}/"
default["percona"]["yum"]["gpgkey"] = "http://www.percona.com/downloads/RPM-GPG-KEY-percona"
default["percona"]["yum"]["gpgcheck"] = true
default["percona"]["yum"]["sslverify"] = true
