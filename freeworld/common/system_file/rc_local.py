# /usr/bin/env python3
# coding=utf-8
from freeworld.common.system_file.base_system_file import BaseSystemFile;

class RcLocal(BaseSystemFile):
    """
    rc.local的配置文件类
    """
    def __init__(self):
        pass

    def add_boot_item(self, cmd, name=None):
        """
        增加启动项
        :param name:
        :param cmd:
        """
        pass