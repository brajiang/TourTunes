# TourTunes
**TourTunes** is a mobile application aimed at finding and getting ready for concerts. 

## Use Case
- User sees a poster of concert, scrolls across a Facebook concert event, wants to know what a particular artist is playing on his/her tour
- User takes a picture or screenshot of Tour Poster, Facebook Event, or Artist Name
- User uploads photo in the application 
- User is generated a personal Spotify playlist where he/she can prepare for the concert

## The Process
### Computer Vision
We are able to extract the **relevant text** from posters and images, getting the artist and/or tour name.
### Web Crawling and Scraping
With an artist and/or tour name we crawl the internet for the set list. Once we find a website that has what we want, we scrape and create an object readable by the Spotify API to create our playlist.
### Spotify API
You want to be able to listen to the tour songs. Concerts are fun when you can sing along! TourTunes utilizes the Spotify API to create a beautiful interface for viewing the tour's setlist and to create a personal playlist where you can listen to the songs. 
### Mobile
The power of mobile is you always have your phone on you. You can take a picture or a screenshot the second you see what you want, you don't have to wait until you're at a physical computer. People also listen to music on their phones so it makes sense to make a playlist on their phone.
### Firebase
We use firebase to communicate between the App and our server. Photos are uploaded from our phone to Firebase where our backend then queries and processes them, sending the resulting playlist back to the phone.

