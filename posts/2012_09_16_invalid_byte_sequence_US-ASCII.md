Hit my blog this morning and was very supprised to see it busted
It was complaining about invalid byte sequence in US-ASCII textile_doc.rb.

Not sure what triggered the error because it has been fine for the past week without anyone touching it...

After some quick googling I was able to find the solution. Add UTF-8 as your default encoding.
You can either do this in your environment.rb or config.ru with the following lines:

	Encoding.default_external = Encoding::UTF_8
	Encoding.default_internal = Encoding::UTF_8

After adding the lines and running a `cap deploy` prod was fixed :)

-Matt