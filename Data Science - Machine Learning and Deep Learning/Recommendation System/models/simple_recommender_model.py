from lightfm.datasets import fetch_movielens
from lightfm import LightFM


def lfm_model():
    data = fetch_movielens(min_rating=4.0)
    # Build model
    model = LightFM(loss='warp')
    # Train model
    model.fit(data['train'], epochs=30, num_threads=2)

    return model