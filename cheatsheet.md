Удалить полностью строку: `shift + v + Backspace` или `shift + c`
Удалить целое словов с шагом назад: ctrl + w
Копировать: ctrl + c

Смотреть git diff :Gvdiffsplit
Смотреть git log и перейти в полную вкладку :G log затем shift + o

Выделить слово в котором находится курсор в данный момент "viw"
Перейти на новую строку и войти в режим INSERT: "o"

Поставить несколько курсоров на разных строках и ввести текст сразу на все строки: Ctrl + v, Shift + i, ввести текст, выйти из INSERT режима (jk)

Посмотреть, на сколько процентов прочитан документ: Ctrl + g в normal mode

## Окна
Разделить окно на два вертикально: Ctrl + w + v
Закрыть все окна и остаться только на активном: Ctrl + w + o
Разделить окно на два и перейти на следующее: Ctrl + w + w

## vim-commentary
Закомментировать с линии A по линию B: `:<Начальная линия>,<конечная линия>Commentary` (:1,6Commentary)

Перейти на конец строки и войти в режим INSERT: Shift + a
Перейти на начало строки и войти в режим INSERT: Shift + i

## Replace
- Заменить совпадение на текущей строке:
```
:s/old/new
```
- Заменить все совпадения в файле:
```
:%s/old/new/g
```
- Заменить все совпадения на текущей строке:
```
:s/old/new/g
```
- Заменить совпадения на всех строках с подтверждением:
```
:%s/old/new/gc
```
- Заменить совпадения с текущей линии на n количество раз вниз:
```
:,.,+ns/old/new
```
Пример:
```
:,.,+3s/old/new
```

## Замена текста рекурсивно
`grep -rl "old_word" /path/to/folder | xargs sed -i "s/old_word/new_word/g"`
