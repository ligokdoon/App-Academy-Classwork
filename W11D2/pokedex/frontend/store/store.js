import { applyMiddleware, createStore } from 'redux';
import rootReducer from '../reducers/root_reducer';
import { logger } from 'redux-logger';
import thunk from '../middleware/thunk';
// import thunk from 'redux-thunk';

const configureStore = () => {
    return createStore(rootReducer, applyMiddleware(thunk, logger));
};

export default configureStore;
