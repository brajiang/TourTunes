from django.shortcuts import render
from django.views.generic import TemplateView

# Create your views here.

class HomePageView(TemplateView):
    def get(self, request, **kwargs):
        return render(request, 'connorclancy/home.html', context=None)


def index(request):
    return render(request, 'connorclancy/home.html')
