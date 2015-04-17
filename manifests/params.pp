# == Class: libvirt::params
#
# Operating system dependent parameters
class libvirt::params {
  case $::osfamily {
    'Debian': {
      case $::lsbdistcodename {
        'wheezy': {
          $libvirt_package_names  = ['libvirt-bin', 'qemu']
          $service_name           = 'libvirt-bin'
        }
        'jessie': {
          $libvirt_package_names  = ['libvirt-system-daemon', 'qemu']
          $service_name           = 'libvirtd'
        }
        default: {
          fail("${::lsbdistcodename} is currently not supported by the libvirt
                module. Please add support for it and submit a patch!")
        }
      }
      $config_dir             = '/etc/libvirt'
      $manage_domains_config  = '/etc/manage-domains.ini'
      $qemu_hook_packages     = {'drbd' => ['xmlstarlet','python-libvirt'], }
    }

    'RedHat': {
      $libvirt_package_names  = ['libvirt']
      $service_name           = 'libvirtd'
      $config_dir             = '/etc/libvirt'
      $manage_domains_config  = '/etc/manage-domains.ini'
      $qemu_hook_packages     = {'drbd' => ['xmlstarlet','python-libvirt'], }
    }

    default: {
      fail("${::osfamily} is currently not supported by the libvirt module.
            Please add support for it and submit a patch!")
    }
  }
}
