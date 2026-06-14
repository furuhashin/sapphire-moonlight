# Heading Level 1

## Heading Level 2

### Heading Level 3

#### Heading Level 4

---

## Inline Formatting

This is **bold text** and this is *italic text* and this is ***bold italic text***.

This is ~~strikethrough~~ text.

This is `inline code` in a sentence.

## Links

[Regular link](https://example.com)

[Link with title](https://example.com "Example Site")

[Reference link][ref1]

[ref1]: https://example.com "Reference Link"

Auto-link: https://example.com/auto

## Lists

- Unordered item 1
- Unordered item 2
  - Nested item 2.1
  - Nested item 2.2
- Unordered item 3

1. Ordered item 1
2. Ordered item 2
3. Ordered item 3

- [x] Task completed
- [ ] Task pending

## Blockquote

> This is a blockquote.
>
> It can span **multiple** lines with *formatting*.
>
> > Nested blockquote.

## Table

| Column 1 | Column 2 | Column 3 |
|-----------|----------|----------|
| Cell 1    | Cell 2   | Cell 3   |
| Cell 4    | Cell 5   | Cell 6   |
| `code`    | **bold** | *italic* |

## Code Blocks

Fenced code block with language:

```javascript
function hello(name) {
  return `Hello, ${name}!`;
}
```

```python
def hello(name: str) -> str:
    return f"Hello, {name}!"
```

Fenced code block without language:

```
Plain text code block
No syntax highlighting
```

Indented code block:

    const x = 42;
    console.log(x);

## Images

![Alt text for image](image.png)

![Alt text with title](image.png "Image Title")

## HTML in Markdown

<details>
<summary>Click to expand</summary>

This is hidden content with **markdown** support.

</details>

<kbd>Ctrl</kbd> + <kbd>S</kbd>

<u>Underlined text using HTML</u>

## Diff Block

```diff
+ Added line (inserted)
- Removed line (deleted)
! Changed line
# Comment in diff
```

## Math (if supported)

Inline math: $E = mc^2$

Block math:

$$
\sum_{i=1}^{n} x_i = x_1 + x_2 + \cdots + x_n
$$

## Footnote

Here is a sentence with a footnote[^1].

[^1]: This is the footnote content.

## Horizontal Rules

---

***

___
