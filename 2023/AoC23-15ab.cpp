#include <iostream>
#include <string>
#include <vector>
#include <fstream>

class Lens {
  public:
    std::string label;
    int focal_length;

  Lens(std::string label, int focal_length) {
    this->label = label;
    this->focal_length = focal_length;
  }
};

std::vector<std::string> get_lines(std::string input) {
  std::vector<std::string> lines = {};

  if (input[input.size()-1] != ',') input.push_back(',');
  size_t pos = 0;
  while ((pos = input.find(',')) != std::string::npos) {
    lines.push_back(input.substr(0, pos));
    input.erase(0, pos + 1);
  }
  
  return lines;
}

int hash(std::string s) {
  int out = 0;
  for (char c : s) {
    out = ((out + c) * 17) % 256;
  }
  
  return out;
}

int main() {
  std::string temp;
  std::ifstream input("input.txt");
  input >> temp;
  input.close();

  const std::vector<std::string> lines = get_lines(temp);
  
  int total1 = 0;
  for (std::string s : lines) {
    total1 += hash(s);
  }
  std::cout << "Part 1 answer: " << total1 << "\n";

  std::vector<std::vector<Lens>> boxes(256, std::vector<Lens>{});
  
  for (std::string line : lines) {
    size_t pos = 0;
    if ((pos = line.find('=')) != std::string::npos) {
      const std::string label = line.substr(0, pos);
      const int box = hash(label);
      const int focal_length = std::stoi(line.substr(pos + 1, 1));
      
      bool found = false;
      for (int i = 0; i < boxes[box].size(); i++) {
        if (boxes[box][i].label == label) {
          boxes[box][i].focal_length = focal_length;
          found = true;
          break;
        }
      }
      
      if (!found) {
        boxes[box].push_back(Lens(label, focal_length));
      }
    } else {
      const std::string label = line.substr(0, line.size()-1);
      const int box = hash(label);
      
      for (int i = 0; i < boxes[box].size(); i++) {
        if (boxes[box][i].label == label) {
          boxes[box].erase(boxes[box].begin() + i);
          break;
        }
      }
    }
  }

  int total2 = 0;
  for (int i = 0; i < boxes.size(); i++) {
    for (int j = 0; j < boxes[i].size(); j++) {
      total2 += (i + 1) * (j + 1) * boxes[i][j].focal_length;
    }
  }
  std::cout << "Part 2 answer: " << total2 << "\n";
}
