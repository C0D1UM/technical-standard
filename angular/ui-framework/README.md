# UI Framework Guideline

## CSS Framework

| ![Bootstrap](https://camo.githubusercontent.com/bec2c92468d081617cb3145a8f3d8103e268bca400f6169c3a68dc66e05c971e/68747470733a2f2f76352e676574626f6f7473747261702e636f6d2f646f63732f352e302f6173736574732f6272616e642f626f6f7473747261702d6c6f676f2d736861646f772e706e67) | ![Tailwind CSS](https://symbols.getvecta.com/stencil_97/3_tailwind-css-icon.43c02f69bf.png) |
| :---: | :---: |
| _Bootstrap_ | _Tailwind CSS_ |
| [https://getbootstrap.com](https://getbootstrap.com) | [https://tailwindcss.com](https://tailwindcss.com) |

### When to use?

| Bootstrap | Tailwind CSS |
| :-------: | :------: |
| Lots of interactive | Less or zero interactive <sup>[1]</sup> |
| Less UI customization | Lots of UI customization |
| Simple, flexible mock-up | Strict, complicated mock-up |

<small><sup>[1]</sup> Because currently, _Tailwind CSS_ does not have much integration with our front-end framework, Angular. Developing interactive form with _Tailwind CSS_ would generate a lot of work to do.</small>

### Still don't know what to use?

_Bootstrap_ should be your choice.

## UI Framework

| ![NG Bootstrap](https://ng-bootstrap.github.io/img/logo-stack.png) | ![PrimeNG](https://i0.wp.com/www.primefaces.org/wp-content/uploads/2016/10/primeng.png?resize=450%2C450&ssl=1) |
| :---: | :---: |
| _NG Bootstrap_ <sup>[2]</sup> | _PrimeNG_ |
| [https://ng-bootstrap.github.io](https://ng-bootstrap.github.io) | [https://www.primefaces.org/primeng](https://www.primefaces.org/primeng) |

<small><sup>[2]</sup> Please note that its _npm_ package name is `@ng-bootstrap/ng-bootstrap`, not [`ngx-bootstrap`](https://github.com/valor-software/ngx-bootstrap) which is another framework.</small>

### What to use?

It depends on which framework your code base was using. The important rule is **you need to use only one of them**, not both. There are some difference for your consideration between these two such as:

- _PrimeNG_ has more components than _NG Bootstrap_
- _NG Bootstrap_ has a better layout system from _Bootstrap_
- _NG Bootstrap_ has slightly more stars and download count than _PrimeNG_ <sup>[3]</sup>
- _PrimeNG_ components are more customizable

<small><sup>[3]</sup> Reference: [npm trends](https://www.npmtrends.com/primeng-vs-@ng-bootstrap/ng-bootstrap)</small>
