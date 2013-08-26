Sometimes data in a DB table needs to point to parent or child data. The result is a hierarchy. Here's an example of how folders on a file system might be represented:

<table class="data">
<tr><td>id</td><td>parent_id</td><td>name</td></tr>
<tr><td>1</td><td> </td><td>Top</td></tr>
<tr><td>2</td><td>1</td><td>Child 1</td></tr>
<tr><td>3</td><td>1</td><td>Child 2</td></tr>
<tr><td>4</td><td>2</td><td>Grand child</td></tr>
<tr><td>5</td><td> </td><td>Other Top</td></tr>
</table>

In the example, Top and Other Top are in the root (/ or C:\, depending whether you're from Unix world or Windows land). 

So, if I want to get all of the children and grandchildren of "Top" I can use a common table expression. This acts like a recursive query (technically it's iterative, not recursive - see the "how it works" part later for details).

<a name="query_parts"></a>A few parts are involved ([jump to see the whole thing first](#whole_query) if you prefer then come back here for the parts. Go on, I'll wait...):

- A definition for the recursive query 
<pre>WITH RECURSIVE folder_tree(id, parent_id, name) AS</pre>
- A starting point. In our case we want to begin at id=1;
<pre>SELECT id, parent_id, name
FROM folder
WHERE id = 1</pre>
- A UNION to add rows from the following query...
- A query that finds the child rows we want, based on what we found last time. In the first iteration, what we found last time will be the row(s) from the starting point. In second iteration, what we found last time will be the things from the first iteration, etc.
<pre>SELECT folder.id, folder.parent_id, folder.name
FROM folder, folder_tree
WHERE folder.parent_id = folder_tree.id</pre> 
The results from each iteration are also set aside to be returned as results via the final part as follows...
- Finally, something that uses the WITH query to return results. In this case, all of them will do:
<pre>SELECT * FROM folder_tree</pre>

<a name="whole_query"></a>The whole query looks like this ([back to the parts](#query_parts)): 

    WITH RECURSIVE folder_tree(id, parent_id, name) AS (
      SELECT id, parent_id, name
      FROM folder
      WHERE id = 1
      UNION
      SELECT folder.id, folder.parent_id, folder.name
      FROM folder, folder_tree
      WHERE folder.parent_id = folder_tree.id
    )
    SELECT * FROM folder_tree

The results include everything except the "Other Top" row:

<table class="data">
<tr><td>id</td><td>parent_id</td><td>name</td></tr>
<tr><td>1</td><td> </td><td>Top</td></tr>
<tr><td>3</td><td>1</td><td>Child 2</td></tr>
<tr><td>2</td><td>1</td><td>Child 1</td></tr>
<tr><td>4</td><td>2</td><td>Grand child</td></tr>
</table>

We can also build a path as we go, to show how we got to a given folder:

    WITH RECURSIVE folder_tree(id, parent_id, name) AS (
      SELECT id, parent_id, name, name AS path
      FROM folder
      WHERE id = 1
      UNION
      SELECT folder.id, folder.parent_id, folder.name, folder_tree.path || '/' || folder.name as path
      FROM folder, folder_tree
      WHERE folder.parent_id = folder_tree.id
    )
    SELECT * FROM folder_tree

<table class="data">
<tr><td>id</td><td>parent_id</td><td>name</td><td>path</td></tr>
<tr><td>1</td><td> </td><td>Top</td><td>Top</td></tr>
<tr><td>3</td><td>1</td><td>Child 2</td><td>Top/Child 2</td></tr>
<tr><td>2</td><td>1</td><td>Child 1</td><td>Top/Child 1</td></tr>
<tr><td>4</td><td>2</td><td>Grand child</td><td>Top/Child 1/Grand child</td></tr>
</table>

### How it works###

![How recursive SQL works](http://i1272.photobucket.com/albums/y383/atlas2ninjas/RecursiveSQL1_zps242f6777.png)