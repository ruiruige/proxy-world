# /usr/bin/env python3
# coding=utf-8
from abc import abstractmethod


class BaseConfigFile:
    def __init__(self):
        pass

    @abstractmethod
    def get_value(self, key):
        pass

    @abstractmethod
    def key_exist(self, key):
        pass
