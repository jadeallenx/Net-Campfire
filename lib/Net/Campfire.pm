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
        room_id => $rooms[0]->id, 
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

=method highlight()

This method highlights a message represented by the required C<message_id> parameter.

=cut

net_api_method highlight => (
    description => 'Highlight a message',
    method => 'POST',
    path => '/messages/:message_id/star.xml',
    params => [qw(message_id)],
    required => [qw(message_id)],
    authentication => 1,
);

=method unhighlight()

This method removes a message highlight. Requires a C<message_id> parameters.

=cut

net_api_method highlight => (
    description => 'Highlight a message',
    method => 'DELETE',
    path => '/messages/:message_id/star.xml',
    params => [qw(message_id)],
    required => [qw(message_id)],
    authentication => 1,
    expected => [qw(200)],
);

=method rooms()

This method lists all of the rooms the authenticated user can see.  Returns an array of 
hashrefs with the following keys:

=over 4

=item * id (integer)

=item * name (string)

=item * topic (string)

=item * membership-limit (integer)

=item * full (bool)

=item * open-to-guests (bool)

=item * active-token-value (string; requires C<open-to-guests> is true)

=item * updated-at (iso8601 datetime; example: '2009-11-17T19:41:38Z')

=item * created-at (iso8601 datetime)

=back

=cut

net_api_method rooms => (
    description => 'List all visible rooms for authenticated user',
    method => 'GET',
    path => '/rooms.xml',
    authentication => 1,
);

=method room_presence() 

This method returns an array of hashrefs representing the rooms in which the authenticated user is joined.
The hashref has the same keys at the C<rooms()> method above.

=cut

net_api_method room_presence => (
    description => 'List all rooms in which user is joined',
    method => 'GET',
    path => 'presence.xml',
    authentication => 1,
);

=method get_room()

This method retrieves information about a specific room, including the users joined to that room. Requires
a C<room_id> parameter. Returns an array of hashrefs with the same keys as in the C<rooms()> method 
above.  User data is an array located at the C<users> hash key. See the C<get_user()> method for 
information about user hashref keys.

=cut

net_api_method get_room => (
    description => 'Get specific room information',
    method => 'GET',
    path => '/room/:room_id.xml';
    params => [qw(room_id)],
    required => [qw(room_id)],
    authentication => 1,
);




1;
