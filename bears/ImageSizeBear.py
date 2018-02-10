from coalib.bearlib.abstractions.Linter import linter
from coalib.results.Result import Result

@linter(executable='identify')
class ImageSizeBear:
    USE_RAW_FILES = True

    def process_output(self, output, filename, file,
                       width: int, height: int):
        return true

    @staticmethod
    def create_arguments(filename, file, config_file):
        """
        Bear configuration arguments.
        """
        return (filename)
