# Class: php
#
#
class php {
	# resources
	package { ['php5-fpm', 'php5-cli']:
		ensure => present,
		require => Exec['apt-get update'],
	}

	service { 'php5-fpm':
		#enable      => true,
		ensure      => running,
		#hasrestart => true,
		#hasstatus  => true,
		require    => Package['php5-fpm'],
	}

       file { '/var/www/index.php':
               ensure => file,
               content => '<?php  phpinfo(); ?>',   # phpinfo code
               require => Package['nginx'],        # require 'nginx' package before creating
        } 
}
