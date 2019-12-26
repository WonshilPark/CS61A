CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT dogs.name, sizes.size from dogs, sizes where dogs.height > sizes.min and dogs.height <= sizes.max;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child FROM parents, dogs WHERE parent = name ORDER BY height DESC;

-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT "Replace";

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT s1.name || ' and ' || s2.name || ' are ' || s2.size || ' siblings'
  FROM size_of_dogs AS s1, size_of_dogs as s2, parents AS p1, parents as p2
  where s1.size = s2.size and s1.name != s2.name and p1.child = s1.name and p2.child = s2.name
  and p1.parent = p2.parent and s1.name < s2.name order by s2.name;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height);

-- Add your INSERT INTOs here
INSERT INTO stacks_helper(dogs, stack_height, last_height)
  SELECT name, height, height from dogs;
INSERT INTO stacks_helper(dogs, stack_height, last_height)
  SELECT dogs || ", " || name, stack_height + height, height from dogs, stacks_helper where last_height < height;
INSERT INTO stacks_helper(dogs, stack_height, last_height)
  SELECT dogs || ", " || name, stack_height + height, height from dogs, stacks_helper where last_height < height;
INSERT INTO stacks_helper(dogs, stack_height, last_height)
  SELECT dogs || ", " || name, stack_height + height, height from dogs, stacks_helper where last_height < height;
CREATE TABLE stacks AS
  SELECT dogs, stack_height FROM stacks_helper where stack_height >= 170 ORDER BY stack_height ASC;
