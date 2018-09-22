from BaseHTTPServer import HTTPServer
from BaseHTTPServer import BaseHTTPRequestHandler
import cgi
from tempfile import SpooledTemporaryFile
import SimpleHTTPServer
import SocketServer
from PIL import Image

class PostHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        length = 5000 #not sure what this should be
        with SpooledTemporaryFile() as imgfile:
            read = 0
            while read < length:
                buffer = self.rfile.read(1024)
                if not buffer:
                # too short, return error
                imgfile.write(buffer)
                read += len(buffer)
            if read > length or self.rfile.read(1):
                print("POST TOO LONG")

            img_file.seek(0)
            img = Image.open(img_file)
            newIm = img.convert('RGB')
            newIm.save("poster.jpg")
        return

server = HTTPServer(('localhost', 8080), PostHandler)
print('Starting server, use <Ctrl-C> to stop')
server.serve_forever()