from coalib.bears.LocalBear import LocalBear
import json
import collections
from collections import OrderedDict
from coalib.results.Result import Result


class DuplicateProjectNamesBear(LocalBear):

    LANGUAGES = {'JSON'}
    AUTHORS = {'DailyDrip'}
    AUTHORS_EMAILS = {'devs@dailydrip.com'}
    LICENSE = 'AGPL-3.0'

    def run(self,
            filename,
            file):
        # Output a meaningful message if empty file given as input
        if len(file) == 0:
            yield Result.from_values(self,
                                     'This file is empty.',
                                     file=filename)
            return

        try:
            json_content = json.loads(''.join(file),
                                      object_pairs_hook=OrderedDict)
        except JSONDecodeError as err:
            err_content = match(r'(.*): line (\d+) column (\d+)', str(err))
            yield Result.from_values(
                self,
                'This file does not contain parsable JSON. ' +
                err_content.group(1) + '.',
                file=filename,
                line=int(err_content.group(2)),
                column=int(err_content.group(3)))
            return

        project_names = list(map(lambda entry: entry['name'], json_content))
        duplicates = [item for item, count in collections.Counter(project_names).items() if count > 1]
        print(duplicates)

        if len(duplicates) > 0:
            yield Result.from_values(
                self,
                'The following project names are duplicated: ' +
                ', '.join(duplicates),
                file=filename
            )

        return
