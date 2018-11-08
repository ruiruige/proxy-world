# /usr/bin/env python3
# coding=utf-8
from abc import abstractmethod


class BaseSystemFile(object):
    """
    系统文件的基类
    """

    connector = "="
    comment_symbols = ["#"]

    def __init__(self):
        pass

    @abstractmethod
    def get_setting(self, name):
        """
        获取设置
        :param name:
        """
        pass

    def add_multi_line_setting(self, name, value):
        """
        增加一个多行的配置
        :param name:
        :param value:
        """
        pass

    def match_lines_util_break(self):
        """
        待定
        """
        pass

    @abstractmethod
    def get_one_line_setting(self, name):
        """
        获取多行
        :param name:
        """
        pass

    @abstractmethod
    def get_multi_line_setting(self, name):
        pass

    def setting_exists(self, key):
        """
        判断设置是否存在
        :param key:
        """
        pass

    def get_setting_occurrence(self):
        """
        get the occurrence of the setting in the format of line number
        """
        pass

    def is_line_about_setting(self, setting, line):
        """
        to test if the given line is about the given setting
        :param setting:
        :param line:
        """
        if setting not in line:
            return False

        if self.connector not in line:
            return False

        for symbol in self.comment_symbols:
            if line.startswith(symbol):
                return False

        first_connector_index = line.find(self.connector)
        line_setting_part = line[:first_connector_index]

        if setting in line_setting_part.strip():
            return True
        return False
