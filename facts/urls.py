from django.urls import path
from . import views

urlpatterns = [
    path('catfact/', views.catfact())
]
