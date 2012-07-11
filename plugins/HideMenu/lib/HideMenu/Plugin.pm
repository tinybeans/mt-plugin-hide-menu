package HideMenu::Plugin;

use strict;

sub _pre_run {
    my $app = MT->instance;
    my $core = MT->component( 'core' );
    my $cr = $core->registry( 'applications', 'cms', 'menus' );
    my $p = MT->component( 'HideMenu' );
    my $hidemenu;
    if ( $app->blog ) {
        $hidemenu = $p->get_config_value( 'HideBlogMenuList', 'blog:' . $app->blog->id ) || $p->get_config_value( 'HideSystemMenuList', 'system' );
    } else {
        $hidemenu = $p->get_config_value( 'HideSystemMenuList', 'system' );
    }
    my @memus = split( /,/, $hidemenu );
    for my $menu ( @memus ) {
        if (! $app->blog ) {
            $cr->{ $menu } = { view => [ 'blog' ] };
        } else {
            $cr->{ $menu } = { view => [ 'system' ] };
        }
    }
    return 1;
}

1;