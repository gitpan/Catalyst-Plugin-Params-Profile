package TestApp::Controller::Functions;

use strict;
use base qw/Catalyst::Controller/;
use Data::Dumper;

sub noregister : Local {
    my ($self,$c) = @_;

    $c->res->body('noregister')
            if !$c->get_profile('method' => 'noregister');
}

TestApp->register_profile(
        method  => 'register',
        profile => {
                required => [ 'test' ],
            }
    );
sub register : Local {
    my ($self,$c) = @_;

    $c->res->body('register')
            if $c->get_profile(method => 'register');
}

TestApp->register_profile(
        method  => 'novalidate',
        profile => {
                required => [ 'test' ],
            }
    );
sub novalidate : Local {
    my ($self,$c, %args) = @_;

    $c->res->body('novalidate')
            if !$c->validate('params' => \%args);
}

sub describe : Local {
    my ($self,$c, %args) = @_;
    $c->res->body('describe')
            if $c->_describe_pp_plaintext(
                    profile => 'TestApp::Controller::Functions::validate'
                ) =~ /test/;
}

TestApp->register_profile(
        method  => 'validate',
        profile => {
                required => [ 'test' ],
            }
    );
sub validate : Local {
    my ($self,$c) = @_;

    my %args = %{ $c->req->params };
    $c->res->body('validate')
            if $c->validate('params' => \%args);
}


1;
