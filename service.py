from subprocess import check_call
from templates import render_template

class ServiceTemplate():
    def __init__(self, template, target):
        self.template = template
        self.target = target

    def render(self):
        return render_template(self.template, self.target)

class Service():
    def __init__(self, name, templates, restart_command):
        self.name = name
        self.templates = templates
        self.restart_command = restart_command

    def configure(self):
        for template in self.templates:
            if template.render():
                self.needs_restart = True

    def restart_if_needed(self):
        if self.needs_restart:
            self.restart()
            self.needs_restart = False

    def restart(self):
        check_call(self.restart_command)

class SystemdService(Service):
    def __init__(self, name, templates):
        super().__init__(name, templates, ["systemctl", "restart", name])
