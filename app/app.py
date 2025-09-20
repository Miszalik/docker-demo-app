from flask import Flask, render_template
import redis
import os

app = Flask(__name__)

# Configure Redis connection
redis_host = os.getenv('REDIS_HOST', 'localhost')
redis_port = int(os.getenv('REDIS_PORT', 6379))
r = redis.Redis(host=redis_host, port=redis_port, decode_responses=True)

@app.route('/')
def index():
    visits = r.incr('counter')
    return render_template('index.html', visits=visits)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)