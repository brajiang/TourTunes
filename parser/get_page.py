'''
Given name of tour, finds and downloads source of setlist.fm page linked to
the tour.
'''

from bs4 import BeautifulSoup
import requests

def scrape_html(tour_name):
    # start with results of setlist.fm search
    match = 'View this ___ setlist'
    query = tour_name.replace(' ', '+')
    start_url = 'https://www.setlist.fm/search?query={}'.format(query)

    # reads in query page
    webcontent = requests.get(start_url).content

    print(webcontent)

scrape_html('red pill blues')

