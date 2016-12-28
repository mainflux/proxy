import flask
app = flask.Flask(__name__)

@app.route("/access-checks", methods=['GET'])
def auth():
    resp = flask.Response("Foo bar baz")
    resp.headers['X-User'] = 'drasko123'
    return resp

if __name__ == "__main__":
    app.run(port=8180)
