import json
import urllib
from random import randint


def random_str(str_size):
    res = ""
    for i in xrange(str_size):
        x = randint(0, 25)
        c = chr(ord('a')+x)
        res += c
    return res


def find_watch(text, pos):
    start = text.find("watch?v=", pos)
    if start < 0:
        return None, None
    end = text.find(" ", start)
    if end < 0:
        return None, None

    if end-start > 200:  # silly heuristics, probably not a must
        return None, None

    return text[start:end-1], start


def find_random_video_id():
    base_url = 'https://www.youtube.com/results?search_query='
    url = base_url+random_str(3)
    r = urllib.urlopen(url).read()
    links = {}
    pos = 0
    while True:
        link, pos = find_watch(r, pos)
        if link is None or pos is None:
            break
        pos += 1
        if ";" in link:
            continue
        links[link] = 1

    items_list = links.items()

    list_size = len(items_list)
    selected = randint(list_size/2, list_size-1)
    remove_this_part = 'watch?v='
    params = items_list[selected][0]
    params = params.replace(remove_this_part, '')
    return params  # id


def random_video_ids_with_youtube_api_schema(count=500):
    return {
        'items': [
            {'id': find_random_video_id()} for _ in range(count)
        ]
    }


print json.dumps(random_video_ids_with_youtube_api_schema(200))
