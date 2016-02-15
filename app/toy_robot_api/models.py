from django.db import models

class Robot(models.Model):
    name = models.CharField(max_length=30)

# class Position(models.Model):
#     robot = models.ForeignKey(Robot, on_delete=models.CASCADE)
#     angle = models.CharField(max_length=30)
#     x_pos = models.PositiveIntegerField()
#     y_pos = models.PositiveIntegerField()   