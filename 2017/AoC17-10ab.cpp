#include <iostream>
#include <vector>
#include <sstream>
#include <iomanip>

std::vector<std::string> split(std::string, char);
template <typename T> void swap(std::vector<T>&, int, int);
int part1(std::string);
std::string knot_hash(std::string);

int main() {
  std::string input;
  std::getline(std::cin, input);

  std::cout << "Part 1 answer: " << part1(input) << '\n';
  std::cout << "Part 2 answer: " << knot_hash(input) << '\n';
}

int part1(std::string input) {
  std::vector<int> dirs{};
  for (std::string s : split(input, ',')) dirs.push_back(std::stoi(s));

  const int len = 256;

  std::vector<int> nums(len);
  for (int i = 0; i < len; i++) nums[i] = i;

  int skip = 0;
  int i = 0;
  for (int d : dirs) {
    for (int a = 0; a < d/2; a++) {
      int w = (i + a) & len-1;
      int x = (i + d - a - 1) & len-1;

      swap(nums, w, x);
    }

    i = i + d + skip++;
  }

  return nums[0] * nums[1];
}

std::string knot_hash(std::string input) {
  std::vector<int> dirs{};
  for (int n : input) dirs.push_back(n);
  for (int n : { 17, 31, 73, 47, 23 }) dirs.push_back(n);

  const int len = 256;

  std::vector<int> nums(len);
  for (int i = 0; i < len; i++) nums[i] = i;

  int skip = 0;
  int i = 0;
  for (int loop = 1; loop <= 64; loop++) {
    for (int d : dirs) {
      for (int a = 0; a < d/2; a++) {
        int w = (i + a) & len-1;
        int x = (i + d - a - 1) & len-1;

        swap(nums, w, x);
      }

      i = i + d + skip++;
    }
  }

  std::stringstream ss;
  for (int j = 0; j < len; j += 16) {
    int temp = 0;
    for (int k = j; k < j+16; k++) temp ^= nums[k];

    if (temp < 0x10) ss << '0';
    ss << std::hex << temp;
  }

  return ss.str();
}

std::vector<std::string> split(std::string s, char delimiter) {
  if (s.back() != delimiter) s.push_back(delimiter);

  std::vector<std::string> out{};
  size_t pos = 0;
  while ((pos = s.find(delimiter)) != std::string::npos) {
    out.push_back(s.substr(0, pos));
    s.erase(0, pos+1);
  }

  return out;
}

template <typename T>
void swap(std::vector<T>& v, int a, int b) {
  T temp = v[a];
  v[a] = v[b];
  v[b] = temp;
}