class sample::config{

    File{
        require => Class['::sample::install'],
        notify  => Class['::sample::service'],
    }

    file{

        '/etc/sample':
            ensure => directory;

        '/etc/sample/simple.conf':
            source => 'puppet:///modules/sample/simple.conf';

    }

    include
        ::sample::config::file

    Sample::Config::File{
        require => [
            File['/etc/sample'],
            Class['::sample::install'],
        ],
        notify  => Class['::sample::service']
    }

    sample::config::file::fragment{'header':
        order => 00,
        content => template('sample/file/header.erb')
    }

    sample::config::file::fragment{'body':
        order => 10,
        content => template('sample/file/body.erb')
    }

    sample::config::file::fragment{'footer':
        order => 20,
        content => template('sample/file/footer.erb')
    }

}
