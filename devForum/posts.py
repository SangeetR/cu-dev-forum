from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)
from werkzeug.exceptions import abort

from devForum.auth import login_required
from devForum.db import get_db

bp = Blueprint('post', __name__)

@bp.route('/')
def index():
    db = get_db()
    posts = db.execute(
        'SELECT '
    )
