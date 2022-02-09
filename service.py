from ntpath import join
from os import listdir, unlink
from posixpath import abspath
from subprocess import check_call
from templates import render_template

class ServiceTemplate():
    def __init__(self, template, target):
        self.template = template
        self.target = target

    def render(self, caller, custom):
        return render_template(self.template, self.target, custom=custom, caller=caller)

def true_matcher(dir, file):
    return True

class Service():
    def __init__(self, name, templates, restart_command):
        self.name = name
        self.templates = templates
        self.restart_command = restart_command
        self.needs_restart = False
        self.extra_files = set()

    def validate(self):
        return True

    def custom_template_data(self):
        return None

    def configure(self):
        custom = self.custom_template_data()
        for template in self.templates:
            if self.render_template(template, custom=custom):
                self.needs_restart = True

    def collect_current_files(self, dir, matcher=true_matcher):
        self.extra_files = set(abspath(join(dir, file)) for file in listdir(dir) if file[0] != "." and matcher(dir, file))

    def render_template(self, tpl, custom=None):
        self.extra_files.discard(abspath(tpl.target))
        return render_template(tpl, custom=custom, caller=self)

    def remove_extra_files(self):
        for file in self.extra_files:
            unlink(file)
        self.extra_files = []

    def restart_if_needed(self):
        if self.needs_restart:
            self.restart()
            self.needs_restart = False

    def restart(self):
        check_call(self.restart_command)

class SystemdService(Service):
    def __init__(self, name, templates):
        super().__init__(name, templates, ["systemctl", "restart", name])
