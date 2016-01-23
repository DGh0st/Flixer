# Project 1 - Flixer

Flixer is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 6 hour spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] User sees an error message when there's a networking error.
- [ ] Movies are displayed using a CollectionView instead of a TableView.
- [x] User can search for a movie. (non-case sensitive)
- [x] All images fade in as they are loading.
- [x] Customize the UI.

The following **additional** features are implemented:

- [x] List anything else that you can get done to improve the app functionality!

    - [x] Dismiss keyboard on tap or table view swipe.

    - [x] Hide search bar by default, keyboard search tap and view tap while search bar is empty.

    - [x] Attempt to load data on app start for convenience.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://imgur.com/sGs8kx3' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

The coding was not difficult, but debugging a forgotten ":" took 15-20 mins to figure out for the refresh control portion. Customizing the UI took a lot of experimenting. The property to dismiss the keyboard on table swipe took a while to find. Hiding search bar took most of the time (2 hours maybe) as I was trying to do it with UITableView's scrollToRowAtIndex instead of using the setContentOffset.

## License

    Copyright 2016 Deep Patel (DGh0st)

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
