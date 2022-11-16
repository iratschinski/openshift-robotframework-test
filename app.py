from flask import Flask
from flask import send_from_directory
import os

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello World!"

@app.route('/reports')
def send_index():
    return send_from_directory('reports', "index.html")

@app.route('/reports/<path:path>')
def send_report(path):
    if path == "":
        path = "index.html"
    return send_from_directory('reports', path)

if __name__ == '__main__':
    port = os.environ.get('FLASK_PORT') or 8080
    port = int(port)

    app.run(port=port,host='0.0.0.0')
