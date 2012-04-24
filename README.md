# NAME

Net::Campfire - Perl binding for 37signals Campfire API

# VERSION

version 0.01

# SYNOPSIS

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

This is a Perl binding for the [Campfire API](http://developer.37signals.com/campfire/index). 
Campfire is a workgroup collaboration/messaging tool.

# ATTRIBUTES

## api_username

You must supply an `api_username` for API calls.

## api_base_url

You must supply an `api_base_url` so that API calls are directed to the right set of endpoints.

# METHODS

## speak()

This method sends a message to a room.  Requires the following parameters: `room_id`, `message`.
You may optionally pass `type` where type is one of the following:

- TextMessage (default; regular chat message)
- PasteMessage (rendered in fixed-width font like a pastebin)
- SoundMessage (plays a sound)

    Available sounds are:

    - rimshot
    - crickets
    - trombone

- TweetMessage (a Twitter status URL to be fetched and inserted into the chat stream)

# AUTHOR

Mark Allen <mrallen1@yahoo.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Mark Allen.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
