# Class: nginx
#
#
class nginx {
	
	package { 'nginx':
		ensure => 'present',
		require => Exec['apt-get update'],
	}

	service { 'nginx':
		#enable      => true,
		ensure      => running,
		#hasrestart => true,
		#hasstatus  => true,
		require    => Package['nginx'],
	}

	# Add vhost template

	file { 'vagrant-nginx':
		path => '/etc/nginx/sites-available/myvhost',
		ensure => file,
		require => Package['nginx'],
		source => 'puppet:///modules/nginx/myvhost',
	}

	# Disable nginx default vhost template

	file { 'default-nginx-disable':
		path => '/etc/nginx/sites-enabled/default',
		ensure => absent,
		require => Package['nginx'],
	}

	# Symlink vhost to sites-enabled

	file { 'vagrant-nginx-enable':
		path => '/etc/nginx/sites-enabled/myvhost',
		target => '/etc/nginx/sites-available/myvhost',
		ensure => link,
		notify => Service['nginx'],
		require => [
			File['vagrant-nginx'],
			File['default-nginx-disable'],
		],
	}
}
