from flask import Blueprint, render_template

weblog = Blueprint('weblog', __name__, static_folder='static')

@weblog.route('/')
def index():
    return render_template('weblog.html')

@weblog.route('/projects')
def projects():
    return render_template('projects.html', title='Projects')

@weblog.route('/notes')
def notes():
    return render_template('notes.html', title='Notes')

@weblog.route('/contact')
def contact():
    return render_template('contact.html', title='Contact')
