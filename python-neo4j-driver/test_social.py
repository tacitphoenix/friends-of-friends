import pytest
import social

def test_insert_friends():
    assert social.insert_friends() == None

def test_common_friends():
    assert social.common_friends() == "Bob"

def test_friends_of_a_friend():
    assert social.friends_of_a_friend() == "Anna"

def test_connecting_paths():
    result = social.connecting_paths()
    assert len(result) == 4
