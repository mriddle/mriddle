Marcus Kazmierczak came up with a list of 10 one-liner examples that are meant to showcase [Scala’s expressiveness](http://solog.co/47/10-scala-one-liners-to-impress-your-friends/) . A [CoffeeScript version]http://ricardo.cc/2011/06/02/10-CoffeeScript-One-Liners-to-Impress-Your-Friends.html) quickly emerged, and now a [Ruby one](http://programmingzen.com/2011/06/02/10-ruby-one-liners-to-impress-your-friends/)

<b>Multiply each item in a list by 2</b>

<pre>
(1..10).map { |n| n * 2 }
</pre>

<b>Sum a list of numbers</b>

<pre>
(1..1000).inject { |sum, n| sum + n }
</pre>

Or using the (built in) Symbol#to_proc syntax that’s been available since Ruby 1.8.7:

<pre>
(1..1000).inject(&:+)
</pre>

Or even just passing a symbol directly:

<pre>
(1..1000).inject(:+)
</pre>

<b>Verify if tokens exist in a string</b>

<pre>
words = ["scala", "akka", "play framework", "sbt", "typesafe"]
tweet = "This is an example tweet talking about scala and sbt."

words.any? { |word| tweet.include?(word) }
</pre>

<b>Reading a file</b>

<pre>
file_text = File.read("data.txt")
file_lines = File.readlines("data.txt")
</pre>

The latter includes “\n” at the end of each element of the array, which can be trimmed by appending .map { |str| str.chop } or by using the alternative version:

<pre>
File.read("data.txt").split(/\n/)
</pre>

<b>Happy Birthday</b>

<pre>
4.times { |n| puts "Happy Birthday #{n==2 ? "dear Tony" : "to You"}" }
</pre>

<b>Filter a list of numbers</b>

<pre>
[49, 58, 76, 82, 88, 90].partition { |n| n > 60 }
</pre>

<b>Fetch and parse an XML web service</b>

<pre>
require 'open-uri'
require 'hpricot'

results = Hpricot(open("http://search.twitter.com/search.atom?&q=scala"))
</pre>

This example requires open-uri and hpricot or equivalent libraries (you could use builtin ones if you wish). It’s not too much code, but Scala clearly wins here.

<b>Find minimum (or maximum) in a list</b>

<pre>
[14, 35, -7, 46, 98].min
[14, 35, -7, 46, 98].max
</pre>

<b>Parallel Processing</b>

<pre>
require 'parallel'
Parallel.map(lots_of_data) do |chunk|
      heavy_computation(chunk)
end
</pre>

Unlike Scala, multicore support is not built-in. It requires parallel or a similar gem.

<b>Sieve of Eratosthenes</b>

The Scala one liner is very clever, but entirely unreadable. A simpler implementation that is no longer a one-liner in Ruby would be:

<pre>
index = 0
while primes[index]**2 <= primes.last
      prime = primes[index]
      primes = primes.select { |x| x == prime || x % prime != 0 }
      index += 1
end
</pre>

This last example is straight from [StackOverflow](http://stackoverflow.com/questions/241691/sieve-of-eratosthenes-in-ruby) . Not the prettiest code ever, but you get the idea.

-Matt