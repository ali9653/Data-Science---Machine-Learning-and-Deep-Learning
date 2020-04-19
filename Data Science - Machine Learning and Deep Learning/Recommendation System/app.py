import numpy as np
from flask import Flask, request, render_template
from models.simple_recommender_model import lfm_model
from lightfm.datasets import fetch_movielens



model = lfm_model() # import model
data = fetch_movielens(min_rating=4.0) # import data

app = Flask(__name__)


@app.route('/')
def my_form():
    return render_template('my-form.html')


@app.route("/predict", methods=['POST'])
def sample_recommendation(model=model, data=data):

    result = request.form['number']
    input_user_ids = np.fromstring(result, dtype=int, sep=' ') # User input data
    
    n_users, n_items = data['train'].shape
    
    x_list = []   
    i_list = []

    for user_id in input_user_ids:
        known_positives = data['item_labels'][data['train'].tocsr()[user_id].indices]

        scores = model.predict(user_id, np.arange(n_items))
        top_items = data['item_labels'][np.argsort(-scores)]

        print(f'User {user_id}')

        print('     Known positives:')
        for i in known_positives[:1]:
            i_list.append(i)
            i_ = ''.join(i_list)
            print(f'        {i}')

        print("     Recommended:")
        for x in top_items[:1]:
            x_list.append(x)
            x_ = ''.join(x_list)
            print(f'        {x}')

        return render_template('predict-page.html', rec=x_, known=i_)

if __name__ == 'main':
    # app.debug = True
    app.run()