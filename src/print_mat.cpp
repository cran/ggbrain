#include "ggbrain.h"

void print_mat(arma::mat my_matrix) {
  
  unsigned int cols = my_matrix.n_cols;
  unsigned int rows = my_matrix.n_rows;
  
  Rcout << "--------\n";
  for(unsigned int rX = 0; rX < rows; rX++) {
    Rcout << " " << rX << ": ";
    for(unsigned int cX = 0; cX < cols; cX++) {
      Rcout << my_matrix(rX, cX) << " ";
    }
    Rcout << "\n";
  }
  Rcout << "--------\n";
}
