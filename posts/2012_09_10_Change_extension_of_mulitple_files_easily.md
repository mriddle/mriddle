Nifty script to rename multiple files with a given extension

```
for name in `ls *.old_extension` do 
  name1=`echo $name | sed -e 's/^\(.*\)\.old_extension$/\1\.new_extension/g'` 
  mv $name $name1
done
```

-Matt
