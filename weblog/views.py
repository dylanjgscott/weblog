from flask import Blueprint, render_template

import sqlite3

weblog = Blueprint('weblog', __name__, template_folder='templates', static_folder='static')

@weblog.route('/')
def index():
    return render_template('weblog.html')

@weblog.route('/projects')
def projects():
    return render_template('projects.html', title='Projects')

@weblog.route('/contact')
def contact():
    return render_template('contact.html', title='Contact')
