'''
Parses html page from setlist.fm to get songs and artists from a setlist.
'''

from bs4 import BeautifulSoup

def parse_content(content):
    # outputs list all song, artist pairs
    songs = []
    index = content.find('YoutubeSearch.setPlaylist')
    if index == -1:
        return songs
    # parse this part of the string
    index += len('YoutubeSearch.setPlaylist')

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
            while content[index] != '\"':
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
        else:
            return None

with open('../test_pages/drake.htm', 'r') as ifile:
    page = ifile.read()

print(extract_songs(page))
