'''
Parses content of setlist.fm page to get song, artist pairs.
'''
from bs4 import BeautifulSoup

def parse_content(content):
    # outputs list all song, artist pairs
    songs = []
    index = content.find('YouTubeSearch.setPlaylist')
    if index == -1:
        return songs
    # parse this part of the string
    index += len('YouTubeSearch.setPlaylist')

    reach_end = False
    while not reach_end:
        if content[index] == '{':
            # read song, artist pair
            song = ''
            artist = ''
            index += 1
            quote_count = 0
            # go on until 3rd quote
            while quote_count < 3:
                if content[index] == '\"':
                    quote_count += 1
                index += 1

            # read string
            while content[index] != '\"' or \
                    (content[index] == '\"' and content[index-1] == '\\'):
                if content[index] != '\\':
                    song += content[index]
                index += 1

            quote_count = 0
            while quote_count < 4:
                if content[index] == '\"':
                    quote_count += 1
                index += 1
            # read string
            while content[index] != '\"':
                artist += content[index]
                index += 1
            songs += [(song, artist)]
            # print(song + '\n')
            # print(artist + '\n')
        elif content[index] == ']':
            reach_end = True
        else:
            index += 1
    return songs

def extract_songs(page):
    doc = BeautifulSoup(page, 'html.parser')
    scripts = doc.find_all('script')
    for script in scripts:
        content = script.string
        # how to tell if this one contains relevant info, magic string
        if content == None:
            continue
        index = content.find('YouTubeSearch.setPlaylist')
        if index != -1:
            return parse_content(content)
            # read until ']'
            # print(content)
    return None
