#/usr/bin/env python3
# coding=utf-8

import traceback
import click


class config_file:

    """这是一个配置文件的类
    """

    def __init__(self,
                 fp=None,
                 select_mode="default",
                 multiple=True,
                 replacement=None,
                 config=None):

        self.__load__()

        self.fp = fp
        self.select_mode = select_mode
        self.replacement = replacement
        self.multiple = multiple
        self.config = config

        self.lines = None
        self.modified_lines = None

    def __load__(self):
        with open(self.fp, "rb") as f:
            self.lines = f.readlines()

    def __save__(self, fp=None):
        with open(self.fp, "wb") as f:
            f.writelines()

    def select(self,
               hit_feature=None,
               exclude_feature=None):

        hit_idxs = []
        for i in range(len(self.lines)):
            line = lines[i]

            if self.match(line=line, config=self.config, exclude_feature=exclude_feature):
                hit_idxs.append(i)

                if multiple:
                    continue
                else:
                    break

        return hit_idxs

    def match(self, line=None):
        rst = False

        if "default" == self.select_mode:
            cfg_left_idx = line.find(self.config)

            if -1 != cfg_left_idx:							# 当前行里面有配置项
                if -1 == line[:cfg_left_idx].find("#"):		# 配置项前面没有注释符
                    rst = True

        return rst

    def set_config(self):
        self.modified_lines = self.lines[:]

        if hit_idxs:
            for idx in hit_idxs:
                self.modified_lines[idx] = replacement
        else:
            self.modified_lines.append(self.replacement)

        self.__save__()


# click settings
CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])


@click.command(context_settings=CONTEXT_SETTINGS)
# if is_flag is used type=click.BOOL is not more needed
@click.option('--set-config', help='if set , will replace the matched line', is_flag=True)
@click.option('--config', help='configuration which will be used to match the line', is_flag=True)
@click.option('--file', '-f', help='specify your config file', required=True)
@click.option('--replacement', '-r', help='replace the matched line with this')
def entry(set_config, config, file_path,  replacement):

    if set_config:
        if config and replacement:
        	cf = config_file(fp=file_path, replacement=replacement, config=config)
        	cf.set_config()


if "__main__" == __name__:
    try:
        entry()

    except Exception as e:
        print e
        print traceback.format_exc()
