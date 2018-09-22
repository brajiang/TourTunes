'''
Given name of tour, finds and downloads source of setlist.fm page linked to
the tour, and gets songs of most relevant tour.
'''

from bs4 import BeautifulSoup
import requests

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

def possible_setlist(tag):
    if tag.name != 'a':
        return False
    if tag == None:
        return False
    if tag.get('title') == None:
        return False
    if tag.get('href') == None:
        return False
    title = tag['title']
    if title.find('View this') == -1:
        return False
    return True

def scrape_html(tour_name):
    # start with results of setlist.fm search
    query = tour_name.replace(' ', '+')
    start_url = 'https://www.setlist.fm/search?query={}'.format(query)

    # read in entire query page html file
    webcontent = BeautifulSoup(requests.get(start_url).content, 'html.parser')

    # search web content
    # print(webcontent)
    setlists = webcontent.find_all(possible_setlist)
    for tag in setlists:
        # get link from each
        link = tag['href']
        url = 'https://www.setlist.fm/{}'.format(link)
        #print(url)
        content = requests.get(url).content
        songs = extract_songs(content)
        #print(songs)
        if songs != None and len(songs) > 5:
            return songs
        # if len(songs) > 0:
           #  return songs

scrape_html('katy perry')
