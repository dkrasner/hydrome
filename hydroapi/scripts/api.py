import argparse

from flask_cors import cross_origin
from flask import Flask, request, jsonify, make_response

from hydroapi import Api


def cli():
    parser = argparse.ArgumentParser(
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument(
        '--host',
        default='127.0.0.1',
        type=str,
        help="Host for the api.")

    parser.add_argument(
        '--port',
        default=5000,
        type=int,
        help="Port for the api.")

    parser.add_argument(
        '--debug',
        action='store_true',
        help="Run in flask debug mode.")
    args = parser.parse_args()

    config = {
        'host': args.host,
        'port': args.port,
        'debug': args.debug,
    }

    return config

config = cli()


# ##############################GLOBALS##################################
HOST = config['host']
PORT = config['port']
DEBUG = config['debug']

app = Flask(__name__, static_folder="/tmp")
api = Api()

if DEBUG:
    app.config['DEBUG'] = True
else:
    app.config['propagate_exceptions'] = True


@app.route('/model', methods=["GET", "PUT", "POST"])
@cross_origin()
def model():
    """ """
    # GET to get info
    # POST to create/configure instance
    # PUT to compile instance
    try:
        if request.method == "GET":
            return_data = {"results": "ok"}
        elif request.method == "POST":
            return_data = {"results": "ok"}
        elif request.method == "PUT":
            return_data = {"results": "ok"}
        return_data = {"results": "ok"}
        response_code = 200
    except Exception as e:  # TODO: list apprpriate errors here
        return_data = {"error": str(e)}
        response_code = 400
    response = make_response(jsonify(return_data), response_code)
    response.mimetype = 'application/json'
    response.headers['Content-Type'] = 'application/json'
    return response


@app.route('/domain', methods=["GET", "POST"])
@cross_origin()
def domain():
    """ """
    # GET to get info
    # POST to create/configure instance
    # PUT to compile instance
    try:
        if request.method == "GET":
            return_data = {"results": "ok"}
        elif request.method == "POST":
            return_data = {"results": "ok"}
        return_data = {"results": "ok"}
        response_code = 200
    except Exception as e:  # TODO: list apprpriate errors here
        return_data = {"error": str(e)}
        response_code = 400
    response = make_response(jsonify(return_data), response_code)
    response.mimetype = 'application/json'
    response.headers['Content-Type'] = 'application/json'
    return response


@app.route('/setup', methods=["GET", "POST"])
@cross_origin()
def setup():
    """ """
    # GET to get info
    # POST to create/configure instance
    # PUT to compile instance
    try:
        if request.method == "GET":
            return_data = {"results": "ok"}
        elif request.method == "POST":
            return_data = {"results": "ok"}
        return_data = {"results": "ok"}
        response_code = 200
    except Exception as e:  # TODO: list apprpriate errors here
        return_data = {"error": str(e)}
        response_code = 400
    response = make_response(jsonify(return_data), response_code)
    response.mimetype = 'application/json'
    response.headers['Content-Type'] = 'application/json'
    return response


@app.route('/run', methods=["GET", "PUT", "POST"])
@cross_origin()
def run():
    """ """
    # GET to get info
    # POST to create/configure instance
    # PUT to compile instance
    try:
        if request.method == "GET":
            return_data = {"results": "ok"}
        elif request.method == "POST":
            return_data = {"results": "ok"}
        elif request.method == "PUT":
            return_data = {"results": "ok"}
        return_data = {"results": "ok"}
        response_code = 200
    except Exception as e:  # TODO: list apprpriate errors here
        return_data = {"error": str(e)}
        response_code = 400
    response = make_response(jsonify(return_data), response_code)
    response.mimetype = 'application/json'
    response.headers['Content-Type'] = 'application/json'
    return response


if __name__ == '__main__':
    app.run(host=HOST, port=PORT, use_reloader=False)
