---
title: Trie
math: true
type: docs
weight: 4
---

Basic Trie implementations that support add, check, delete
## Trie (MSB to LSB)
{{% details title="Click" closed="true" %}}
```c++
struct Node {
    struct Node *left, *right;
    i64 count;

    Node(): left(nullptr), right(nullptr), count(0) {}
    Node(int x): left(nullptr), right(nullptr), count(x) {}
};

class Trie {
    // creates a trie on b bits (pass b here)
private: 
    i64 b;
    struct Node* root;
public:
    Trie(i64 b): b(b), root(new struct Node()) {}

    // add the number val to the trie
    void add_node(i64 val) {
        struct Node* ptr = root;
        for (int i = b - 1; i >= 0; i--) {
            if ((val >> i) & 1) {
                if (ptr != nullptr && ptr->right == nullptr) {
                    ptr->right = new struct Node();
                }
                ptr = ptr->right;
                ptr->count++;
            } else {
                if (ptr != nullptr && ptr->left == nullptr) {
                    ptr->left = new struct Node();
                }
                ptr = ptr->left;
                ptr->count++;
            }
        }
    }

    // check if the number val exists
    bool exists_node(i64 val) {
        struct Node* ptr = root;
        for (int i = b - 1; i >= 0; i--) {
            if ((val >> i) & 1) {
                ptr = ptr->right;
            } else {
                ptr = ptr->left;
            }
            
            if (ptr == nullptr || ptr->count == 0) return false;
        }
        return true;
    }

    // delete the number from the trie
    bool delete_node(i64 val) {
        struct Node* ptr = root;
        for (int i = b - 1; i >= 0; i--) {
            if ((val >> i) & 1) {
                ptr = ptr->right;
            } else {
                ptr = ptr->left;
            }
            if (ptr == nullptr) return false;
            ptr->count--;
        }
        return true;
    }
};
```
{{% /details %}}

## Trie (LSB to MSB)
{{% details title="Click" closed="true" %}}
```c++
struct Node {
    struct Node *left, *right;
    i64 count;

    Node(): left(nullptr), right(nullptr), count(0) {}
    Node(int x): left(nullptr), right(nullptr), count(x) {}
};

class Trie {
    // creates a trie on b bits (pass b here)
private: 
    i64 b;
    struct Node* root;
public:
    Trie(i64 b): b(b), root(new struct Node()) {}

    // add the number val to the trie
    void add_node(i64 val) {
        struct Node* ptr = root;
        for (int i = 0; i < b; i++) {
            if ((val >> i) & 1) {
                if (ptr != nullptr && ptr->right == nullptr) {
                    ptr->right = new struct Node();
                }
                ptr = ptr->right;
                ptr->count++;
            } else {
                if (ptr != nullptr && ptr->left == nullptr) {
                    ptr->left = new struct Node();
                }
                ptr = ptr->left;
                ptr->count++;
            }
        }
    }

    // check if the number val exists
    bool exists_node(i64 val) {
        struct Node* ptr = root;
        for (int i = 0; i < b; i++) {
            if ((val >> i) & 1) {
                ptr = ptr->right;
            } else {
                ptr = ptr->left;
            }
            
            if (ptr == nullptr || ptr->count == 0) return false;
        }
        return true;
    }

    // delete the number from the trie
    bool delete_node(i64 val) {
        struct Node* ptr = root;
        for (int i = 0; i < b; i++) {
            if ((val >> i) & 1) {
                ptr = ptr->right;
            } else {
                ptr = ptr->left;
            }
            if (ptr == nullptr) return false;
            ptr->count--;
        }
        return true;
    }
};
```
{{% /details %}}

