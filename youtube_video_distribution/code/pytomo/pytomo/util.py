#!/usr/bin/python

import json


def load_json_from_file(path):
    try:
        json_file = open(path)
        return json.load(json_file)
    except Exception as e:
        print e.message
        raise e


class YoutubeHelper:

    URL_PREFIX = 'http://www.youtube.com/watch'
    VIDEO_QUERY_PARAM = 'v'

    def __init__(self):
        pass

    @staticmethod
    def api_response_to_video_url_list(api_json_response):
        api_json_response = YoutubeHelper.__ensure_dict(api_json_response)
        urls = map(lambda x: YoutubeHelper.__youtube_json_schema_to_url(x), api_json_response['items'])
        return list(urls)

    @staticmethod
    def __youtube_json_schema_to_url(schema):
        schema = YoutubeHelper.__ensure_dict(schema)
        video_id = schema.get('id')
        if video_id is None:
            raise Exception('id must be defined')
        return YoutubeHelper.__compose_video_url(video_id)

    @staticmethod
    def __compose_video_url(video_id):
        return YoutubeHelper.URL_PREFIX + '?' + YoutubeHelper.VIDEO_QUERY_PARAM + '=' + video_id

    @staticmethod
    def __ensure_dict(maybe_dict):
        if type(maybe_dict) is dict:
            return maybe_dict
        else:
            return json.loads(maybe_dict)
