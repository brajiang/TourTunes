try:
    import Image
except ImportError:
    from PIL import Image
import pytesseract

print(pytesseract.image_to_string(Image.open('../tour_posters/tconcert.jpeg')))
