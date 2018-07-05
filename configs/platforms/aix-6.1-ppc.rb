platform "aix-6.1-ppc" do |plat|
  plat.servicetype "aix"

  plat.make "gmake"
  plat.tar "/opt/freeware/bin/tar"
  plat.rpmbuild "/usr/bin/rpm"
  plat.patch "/opt/freeware/bin/patch"

  plat.provision_with "curl -O http://pl-build-tools.delivery.puppetlabs.net/aix/yum_bootstrap/rpm.rte && installp -acXYgd . rpm.rte all"
  plat.provision_with "curl http://pl-build-tools.delivery.puppetlabs.net/aix/yum_bootstrap/openssl-1.0.2.1500.tar | tar xvf - && cd openssl-1.0.2.1500 && installp -acXYgd . openssl.base all"
  plat.provision_with "rpm --rebuilddb && updtvpkg"
  plat.provision_with "mkdir -p /tmp/yum_bundle && cd /tmp/yum_bundle/ && curl -O http://pl-build-tools.delivery.puppetlabs.net/aix/yum_bootstrap/yum_bundle.tar && tar xvf yum_bundle.tar && rpm -Uvh /tmp/yum_bundle/*.rpm ||:"
  # TODO: Uncomment the following lines after updating artifactory to mirror IBM's yum repositories:
  # plat.provision_with "/usr/bin/sed 's/enabled=1/enabled=0/g' /opt/freeware/etc/yum/yum.conf > tmp.$$ && mv tmp.$$ /opt/freeware/etc/yum/yum.conf"
  # plat.provision_with "echo '[AIX_Toolbox_mirror]\nname=AIX Toolbox local mirror\nbaseurl=https://artifactory.delivery.puppetlabs.net/artifactory/rpm__remote_aix_linux_toolbox/ppc/\ngpgcheck=0' > /opt/freeware/etc/yum/repos.d/toolbox-generic-mirror.repo"
  # plat.provision_with "echo '[AIX_Toolbox_noarch_mirror]\nname=AIX Toolbox noarch repository\nbaseurl=https://artifactory.delivery.puppetlabs.net/artifactory/rpm__remote_aix_linux_toolbox/noarch/\ngpgcheck=0' > /opt/freeware/etc/yum/repos.d/toolbox-noarch-mirror.repo"
  # plat.provision_with "echo '[AIX_Toolbox_61_mirror]\nname=AIX 61 specific repository\nbaseurl=https://artifactory.delivery.puppetlabs.net/artifactory/rpm__remote_aix_linux_toolbox/ppc-6.1/\ngpgcheck=0' > /opt/freeware/etc/yum/repos.d/toolbox-61-mirror.repo"
  plat.provision_with "yum install -y rsync coreutils sed make tar pkg-config zlib zlib-devel gawk autoconf gcc glib2"
  plat.install_build_dependencies_with "yum install -y "
  plat.vmpooler_template "aix-6.1-power"
end
