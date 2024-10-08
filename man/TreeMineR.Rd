% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TreeMineR.R
\name{TreeMineR}
\alias{TreeMineR}
\title{Unconditional Bernoulli Tree-Based Scan Statistics for R}
\usage{
TreeMineR(
  data,
  tree,
  p = NULL,
  n_exposed = NULL,
  n_unexposed = NULL,
  dictionary = NULL,
  delimiter = "/",
  n_monte_carlo_sim = 9999,
  random_seed = FALSE,
  return_test_dist = FALSE,
  future_control = list(strategy = "sequential")
)
}
\arguments{
\item{data}{The dataset used for the computation. The dataset needs to include the
following columns:

\describe{
\item{\code{id}}{An integer that is unique to every individual.}
\item{\code{leaf}}{A string identifying the unique diagnoses or leafs for each individual.}
\item{\code{exposed}}{A 0/1 indicator of the individual's exposure status.}
}
See below for the first and last rows included in the example dataset.

\if{html}{\out{<div class="sourceCode">}}\preformatted{   id leaf exposed
    1 K251       0
    2 Q702       0
    3  G96       0
    3 S949       0
    4 S951       0
 ---
  999 V539       1
  999 V625       1
  999 G823       1
 1000  L42       1
 1000 T524       1
}\if{html}{\out{</div>}}}

\item{tree}{A dataset with one variable \code{pathString} defining the tree structure
that you would like to use. This dataset can, e.g., be created using
\code{\link{create_tree}}.}

\item{p}{The proportion of exposed individuals in the dataset. Will be calculated
based on \code{n_exposed}, and \code{n_unexposed} if both are supplied.}

\item{n_exposed}{Number of exposed individuals (Optional).}

\item{n_unexposed}{Number of unexposed individuals (Optional).}

\item{dictionary}{A \code{data.frame} that includes one \code{node} column and a \code{title} column,
which are used for labeling the cuts in the output of \code{TreeMineR}.}

\item{delimiter}{A character defining the delimiter of different tree levels within your
\code{pathString}. The default is \code{/}.}

\item{n_monte_carlo_sim}{The number of Monte-Carlo simulations to be used for calculating P-values.}

\item{random_seed}{Random seed used for the Monte-Carlo simulations.}

\item{return_test_dist}{If \code{true}, a data.frame of the maximum log-likelihood
ratios in each Monte Carlo simulation will be returned. This distribution
of the maximum log-likelihood ratios is used for estimating the P-value
reported in the result table.}

\item{future_control}{A list of arguments passed \code{future::plan}. This is useful if one would like
to parallelise the Monte-Carlo simulations to decrease the computation
time. The default is a sequential run of the Monte-Carlo simulations.}
}
\value{
A \code{data.frame} with the following columns:
\describe{
\item{\code{cut}}{The name of the cut G.}
\item{\code{n1}}{The number of exposed events belonging to cut G.}
\item{\code{n1}}{The number of inexposed events belonging to cut G.}
\item{\code{risk1}}{The absolute risk of getting an event belonging to cut G
among the exposed.}
\item{\code{risk0}}{The absolute risk of getting an event belonging to cut G
among the unexposed.}
\item{\code{RR}}{The risk ratio of the absolute risk among the exposed over
the absolute risk among the unexposed}
\item{\code{llr}}{The log-likelihood ratio comparing the observed and
expected number of exposed events belonging to cut G.}
\item{\code{p}}{The P-value that cut G is a cluster of events.}}

If \code{return_test_dist}  is \code{true} the function returns a list of two
data.frame.
\describe{
\item{\code{result_table}}{A data.frame including the results as described
above.}
\item{\code{test_dist}}{A data.frame with two columns: \code{iteration} the number
of the Monte Carlo iteration. Note that iteration
is the calculation based on the original data and
is, hence, not included in this data.fame. \code{max_llr}:
the highest observed log-likelihood ratio for each
Monte Carlo simulation}
}
}
\description{
Unconditional Bernoulli Tree-Based Scan Statistics for R
}
\examples{
TreeMineR(data = diagnoses,
          tree  = icd_10_se,
          p = 1/11,
          n_monte_carlo_sim = 99,
          random_seed = 1234) |>
  head()

}
\references{
Kulldorff et al. (2003)
A tree-based scan statistic for database disease surveillance.
Biometrics 56(2): 323-331. DOI: 10.1111/1541-0420.00039.
}
