from django.shortcuts import render
from django.http import HttpResponse
import requests
import json

def catfact(request):
    try:
        response = requests.get('https://catfact.ninja/fact')
        content = response.content
        content = json.loads(content)
        fact = content['fact']
    except:
        pass
        
    return render(request, 'catfact.html', {'fact': fact})