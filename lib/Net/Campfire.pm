use strict;
use warnings;
package Net::Campfire;

# ABSTRACT: Perl binding for 37signals Campfire API

use Carp qw(croak);
use Net::HTTP::API;

=head1 SYNOPSIS

    use 5.014;
    use Net::Campfire;

    my $cf = Net::Campfire->new(
        api_base_url => 'https://sample.campfirenow.com',
        api_username => 'my_api_token',
    );

    my @rooms = $cf->room_presence();

    $cf->speak( 
        room_id => $room[0]->room_id, 
        message => "Hello world from Net::Campfire!"
    );

This is a Perl binding for the L<Campfire API|http://developer.37signals.com/campfire/index>. 
Campfire is a workgroup collaboration/messaging tool.

=cut

net_api_declare campfire => (
    api_password => 'dummy', # This field is not used by the API
    api_format => 'xml',
    api_format_mode => 'content-type',
    authentication => 1,
);

=attr api_username

You must supply an C<api_username> for API calls.

=attr api_base_url

You must supply an C<api_base_url> so that API calls are directed to the right set of endpoints.

=cut

=head2 Messages

=method speak()

This method sends a message to a room.  Requires the following parameters: C<room_id>, C<message>.
You may optionally pass C<type> where type is one of the following:

=over 4

=item * TextMessage (default; regular chat message)

=item * PasteMessage (rendered in fixed-width font like a pastebin)

=item * SoundMessage (plays a sound)

=over 4

Available sounds are:

=item + rimshot

=item + crickets

=item + trombone

=back

=item * TweetMessage (a Twitter status URL to be fetched and inserted into the chat stream)

=back

=cut

net_api_method speak => (
    description => 'Send a message to a room',
    method => 'POST',
    path => '/room/:room_id/speak.xml',
    params => [qw(room_id, message, type)],
    required => [qw(room_id, message)],
    authentication => 1,
    expected => [qw(201)],
);




1;
