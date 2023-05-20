
# Welcome to the end of Chapter 1 of Stats110! Here we have some commented
# R code in order to improve your learning.
# R is indexed at 1! Not 0!

# Vectors

v <- c(3, 1, 4, 1, 5, 6, 9) 

# the left arrow is the same as =

# the c command stands for combine/concatenate, use v[i] to access entries
# We can also get subvectors easily: v[c(1, 3, 5)] gives the vector consisting
# of the 1st, 3rd, and 5th entries of v. We can also get a subvector by specifying
# what to exclude using a minus sign: v[-(2:4)] (gives vector obtained by removing
# the 2nd through 4th entries of 4)

# If m and n are integers then m:n gives the sequence of integers from m to n

# Most operations in R are interpreted componentwise. In math, we can't cube 
# vectors, but in R typing v^3 cubes each entry individually.

# Factorials and binomial coefficients

# we can compute n! using factorial(n) and n choose k using choose(n, k). Add
# l at the beginning for log variants (lfactorial, lchoose)

# Sampling and simulations

# The sample command is a useful way of drawing random samples in R. Technically,
# they are pseudo-random since there is an underlying deterministic algorithm, but
# they look like random samples for almost all practical purposes. For example,

n <- 10; k <- 5
n <- 10; k <- 5
sample(n, k)

# This generates an ordered random sample of 5 of the numbers from 1 tom10, without
# replacement, and with equal probabilities given to each number. To sample with 
# replacement instead, just add in replace = TRUE . The sample command also allows us
# to specify general probabilities for sampling each number. For example, 

sample(4, 3, replace=TRUE, prob=c(0.1, 0.2, 0.3, 0.4))

# samples three numbers between 1 and 4, with replacement, and with probabilities given 
# by (0.1, 0.2, 0.3, 0.4). If the sampling is without replacement, then at each stage the 
# probability of any not-yet-chosen number is proportional to its original probability. 

# Generating many random samples allows us to perform a simulation for a probability
# problem. The replicate command, explained below, is a convenient way to do this.

# Matching problem simulation

# We can show by simulation that the probability of a matching card (as in Example 1.6.4)
# is approximately 1 - 1/e when the deck is sufficiently large. Using R, we can perform
# the experiment a bunch of times and see how many times we encounter at least one matching card:

n <- 100                                     # number of cards
r <- replicate(10^4, sum(sample(n)==(1:n)))  # shuffle; count matches
match_prob = sum(r>=1)/10^4                  # proportion with a match

# Line by line we have
# 1. We choose how many cards are in the deck (e.g., 100 cards)
# 2. In the second line, we work from the inside out:
#   - sample(n) == (1:n) is a vector of length n, the ith element of equals 1
#     if the ith cards matches its position in the deck and 0 otherwise. That is
#     because for two numbers a and b, the expression a==b is TRUE if a = b and
#     FALSE otherwise, and TRUE is encoded as 1 and FALSE is encoded as 0.
#   - sum adds up the elements of the vector, giving us the number of matching
#     cards in this run of the experiment
#   - replicate does this 10^4 times. We store the results in r, a vector of length
#     10^4 containing the numbers of matched cards from each run of the experiment.
# 3. We add up the number of times where there was at least one matching card,
#    and divide by the number of simulations

# Birthday problem calculation and simulation

# prod gives the product of a vector. To calculate the probability of at least
# one birthday match in a group of 23 people:

k <- 23
k_prob_bday = 1 - prod((365-k+1):365)/365^k

# R has built-in functions, pbirthday and qbirthday, for the birthday problem.
# pbirthday(k) returns the probability of at least one match if the room has k
# people. qbirthday(p) returns the number of people needed in order to have
# probability p of at least one mathc. E.g., pbirthday(23) is 0.507 and 
# qbirtday(0.5) is 23. We can also find the probability of having at least one
# triple birtday match. All we have to do is add coincident=3 to say we're 
# looking for triploe matches. E.g., pbirthday(23, coincident=3) returns 0.014.

# To simulate the birthday problem, we can use

b <- sample(1:365, 23, replace=TRUE)
tabulate(b)

# This generates random birthdays for 23 people and then tabulates the counts of
# how many people were born on each day. We can run 10^4 repetitions as follows:

r <- replicate(10^4, max(tabulate(sample(1:365, k, replace=TRUE))))
rand_bday_k = sum(r>=2)/10^4