## Trie (Flag Switch)
{{% details title="Click" closed="true" %}}
```c++
struct Node {
    Node *left, *right;
    i64 count;

    Node(): left(nullptr), right(nullptr), count(0) {}
    Node(int x): left(nullptr), right(nullptr), count(x) {}
};

class Trie {
private: 
    i64 b;
    bool msb_first; // true: MSB to LSB, false: LSB to MSB
    Node* root;

    int get_bit(i64 val, int i) const {
        if (msb_first) {
            return (val >> (b - 1 - i)) & 1;
        } else {
            return (val >> i) & 1;
        }
    }

public:
    Trie(i64 b, bool msb_first = true): b(b), msb_first(msb_first), root(new Node()) {}

    // add the number val to the trie
    void add_node(i64 val) {
        Node* ptr = root;
        for (int i = 0; i < b; i++) {
            int bit = get_bit(val, i);
            if (bit) {
                if (ptr->right == nullptr) {
                    ptr->right = new Node();
                }
                ptr = ptr->right;
            } else {
                if (ptr->left == nullptr) {
                    ptr->left = new Node();
                }
                ptr = ptr->left;
            }
            ptr->count++;
        }
    }

    // check if the number val exists
    bool exists_node(i64 val) {
        Node* ptr = root;
        for (int i = 0; i < b; i++) {
            int bit = get_bit(val, i);
            if (bit) {
                if (ptr->right == nullptr) return false;
                ptr = ptr->right;
            } else {
                if (ptr->left == nullptr) return false;
                ptr = ptr->left;
            }
            if (ptr->count == 0) return false;
        }
        return true;
    }

    // delete the number from the trie
    bool delete_node(i64 val) {
        Node* ptr = root;
        for (int i = 0; i < b; i++) {
            int bit = get_bit(val, i);
            if (bit) {
                if (ptr->right == nullptr) return false;
                ptr = ptr->right;
            } else {
                if (ptr->left == nullptr) return false;
                ptr = ptr->left;
            }
            if (ptr->count <= 0) return false;
            ptr->count--;
        }
        return true;
    }
};
```
{{% /details %}}

## Trie (Smart Pointers)
{{% details title="Click" closed="true" %}}
```c++
struct Node {
    std::unique_ptr<Node> left, right;
    i64 count;

    Node(): left(nullptr), right(nullptr), count(0) {}
    Node(int x): left(nullptr), right(nullptr), count(x) {}
};

class Trie {
    // creates a trie on b bits (pass b here)
private: 
    i64 b;
    std::unique_ptr<Node> root;
public:
    Trie(i64 b): b(b), root(std::make_unique<Node>()) {}

    // add the number val to the trie
    void add_node(i64 val) {
        Node* ptr = root.get();
        for (int i = 0; i < b; i++) {
            if ((val >> i) & 1) {
                if (ptr->right == nullptr) {
                    ptr->right = std::make_unique<Node>();
                }
                ptr = ptr->right.get();
                ptr->count++;
            } else {
                if (ptr->left == nullptr) {
                    ptr->left = std::make_unique<Node>();
                }
                ptr = ptr->left.get();
                ptr->count++;
            }
        }
    }

    // check if the number val exists
    bool exists_node(i64 val) {
        Node* ptr = root.get();
        for (int i = 0; i < b; i++) {
            if ((val >> i) & 1) {
                if (ptr->right == nullptr) return false;
                ptr = ptr->right.get();
            } else {
                if (ptr->left == nullptr) return false;
                ptr = ptr->left.get();
            }
            if (ptr->count == 0) return false;
        }
        return true;
    }

    // delete the number from the trie
    bool delete_node(i64 val) {
        Node* ptr = root.get();
        for (int i = 0; i < b; i++) {
            if ((val >> i) & 1) {
                if (ptr->right == nullptr) return false;
                ptr = ptr->right.get();
            } else {
                if (ptr->left == nullptr) return false;
                ptr = ptr->left.get();
            }
            if (ptr->count <= 0) return false;
            ptr->count--;
        }
        return true;
    }
};
```
{{% /details %}}

We can add more individual functionalities as needed

## Maximum OR (for a number)
Disclaimer: Computing maximum OR (LSB to MSB) works, but not the other way around.

{{% details title="Click" closed="true" %}}
```c++
i64 find_max_or(i64 val) {
    Node* ptr = root.get();
    i64 result = 0;
    for (int i = 0; i < b; i++) {
        if ((val >> i) & 1) {
            if (ptr->left != nullptr && ptr->left->count > 0) {
                ptr = ptr->left.get();
            } else if (ptr->right != nullptr && ptr->right->count > 0) {
                ptr = ptr->right.get();
                result |= (1LL << i);
            } else {
                return -1;
            }
        } else {
            if (ptr->right != nullptr && ptr->right->count > 0) {
                ptr = ptr->right.get();
                result |= (1LL << i);
            } else if (ptr->left != nullptr && ptr->left->count > 0) {
                ptr = ptr->left.get();
            } else {
                return -1;
            }
        }
    }
    return result;
}
```
{{% /details %}}

## Minimum OR (for a number)

{{% details title="Click" closed="true" %}}
```c++
```
{{% /details %}}

## Maximum XOR (for a number)

{{% details title="Click" closed="true" %}}
```c++
```
{{% /details %}}

## Minimum XOR (for a number)

{{% details title="Click" closed="true" %}}
```c++
```
{{% /details %}}


