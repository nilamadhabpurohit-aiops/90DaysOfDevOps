from flask import Flask
import psycopg2
import redis
import os
app = Flask(__name__)

@app.route('/')
def home():
    try:
        conn = psycopg2.connect(host='db', dbname='appdb', user='postgres', password='password')
        cur = conn.cursor()
        cur.execute("SELECT version();")
        db_version = cur.fetchone()[0][:50]
        conn.close()
        db_status = f"✅ Postgres: {db_version}"
    except:
        db_status = "❌ Postgres: Connection failed"
    
    try:
        r = redis.Redis(host='redis', port=6379, db=0)
        visits = str(int(r.get('visits') or 0) + 1)
        r.set('visits', visits)
        redis_status = f"✅ Redis: {visits} visits"
    except:
        redis_status = "❌ Redis: Connection failed"
    
    return f"<h1>Day 34 DevOps Stack! 🚀</h1><p>{db_status}</p><p>{redis_status}</p>"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF