#!/usr/local/bin/python2.7
from flup.server.fcgi import WSGIServer
from weblog import app

if __name__ == '__main__':
    WSGIServer(app, bindAddress='/var/www/run/weblog.sock').run()
