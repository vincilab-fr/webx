# Cookbook

Practical patterns for common WebX tasks.

## Add Two Numbers

```webx
function int add(int a, int b) {
    return a + b;
}
```

## Increment Counter

```webx
function int main() {
    int i = 1;
    i++;
    i++;
    return i;
}
```

## Conditional Return

```webx
function int main() {
    int x = 0;
    if (x == 0) {
        return 0;
    }
    return 1;
}
```

## While Loop

```webx
function int main() {
    int x = 0;
    while (x < 3) {
        x++;
    }
    return x;
}
```

## Class Main Entrypoint

```webx
class Main {
    public void main() {
        println("hello");
        return;
    }
}
```
