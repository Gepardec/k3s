import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_is_dhcp_installed(host):
    package_dhcp = host.package('dhcp-server')

    assert package_dhcp.is_installed
