Letters
=======

Computer Science in general and Artificial Intelligence in particular are
magical, mystical things that live in the hearts and minds of lofty research
labs. If you ask someone on the street how AI works, they'd laugh at you. Even
CS students and some CS researchers may laugh at you. That's how inaccessible
they are. They're magic in a box. But they don't have to be. Teaching toys that
give people a way to conceptualize the natural sciences are an enormous market.
I've seen how much joy they bring to my own kids. Computer science is ripe for
this kind of approach.

Letters is a platform for inspiring curiosity about Artifical Intelligence. One
part children's game, one part algorithm development kit, Letters gives you a
way to play with the basic concepts of supervised learning.

Do you remember the letters game as a kid? The one where you draw a letter on
your friend's back and they have to guess it? Letters uses this basic game
concept to train and test image classifiers. 

First, you train the classifier by drawing known letters with your finger. Each
drawing is used as a training example. The more drawings you make of the letter
C, the more experience the classifier has to draw on.

Second, you test the classifier by drawing an unknown letter. The classifier
uses the samples you've taught it to recognize the unknown letter. If the
classifier is wrong, it applies this feedback to do a better job next time.

Beyond playing the game, Letters provides a framework for experimenting with
feature extraction and classification algorithms. Think you can do a better job
than the algorithms in the box? Want to try your hand at gradient descent or
building a neural network? It's easy to drop in alternative algorithms and see
how they fare. Eventually, I'd love to make it so you can record one training
set and run it through several different algorithms to test them side by side.
