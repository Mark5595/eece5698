#include <iostream>

int main()
{
  int a[4] = {0, 1, 2, 3};
  int b[5][5] = {
    {0, 1, 2, 3, 4}, 
    {10, 11, 12, 13, 14}, 
    {20, 21, 22, 23, 23},
    {30, 31, 32, 33, 34}};

  std::cout << "a at 1: " << a[1] << "\n";

  for(int kristin = 0; kristin < 4; ++kristin) {
    std::cout << "a at " << kristin << " is: " << a[kristin] << "\n";
  }
  
  for(int row = 0; row < 4; ++row) {
    for(int col = 0; col < 4; ++col) {
      std::cout << "b at " << row<< ", " << col <<  "is: " << b[row][col] << "\n";
    }
  }


  return 0;
}
