from flask import Blueprint, render_template

import sqlite3

weblog = Blueprint('weblog', __name__, template_folder='templates', static_folder='static')

database_file = 'weblog/weblog.db'

@weblog.route('/')
def index():
    return render_template('weblog.html')

@weblog.route('/projects')
def projects():
    with sqlite3.connect(database_file) as conn:
        conn.row_factory = sqlite3.Row
        c = conn.cursor()
        c.execute('select * from projects;')
        projects = c.fetchall()
    return render_template('projects.html', title='Projects', projects=projects)

@weblog.route('/notes')
def notes():
    with sqlite3.connect(database_file) as conn:
        conn.row_factory = sqlite3.Row
        c = conn.cursor()
        c.execute('select * from notes;')
        notes = c.fetchall()
    return render_template('notes.html', title='Notes', notes=notes)

@weblog.route('/contact')
def contact():
    return render_template('contact.html', title='Contact')
