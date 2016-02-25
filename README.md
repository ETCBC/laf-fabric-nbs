![shebanq](https://raw.github.com/ETCBC/laf-fabric-nbs/master/images/VU-ETCBC-small.png)
![laf-fabric](https://raw.github.com/ETCBC/laf-fabric-nbs/master/images/laf-fabric-small.png)
![etcbc4easy](https://raw.github.com/ETCBC/laf-fabric-nbs/master/images/etcbc4easy-small.png)

IPython notebooks developed for the study of the Hebrew Bible and their textual sources.

> We see some people who are attached to this thing at one time, and attached to something else at another time.
This is like the one who is digging for water, and digs a little here and a little there.
He dies of thirst without finding water.
He is not like the one who digs in one place, trusting and relying on Allah.
He finds water and drinks and lets other people drink.

> Shaykh ad-Darqāwī

> [The Darqawi Way the Letters of Shaykh Mawlay Al Arabi Ad Darqawi, 116](http://www.scribd.com/doc/96341123/The-Darqawi-Way-the-Letters-of-Shaykh-Mawlay-Al-Arabi-Ad-Darqawi)

>[Martin Lings: What is sufism. Note on page 21, 22](http://books.google.nl/books?id=vTlRYfcwnK4C&pg=PA22&lpg=PA22&dq=martin+lings+what+is+sufism+digging+thirst&source=bl&ots=GHm4BBLQyX&sig=OKTUNntzuHMb2tILEIaxKK8oBCc&hl=en&sa=X&ei=Qck3U8T4PMK_ygOXj4CIAg&ved=0CCoQ6AEwAQ#v=onepage&q=martin%20lings%20what%20is%20sufism%20digging%20thirst&f=false)

# Table of notebooks

## Text
View the text itself, or visualizations of it.

* [plain](http://nbviewer.ipython.org/github/ETCBC/laf-fabric-nbs/blob/master/text/plain.ipynb)
* [proper](http://nbviewer.ipython.org/github/ETCBC/laf-fabric-nbs/blob/master/text/proper.ipynb)

Or view parts of the [Peshitta](http://en.wikipedia.org/wiki/Peshitta) text:

* [plain-calap](http://nbviewer.ipython.org/github/ETCBC/laf-fabric-nbs/blob/master/syriac/plain_calap.ipynb)

## Extra data
Making your own annotation and add them to the data for new analysis.

* [annox_workflow](http://nbviewer.ipython.org/github/ETCBC/laf-fabric-nbs/blob/master/extradata/annox_workflow.ipynb)

We used this approach to include data from the ETCBC centre that did not make it (yet) into their EMDROS database: paragraph information.
See

* [para from px](http://nbviewer.ipython.org/github/ETCBC/laf-fabric-nbs/blob/master/extradata/para from px.ipynb)

## Feature Studies
Explorations into the features in the ETCBC text database of the Hebrew Bible.

*Feature-Doc* below is a generic instrument to create a statistical overview of defined and undefined values of features selected by you.
Here you can also find the list of all available features.

The other notebooks contain descriptions of the meanings of certain features and their values,
and they will show you examples, and they will test assertions about them.
For example: *the ``clause_constituent_relation``-feature has value ``none`` for a node if and only if that node has no outgoing edges labeled ``mother``*.

* [feature-doc](http://nbviewer.ipython.org/github/ETCBC/laf-fabric-nbs/blob/master/featuredoc/feature-doc.ipynb)
* [clause_phrase_types](http://nbviewer.ipython.org/github/ETCBC/laf-fabric-nbs/blob/master/featuredoc/clause_phrase_types.ipynb)

# Linguistic Variation
Research into linguistic variation in the Hebrew Bible books.
Datamining, statistics, visualization.

* [cooccurrences](http://nbviewer.ipython.org/github/ETCBC/laf-fabric-nbs/blob/master/lingvar/cooccurrences.ipynb)
* [participle](http://nbviewer.ipython.org/github/ETCBC/laf-fabric-nbs/blob/master/lingvar/participle.ipynb)

## Syntax
Research to syntactic phenomena in the sentences of the Hebrew Bible.
Tree construction.
Correlating morphological features to syntactic functions.

* [trees (bhs)](http://nbviewer.ipython.org/github/ETCBC/laf-fabric-nbs/blob/master/trees/trees_bhs.ipynb)
* [trees (calap)](http://nbviewer.ipython.org/github/ETCBC/laf-fabric-nbs/blob/master/trees/trees_calap.ipynb)

## Participants
Research into the question who is saying what to whom in the psalms.
There are sudden shifts of the discourse *participants* in the psalms.
Can we chart the particiapnts in such a way that we see patterns in those shifts.
We aim to do network analysis with [AMCAT](http://amcat.vu.nl), and in the notebooks here we do explorative data preparation.

* [psalms12viz](http://nbviewer.ipython.org/github/ETCBC/laf-fabric-nbs/blob/master/trees/psalms12viz.ipynb)

## Querying
A database exists for the purpose of querying, and the ETCBC databas, in its EMDROS form, can be queried by means
of the MQL query language.
The LAF representation does not come with any serious querying functionality other than what you can do in Python.
But there is an module *etcbc.mql* by which you can fire queries to your local copy of the ETCBC database in sqlite3.
You can then retrieve the result as LAF node sets and continue with LAF-Fabric processing with these results.

* [MQL](http://nbviewer.ipython.org/github/ETCBC/laf-fabric-nbs/blob/master/querying/querying.ipynb)

# Getting started
In order to run these notebooks, you need:

* download/clone [LAF-Fabric](https://github.com/ETCBC/laf-fabric)
* read some documentation [LAF-Fabric](http://laf-fabric.readthedocs.org/en/latest/)
* [download data from the archive DANS-EASY](http://www.persistent-identifier.nl/?identifier=urn%3Anbn%3Anl%3Aui%3A13-048i-71).
  Hint: the compiled LAF version of the Hebrew Bible will suffice: *laf-fabric-data.zip*.
* see other notebooks at [contributions](https://github.com/ETCBC/contributions) and [study](https://github.com/ETCBC/study)

