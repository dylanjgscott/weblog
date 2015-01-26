from flask import Flask
app = Flask(__name__)
app.config.from_pyfile('weblog.cfg')

from weblog.views import weblog

app.register_blueprint(weblog, url_prefix='', static_folder='static', static_url_path='static')
