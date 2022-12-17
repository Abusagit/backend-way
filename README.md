# 🤖🤖🤖 My backend-way 🤖🤖🤖

## Repository where I learn django, python and follow these roadmaps: 
### 1) [Backend roadmap](https://roadmap.sh/backend)
### 2) [Python roadmap](https://roadmap.sh/python)

***

<!-- Zero width character is used to put extra blank lines before and after code -->
<h3>

```python3
​
from typing import Tuple
import json
from dataclasses import asdict, dataclass


@dataclass
class FutureStack:
    languages: Tuple[str, ...] = ("Python", "HTML5", "CSS")
    databases: Tuple[str, ...] = ("PostgreSQL")
    misc     : Tuple[str, ...] = ("Docker")
    ongoing  : Tuple[str, ...] = ("Django", "DRF")

    def jsonify(self) -> str:
        return json.dumps(asdict(self), indent=4)


stack = FutureStack()
print(stack.jsonify())
​
```
</h3>

***

## Repo structure :
> notes-way - to summarize theoretical material, such as what is threads and concurrency or n + 1 problem problem

> python-way - to study algorithms and data structures, as well as tasks and interesting features of syntax

> django-way - to study Django, DRF

> frontend-way - to study on beginning level html/css, js and other frontend  frameworks

> sql-way - to study SQL syntax/dialects and various DBMS (Database Management System)

> Certificates - for certificates from various courses / hackathons and others

***
## What I have already learned and what I am studying:
> ### Python
#### Courses
| URL | Title | Status |
| :---: | --- | :---: |
| [Stepic](https://stepik.org/course/67/promo) |Программирование на Python| **Completed** |
| [Stepic](https://stepik.org/course/512/promo) | Python: основы и применение | **Completed** |
| [Coursera](https://www.coursera.org/learn/mathematics-and-python)|Математика и Python для анализа данных| **Completed** |
| [Kaggle](https://www.kaggle.com/learn/python) | Python | **Completed** |
| [Kaggle](https://www.kaggle.com/learn/pandas) | Pandas | **Completed** |
| [Kaggle](https://www.kaggle.com/learn/data-visualization) | Data Visualization | **Completed** |
| [Kaggle](https://www.kaggle.com/learn/data-cleaning) | Data Cleaning | **Completed** |

#### Books
| Title | Author | Status |
| --- | :---: | :---: |
| Изучаем Python. Том 1 | Лутц Марк| **Completed** |
| Изучаем Python. Том 2 | Лутц Марк| **Completed** |
| [The Ultimate FastAPI Tutorial](https://christophergs.com/tutorials/ultimate-fastapi-tutorial-pt-1-hello-world/) | Christopher Samiullah | **Completed** |


> ### Algorithms & Data Structures
#### Courses
| URL | Title | Status |
| :---: | --- | :---: |
| [Stepic](https://stepik.org/course/217/promo) |Алгоритмы: теория и практика. Методы| To Do |
| [Stepic](https://stepik.org/course/1547/promo) | Алгоритмы: теория и практика. Структуры данных | To Do |

#### Books
| Title | Author | Status |
| --- | :---: | :---: |
| [DS & Algorithms (Online book)](https://www.programiz.com/dsa) | Programiz | **Completed** |
| Грокаем алгоритмы | Бхаргава Адитья | **Completed** |
| Алгоритмы. Руководство по разработке | Стивен Скиена | To Do |

> ### SQL

#### Books
| Title | Author | Status |
| --- | :---: | :---: |
| PostgreSQL. Основы языка SQL | Е.П. Моргунов | **Completed**  |

> ### Other

#### Books (Coming soon)
| Title | Author | Status |
| --- | :---: | :---: |
| [html & css is hard](https://www.internetingishard.com/html-and-css/)| Oliver James | **Completed** |
