# lightfm-recommender-app

## Usage 
#### 1. Clone directory
```bash
$ git clone https://github.com/ahylton19/lightfm-recommender-app
```

#### 2. Change directory
```bash
$ cd lightfm-recommender-app
```

#### 3. Install the dependencies
```bash
$ pip install -r requirements.txt
```

#### 4. Run application
```bash
$ export FLASK_RUN=app.py 
$ flask run
```

## Example

Here is a link to a live running example of the application: https://lfm-rec.herokuapp.com/

## Information About Dataset Used
The dataset describes 5-star rating and free-text tagging activity from [MovieLens](http://movielens.org), a movie recommendation service. It contains 100004 ratings and 1296 tag applications across 9125 movies. These data were created by 671 users between January 09, 1995 and October 16, 2016. This dataset was generated on October 17, 2016.

Users were selected at random for inclusion. All selected users had rated at least 20 movies. No demographic information is included. Each user is represented by an id, and no other information is provided.
