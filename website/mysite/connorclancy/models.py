from django.db import models

# Create your models here.
class ProfileImage(models.Model):
	image = models.FileField(upload_to='profile/%Y/%m/%d')