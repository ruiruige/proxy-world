#/usr/bin/env python3
# coding=utf-8

import traceback
import click


line_feed = "\n"


class config_file:

    """这是一个配置文件的类
    """

    def __init__(self,
                 fp=None,
                 select_mode="default",
                 multiple=True,
                 replacement=None,
                 config=None):

        self.fp = fp
        self.select_mode = select_mode
        self.replacement = replacement
        self.multiple = multiple
        self.config = config

        self.__load__()

        # 复制一份文件内容到修改区域
        self.modified_lines = self.lines[:]

        # run init functions
        self.adjust_replacement()

    def __load__(self):
        # t 表示text模式，读取的是str
        # b 表示binary模式，读取的是bytes
        with open(self.fp, "rt") as f:
            self.lines = f.readlines()

    def save(self, fp=None):
        with open(self.fp, "wt") as f:
            f.writelines(self.modified_lines)

    def select(self,
               hit_feature=None,
               exclude_feature=None):

        hit_idxs = []
        for i in range(len(self.lines)):
            line = self.lines[i]

            if self.match(line=line):
                hit_idxs.append(i)

                if self.multiple:
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

    def append_replacement(self):
        last_line = self.modified_lines[-1]

        # 如果最后一行，没有换行符，给它加上
        if not last_line.endswith(line_feed):
            self.modified_lines[-1] = last_line + line_feed

        self.modified_lines.append(self.replacement)

    def adjust_replacement(self):
        """调整填充物，使其符合规范
        目前仅仅是给其后面增加一个换行符
        """
        # 如果待添加的新行，开头有换行符，认为是业务内容，不予处理

        # 如果待添加的新行，最后没有换行符，给它加一个
        if not self.replacement.endswith(line_feed):
            self.replacement = self.replacement + line_feed

    def set_config(self):
        hit_idxs = self.select()

        if hit_idxs:
            for idx in hit_idxs:
                self.modified_lines[idx] = self.replacement
        else:
            self.append_replacement()

    def append_boot_cmd(self):
        # 找到"exit 0" 然后删掉
        for i in range(len(self.modified_lines)-1, -1, -1):
            line = self.modified_lines[i]

            if line.strip() == "exit 0":
                del self.modified_lines[i]
                break

        # 设置配置项
        self.config()
        # 补回一个exit 0
        self.modified_lines.append("exit 0\n")

# click settings
CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])


@click.command(context_settings=CONTEXT_SETTINGS)
# if is_flag is used type=click.BOOL is not more needed
@click.option('--set-config', help='if set , will replace the matched line', is_flag=True)
@click.option('--append-boot-cmd', help='if set , will add a boot command to /etc/rc.local', is_flag=True)
@click.option('--config', help='configuration which will be used to match the line')
@click.option('--file', '-f', "file_path", help='specify your config file', required=True)
@click.option('--replacement', '-r', help='replace the matched line with this')
def entry(set_config, append_boot_cmd, config, file_path, replacement):

    if set_config:
        if config and replacement:
            cf = config_file(
                fp=file_path, replacement=replacement, config=config)
            cf.set_config()
            cf.save()

    if append_boot_cmd:
        if config and replacement:
            cf = config_file(
                fp=file_path, replacement=replacement, config=config)
            cf.append_boot_cmd()
            cf.save()


if "__main__" == __name__:
    try:
        entry()

    except Exception as e:
        print(e)
        print(traceback.format_exc())
