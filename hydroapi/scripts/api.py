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


@app.route('/model', methods=["GET", "POST"])
@cross_origin()
def model():
    """ """
    # GET to get info
    # POST to create/configure/compile instance
    try:
        if request.method == "GET":
            name = request.args.get("name")
            return_data = {"results": api.model_info(name)}
        elif request.method == "POST":
            model_args = request.json.get("model_args")
            compile_args = request.json.get("compile_args")
            status = api.model_compile(model_args, compile_args)
            return_data = {"results": {"status": status}}
        response_code = 200
    except Exception as e:  # TODO: list apprpriate errors here
        return_data = {"error": str(e)}
        response_code = 400
    response = make_response(jsonify(return_data), response_code)
    response.mimetype = 'application/json'
    response.headers['Content-Type'] = 'application/json'
    return response


@app.route('/domain', methods=["GET"])
@cross_origin()
def domain():
    """ """
    # GET to get info
    # POST to create/configure instance
    # PUT to compile instance
    try:
        name = request.args.get("name")
        return_data = {"results": api.domain_info(name)}
        response_code = 200
    except Exception as e:  # TODO: list apprpriate errors here
        return_data = {"error": str(e)}
        response_code = 400
    response = make_response(jsonify(return_data), response_code)
    response.mimetype = 'application/json'
    response.headers['Content-Type'] = 'application/json'
    return response


@app.route('/setup', methods=["POST"])
@cross_origin()
def setup():
    """ """
    # GET to get info
    # POST to create/configure instance
    # PUT to compile instance
    try:
        model = request.json.get("model")
        domain = request.json.get("domain")
        status = api.setup(model, domain)
        return_data = {"results": {"status": status}}
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
    # TODO: unclear what happens here
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
