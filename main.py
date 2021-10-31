from flask import Flask
from flask import jsonify
from flask import request
import easyocr
app = Flask(__name__)


@app.route('/',  methods=["GET", "POST"])
def generateOCR():
    if request.method == "POST":
        data = request.files.get('image')
        data.save('img.jpg')
        reader = easyocr.Reader(['en'])
        result = reader.readtext('img.jpg')
        print(result)
        output_string = ''
        for i in result:
            print(i[1])
            output_string += " " + i[1]
        json_file = {}
        json_file['query'] = output_string
        return jsonify(json_file)
    else:
        return "Hello World"


if __name__ == "__main__":
    app.run()
