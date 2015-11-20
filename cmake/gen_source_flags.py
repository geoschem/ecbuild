# (C) Copyright 1996-2015 ECMWF.
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
# In applying this licence, ECMWF does not waive the privileges and immunities
# granted to it by virtue of its status as an intergovernmental organisation
# nor does it submit to any jurisdiction.

from collections import OrderedDict
from fnmatch import fnmatch
from json import JSONDecoder
import sys

usage = 'usage: %s RULES.json OUT.cmake DEFAULT_FLAGS FILE [ FILE ... ]' % __file__


def main():
    print sys.argv
    if len(sys.argv) < 5:
        print >> sys.stderr, usage
        sys.exit(1)
    default_flags = sys.argv[3].split()
    with open(sys.argv[1]) as f:
        rules = JSONDecoder(object_pairs_hook=OrderedDict).decode(f.read())
    with open(sys.argv[2], 'w') as f:
        for source in sys.argv[4:]:
            flags = default_flags[:]
            for pattern, op in rules.items():
                if fnmatch(source, pattern):
                    print pattern, 'matches', source, 'adding', op
                    flags += [flag for flag in op if flag not in flags]
            if flags:
                print 'Setting flags for', source, 'to', ' '.join(flags)
                f.write('set_source_files_properties(%s PROPERTIES COMPILE_FLAGS "%s")\n'
                        % (source, ' '.join(flags)))

if __name__ == '__main__':
    main()
