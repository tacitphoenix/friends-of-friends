package com.tacitphoenix.neo4j;

import static org.junit.Assert.assertEquals;

import java.util.Arrays;
import java.util.List;

import org.junit.Test;
import org.neo4j.driver.v1.StatementResult;

public class SocialTest {
  @Test
  public void insertFriends() {
    Social social = new Social();
    StatementResult result = social.insertFriends();
    while (result.hasNext()){
        assertEquals(result.next().get("name").asList(), "Anna");
    }
  }

  @Test
  public void friendsOfAFriend() {
    Social social = new Social();
    StatementResult result = social.friendsOfAFriend();
    while (result.hasNext()){
        assertEquals(result.next().get("name").asString(), "Anna");
    }
  }

  @Test
  public void commonFriends() {
    Social social = new Social();
    StatementResult result = social.commonFriends();
    while (result.hasNext()){
        assertEquals(result.next().get("friend").asString(), "Bob");
    }
  }

  @Test
  public void connectingPaths() {
    List names = Arrays.asList("Joe", "Sally", "Anna", "Jim", "Billy");
    Social social = new Social();
    StatementResult result = social.connectingPaths();
    while (result.hasNext()){
        assertEquals(result.next().get("names").asList(), names);
    }
  }
}
