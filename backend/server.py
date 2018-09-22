from http.server import HTTPServer
from http.server import BaseHTTPRequestHandler
import cgi
from tempfile import SpooledTemporaryFile
from PIL import Image

class PostHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        print("got request")
        length = int(self.headers.get('content-length'))
        with SpooledTemporaryFile() as imgfile:
            read = 0
            i = 0
            while read < length:
                buffer = self.rfile.read(min(1024, length-read))
                if not buffer:
                    # too short, return error
                    print("BAD SHORT BUFFER SHIT")
                    return
                imgfile.write(buffer)
                read += len(buffer)
                i+=1
            imgfile.seek(0)
            img = Image.open(imgfile)
            newIm = img.convert('RGB')
            newIm.save("poster.jpg")
        print("done with post")
        message = "Successfully received image"
        self.send_response(200)
        self.end_headers()
        self.wfile.write(str.encode(message))
        return

server = HTTPServer(('localhost', 8080), PostHandler)
print('Starting server, use <Ctrl-C> to stop')
server.serve_forever()