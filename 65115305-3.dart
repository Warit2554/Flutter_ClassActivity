void main() {
  int n = 17;
  if (n <= 0) {
    print("Please enter a valid poisitive integer");
  }
  int sum = 0;
  for (int i = 0; i < n; i++) {
    if (i % 3 == 0 || i % 5 == 0) {
      sum = sum + i;
    }
  }
  print("The sum of all multiple of 3 and 5 below $n is $sum");
}
