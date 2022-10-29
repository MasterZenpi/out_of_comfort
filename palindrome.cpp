#include <iostream>
#include <string>
#include <algorithm>
using namespace std;

bool isPalindrome(int);

int main()
{
    int value = 71;
   cout << isPalindrome(value);

}

bool isPalindrome(int x){

string temp = to_string(x);
reverse(temp.begin(), temp.end());

string reverse = "";

if(x < 0) return false ;        // if negetive return false because it will always be false

for (auto& ele : temp){
    reverse += ele;
}
cout << reverse << "reverse\n";
cout << temp << " temp\n";


}//end isPalindrome