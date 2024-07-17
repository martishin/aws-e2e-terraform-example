from flask import Flask, request, redirect, url_for
import boto3
import os

app = Flask(__name__)

S3_BUCKET = 'martishin-my-file-upload-bucket'

s3_client = boto3.client('s3')

@app.route('/')
def index():
    return '''
    <html>
        <body>
            <h1>Upload a File</h1>
            <form action="/upload" method="post" enctype="multipart/form-data">
                <input type="file" name="file">
                <input type="submit" value="Upload">
            </form>
        </body>
    </html>
    '''

@app.route('/upload', methods=['POST'])
def upload_file():
    file = request.files['file']
    if file:
        file.save(file.filename)
        s3_client.upload_file(
            Filename=file.filename,
            Bucket=S3_BUCKET,
            Key=file.filename
        )
        os.remove(file.filename)
        return 'File uploaded successfully'

if __name__ == '__main__':
    print("AWS_ACCESS_KEY_ID present", bool(os.getenv('AWS_ACCESS_KEY_ID')))
    print("AWS_SECRET_ACCESS_KEY present", bool(os.getenv('AWS_SECRET_ACCESS_KEY')))
    app.run(host='0.0.0.0', port=80)
