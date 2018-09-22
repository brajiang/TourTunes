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


def extract_tourname(page):
    doc = BeautifulSoup(page, 'html.parser')
    spans = doc.find_all('span')
    # search spans for Tour:
    for idx in range(len(spans)):
        if spans[idx].string == 'Tour:':
            tour_tag = spans[idx+2]
            # print(tour_tag)
            return tour_tag.string
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

def is_page_link(tag):
    if tag.name != 'a':
        return False
    if tag == None:
        return False
    if tag.get('href') == None:
        return False
    link = tag['href']
    if link.find('https://www.setlist.fm') == -1:
        return False
    # if link[:len('https://www.setlist.fm/')] != 'https://www.setlist.fm/':
    #    return False
    return True

def scrape_html(tour_name):
    # start with results of setlist.fm search
    query = tour_name.replace(' ', '+')
    start_url = 'https://www.setlist.fm/search?query={}'.format(query)
    # start with results of google search of setlist.fm, go to first link...?
    g_search_url = 'https://www.google.com/search?q={}+%3Asetlist.fm'.format(query)
    # read in entire query page html file
    # webcontent = BeautifulSoup(requests.get(start_url).content, 'html.parser')
    # print(requests.get(g_search_url).content)
    results_page = BeautifulSoup(requests.get(g_search_url).content, 'html.parser')
    search_results = results_page.find_all(is_page_link)
    for res in search_results:
        # print(res)
        link = res['href']
        start_idx = link.find('https://')
        end_idx = link.find('.html') + 5
        link = ''.join(list(link)[start_idx:end_idx])
        #print(link)
        
        webcontent = BeautifulSoup(requests.get(link).content, 'html.parser')
        setlists = webcontent.find_all(possible_setlist)
        for tag in setlists:
            # get link from each and process
            nlink = tag['href']
            start = nlink.find('setlist')
            nlink = ''.join(list(nlink)[start:])
            url = 'https://www.setlist.fm/{}'.format(nlink)
            # print('playlist url:' + url)
            content = requests.get(url).content
            songs = extract_songs(content)
            tour_name = extract_tourname(content)
            if tour_name == None:
                tour_name = songs[0][1]
            # print(songs)
            if songs != None and len(songs) > 5:
                return (tour_name,songs)
    return None

# print(scrape_html('katy perry'))
