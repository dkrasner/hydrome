import argparse

from flask_cors import cross_origin
from flask import (Flask, request, session, jsonify, make_response,
                   render_template)


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

if DEBUG:
    app.config['DEBUG'] = True
else:
    app.config['propagate_exceptions'] = True


@app.route('/', methods=["GET"])
@cross_origin()
def model_info():
    """ """
    return_data = {"results": "ok"}
    resp_code = 200
    response = make_response(jsonify(return_data), resp_code)
    response.mimetype = 'application/json'
    response.headers['Content-Type'] = 'application/json'
    return response


if __name__ == '__main__':
    app.run(host=HOST, port=PORT, use_reloader=False)
