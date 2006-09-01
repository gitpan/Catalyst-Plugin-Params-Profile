#!perl
BEGIN {
    chdir 't' if -d 't';
    use lib qw[../lib/ lib/];
}

use Test::More 'no_plan';
use Catalyst::Test 'TestApp';
use Data::Dumper;

{
    my %tests = (
            noregister => {
                    response    => 'noregister',
                },
            register => {
                    response    => 'register',
                },
            novalidate => {
                    response    => 'novalidate',
                },
            validate => {
                    response    => 'validate',
                    get         => 'test=ja',
                },
            describe => {
                    response     => 'describe',
                },
        );
    my $reqtest = 0;

    foreach my $test (keys %tests) {
        my $response;
        my $url = '/functions/' . $test;
        $url .= '/?' . $tests{$test}->{get} if $tests{$test}->{get};
        if (!$reqtest) {
            $response = request($url);
        } else {
            ok($response = request($url), 'Request OK');
        }
        is( $response->content, $tests{$test}->{response},  $test . ' profile check');
    }
}
