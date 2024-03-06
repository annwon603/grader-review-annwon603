import static org.junit.Assert.*;
import org.junit.*;
import java.util.Arrays;
import java.util.List;

class IsMoon implements StringChecker {
  public boolean checkString(String s) {
    return s.equalsIgnoreCase("moon");
  }
}

public class TestListExamples {
  @Test(timeout = 500)
  public void testMergeRightEnd() {
    List<String> left = Arrays.asList("a", "b", "c");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }
  @Test(timeout = 500)
  public void testMergeDupes(){
    List<String> list = Arrays.asList("a","b","c");
    List<String> list2 = Arrays.asList("a","b","c");
    List<String> merged = ListExamples.merge(list,list2);
    List<String> expected = Arrays.asList("a", "a", "b", "b", "c","c");
    assertEquals(expected, merged);
  }
  @Test(timeout = 500)
  public void testFilter(){
    List<String> list = Arrays.asList("moon","a");
    List<String> result = ListExamples.filter(list, new IsMoon());
    List<String> expected = Arrays.asList("moon");
    assertEquals(expected, result);
  }

  @Test(timeout = 500, expected=IllegalArgumentException.class)
  public void testFilterArguments(){
    List<String> list = Arrays.asList("moon","a");
    List<String> result = ListExamples.filter(list, new IsMoon());
  }
}
