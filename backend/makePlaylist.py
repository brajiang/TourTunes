from __future__ import print_function
import sys
import spotipy
import spotipy.util as util
import os
from spotipy import oauth2
import json
import get_page

def prompt_for_user_token(username, scope=None, client_id = None,
        client_secret = None, redirect_uri = None, cache_path = None):
    ''' prompts the user to login if necessary and returns
        the user token suitable for use with the spotipy.Spotify
        constructor
        Parameters:
         - username - the Spotify username
         - scope - the desired scope of the request
         - client_id - the client id of your app
         - client_secret - the client secret of your app
         - redirect_uri - the redirect URI of your app
         - cache_path - path to location to save tokens
    '''

    if not client_id:
        client_id = os.getenv('SPOTIPY_CLIENT_ID')

    if not client_secret:
        client_secret = os.getenv('SPOTIPY_CLIENT_SECRET')

    if not redirect_uri:
        redirect_uri = os.getenv('SPOTIPY_REDIRECT_URI')

    if not client_id:
        print('''
            You need to set your Spotify API credentials. You can do this by
            setting environment variables like so:
            export SPOTIPY_CLIENT_ID='your-spotify-client-id'
            export SPOTIPY_CLIENT_SECRET='your-spotify-client-secret'
            export SPOTIPY_REDIRECT_URI='your-app-redirect-url'
            Get your credentials at     
                https://developer.spotify.com/my-applications
        ''')
        raise spotipy.SpotifyException(550, -1, 'no credentials set')

    cache_path = cache_path or ".cache-" + username
    sp_oauth = oauth2.SpotifyOAuth(client_id, client_secret, redirect_uri,
        scope=scope, cache_path=cache_path)

    # try to get a valid token for this user, from the cache,
    # if not in the cache, the create a new (this will send
    # the user to a web page where they can authorize this app)

    token_info = sp_oauth.get_cached_token()

    if not token_info:
        print('''
            User authentication requires interaction with your
            web browser. Once you enter your credentials and
            give authorization, you will be redirected to
            a url.  Paste that url you were directed to to
            complete the authorization.
        ''')
        auth_url = sp_oauth.get_authorize_url()
        try:
            import webbrowser
            webbrowser.open(auth_url)
            print("Opened %s in your browser" % auth_url)
        except:
            print("Please navigate here: %s" % auth_url)

        print()
        print()
        try:
            response = raw_input("Enter the URL you were redirected to: ")
        except NameError:
            response = input("Enter the URL you were redirected to: ")

        print()
        print()

        code = sp_oauth.parse_response_code(response)
        token_info = sp_oauth.get_access_token(code.strip())
    # Auth'ed API request
    if token_info:
        return token_info['access_token']
    else:
        return None

def getPlaylistURL(tourName, songsList):
    #songsList is an array of pairs (song,artist)
    plName = tourName + " playlist"
    scope = 'user-library-read, playlist-modify-public, playlist-read-private, playlist-read-collaborative'
    #username
    un = "lordofpwnage@gmail.com"
    token = prompt_for_user_token(un, scope,
                                       client_id='f02c574360474ea88c962d60c32d4d2f',
                                       client_secret='eca5b8bb3c6649a38a70bc9046bb0de0',
                                       redirect_uri='http://localhost'
                                       )
    if not token:
        print("Can't get token!")
        return None
    sp = spotipy.Spotify(auth=token)
    uid = sp.current_user()['id']
    #sp.user_playlist_create(uid, plName, True)
    playlistList = sp.user_playlists(uid)
    pid = ""
    for pl in playlistList['items']:
        if pl['name'] == plName:
            pid = pl['id']
            # url is just playlist/$pid
    if pid == "":
        print("couldn't find playlist ID after creatings")
        return None
    trackList = []
    for (song, artist) in songsList:
        tracks = sp.search(q='track: ' + song, type='track')
        sid=tracks['tracks']['items'][0]['id']
        trackList.append(sid)
    sp.user_playlist_add_tracks(uid, pid, trackList)

songList = get_page.scrape_html("katy perry")
print("songlist is: ", songList)
getPlaylistURL("testcrap", songList)