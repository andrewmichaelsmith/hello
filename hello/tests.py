import unittest
import hello
import urllib

from tornado.testing import AsyncHTTPTestCase, ExpectLog

class TestHello(AsyncHTTPTestCase):

    def get_app(self):
        return hello.make_app(xsrf=False)

    def test_new_message(self):

        message = {
            'body': 'Hello'
            }
        body = urllib.parse.urlencode(message)

        response = self.fetch(
            '/a/message/new',
            method='POST',
            body=body,
        )

        self.assertEquals(
            hello.global_message_buffer.cache[0]['body'],
            'Hello'
        )

    def test_new_message_logged(self):

        message = {
            'body': 'Hello'
            }
        body = urllib.parse.urlencode(message)


        with ExpectLog('tornado.access', '.*Hello.*'):
            response = self.fetch(
                '/a/message/new',
                method='POST',
                body=body,
            )

    

