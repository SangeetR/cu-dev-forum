from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)
from werkzeug.exceptions import abort

from devForum.auth import login_required
from devForum.db import get_db

bp = Blueprint('posts', __name__)

@bp.route('/')
def index():
    db = get_db()
    posts = db.execute(
        'SELECT q_id, author_id, created, title, body, username'
        ' FROM question JOIN user ON question.author_id = user.id'
        ' ORDER BY created DESC'
    ).fetchall()
    return render_template('posts/index.html', posts=posts)

@bp.route('/ask-here', methods=('GET', 'POST'))
@login_required
def ask():
    if request.method == 'POST':
        title = request.form['title']
        body = request.form['body']
        error = None
    
        if not title:
            error = "Title Required"
        if not body:
            error ="Explain Your question "
        if error is not None:
            flash(error)
        else:
            db = get_db()
            db.execute(
                'INSERT INTO question (title, body, author_id)'
                'VALUES (?, ?, ?)',
                (title, body, g.user['id'])
            )
            db.commit()
            return redirect(url_for('index'))
    
    return render_template('posts/ask.html')

