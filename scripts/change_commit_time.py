''' HOW TO USE
Requires https://github.com/newren/git-filter-repo

# You need to be in a freshly-cleaned repo. Or use --force.
git clone <...> your_repo
cd your_repo

# First just a dry run.
git filter-repo --dry-run --commit-callback "$(cat ../change_time.py)"

# And now do it for real
git filter-repo --commit-callback "$(cat ../change_time.py)"

'''

from datetime import datetime
from datetime import timedelta


def is_weekend(date):
    return date.weekday() > 4


def handle(commit):

    committer_date = commit.committer_date.decode('utf-8')
    [_seconds, _timezone] = committer_date.split()
    dt_object_committer = datetime.fromtimestamp(int(_seconds))

    author_date = commit.author_date.decode('utf-8')
    [seconds, timezone] = author_date.split()
    dt_object = datetime.fromtimestamp(int(seconds))

    if not is_weekend(dt_object):
        print(f"Is NOT weekend: {dt_object}")
        # sunday = dt_object - timedelta(days=dt_object.weekday() + 1)
        sunday = dt_object - timedelta(days=((dt_object.isoweekday() + 1) % 7))
        new_date = f"{int(sunday.timestamp())} +0000"
        commit.author_date = new_date.encode('utf-8')
    else:
        print(f"Is weekend: {dt_object}")

    if not is_weekend(dt_object_committer):
        print(f"Is NOT weekend: {dt_object_committer}")
        sunday = dt_object_committer - \
            timedelta(days=((dt_object_committer.isoweekday() + 1) % 7))
        new_date = f"{int(sunday.timestamp())} +0000"
        commit.committer_date = new_date.encode('utf-8')
    else:
        print(f"Is weekend: {dt_object_committer}")


handle(commit)
