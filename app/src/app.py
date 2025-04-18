from flask import Flask, jsonify
import pymysql

app = Flask(__name__)

@app.route('/health')
def health():
    return jsonify(status='healthy'), 200

@app.route('/data')
def data():
    conn = pymysql.connect(
        host='mysql', port=5655, user='root', password='example', database='testdb'
    )
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM test_table;")
    result = cursor.fetchall()
    conn.close()
    return jsonify(result)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=4743)
