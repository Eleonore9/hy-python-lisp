# (= Hy (+ Python Lisp))

Spreading parens <3 with Python

Look at that CUTE logo by [Karen Rustad Tölva](https://twitter.com/whoisaldeka):
![cuddles](img/cuddles-transparent-small.png)

### Content

* [About Lisp](#about-lisp)
* [Intro to Hy](#intro-to-hy)
* [A Hy programme](#a-hy-programme)
* [Hy under the hood](#hy-under-the-hood)
* [Other features](#other-features)

### About Lisp

Formely LISP for "LISt Processor".

It was specified in 1958 which makes it the second oldest high-level programming
language still in use today (after Fortran).
Influenced by [lambda calculus](https://en.wikipedia.org/wiki/Lambda_calculus), Lisp was created as a practical mathematical notation for computer programs and became the most widely used language in artificial intelligence research.

Lisp syntax is characterised by parenthesized lists where the function is the first element and is followed by its arguments:
```
(function argument1 argument2)
```
Today several Lisp dialects are used for general purpose (web development, data engineering...); [Common Lisp](https://common-lisp.net/), [Scheme](http://www.schemers.org/), [Clojure](http://clojure.org/)... and Hy =)

### Intro to Hy

[Hy](https://github.com/hylang/hy) is a Lisp dialect that converts its structure to Python, allowing to explore Lisp within leaving the comfort of Python.

Willing to give it a go? You can [try Hy](https://try-hy.appspot.com/) in your browser!
It's as easy as `(print "hello world")`.
And calculations go from
```
(3.5 + 5.1 + 4.6) / 3
```
to
```
(/ (+ 3.5 5.1 4.6) 3)
```
Now use the [Quickstart](http://docs.hylang.org/en/latest/quickstart.html) guide to install Hy in a virtual environment and write your first Hy programme in a `.hy` file!

In Hy you have access to all of Python data structures and the standard library.

Example 1: for loop

```
=> (for [i (range 10)]
	(print (+ "Count is " (str i))))

Count is 0
Count is 1
Count is 2
Count is 3
Count is 4
Count is 5
Count is 6
Count is 7
Count is 8
Count is 9

```

Example 2: function definition

```Hy
(defn fizzbuzz [num]
  (for [n (range 1 num)]
    (cond
     [(= 0 (% n 15)) (print n "fizzbuzz")]
     [(= 0 (% n 3)) (print n "fizz")]
     [(= 0 (% n 5)) (print n "buzz")])))
```
```Hy
=> (fizzbuzz 16)
3 fizz
5 buzz
6 fizz
9 fizz
10 buzz
12 fizz
15 fizzbuzz
```

See [try\_hy.hy](/try_hy.hy)


### A Hy programme

Analyse the content of ebooks from the [Gutenberg project]().

See [text\_analysis.hy](/text_analysis.hy)

For this script I need to import the modules `os`, `re`, `pprint` and the method `Counter` from the module `collections`. Here's what a Hy import statement looks like:
```
(import os re pprint [collections [Counter]])
```

This programme when called from the command line `./text\_analysis.hy "data/"` runs an analysis for all text files in the `"data/"` directory.

Here's what the analysis function looks like:

```Hy
(defn analyse-texts [dirpath]
  (setv text-files (list-text-files dirpath))
  (list (map (fn [f]
               (setv filename f)
               (-> f
                   read-text
                   clean-text
                   remove-stopwords
                   (summarise-text filename)))
             text-files)))
```

The first step is creating a list of all the text files in the directory.
It then maps over the list of text file to apply the steps of the analysis on each text file.
This is done with a threading macro and more precisely the "thread first" macro, represented by a single arrow `->`. It's the equivalent of several level of nesting but is easier to read.
Each file `f` is read, cleaned, has its stopwords removed and then summarised.

### Hy under the hood


### Other features


____

**References:**

* [Lisp](https://en.wikipedia.org/wiki/Lisp_%28programming_language%29) wikipedia page
* [Hy's docs](http://docs.hylang.org/en/latest/)
* [More docs](https://github.com/hylang/hy/blob/master/docs/language/api.rst)
* [Hy's source code](https://github.com/hylang/hy)
* [Podcast.\_\_init\_\_ episode 23](http://pythonpodcast.com/hylang-developers.html)
