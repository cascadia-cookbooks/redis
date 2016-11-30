case node['platform_family']
when 'debian'
    include_recipe 'apt::default'
when 'rhel'
    epel = File.exists?('/etc/yum.repos.d/epel.repo')

    # NOTE: EPEL (Extra Packages for Enterprise Linux)
    package 'epel-release' do
        not_if { epel }
        action :install
        notifies :run, 'execute[update yum]', :immediately
    end

    execute 'update yum' do
        command "yum clean all && yum distro-sync -q -y && yum update -q -y"
        action  :nothing
    end
end
