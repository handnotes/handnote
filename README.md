# Handnote

[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/handnotes/handnote/macos.yml?style=for-the-badge)](https://github.com/handnotes/handnote/actions/workflows/macos.yml)
[![Codecov](https://img.shields.io/codecov/c/github/handnotes/handnote?style=for-the-badge&token=0GPY49D81Q)](https://app.codecov.io/gh/handnotes/handnote)

Flutter client for handnote.


<img width="240" src="https://raw.githubusercontent.com/handnotes/handnote/main/.github/homepage.png"> <img width="240" src="https://raw.githubusercontent.com/handnotes/handnote/main/.github/assets.png"> <img width="240" src="https://raw.githubusercontent.com/handnotes/handnote/main/.github/add-bill.png"> <img width="240" src="https://raw.githubusercontent.com/handnotes/handnote/main/.github/category.png">

## Getting Started

```bash
flutter run
flutter test -d macos integration_test
```

## TODO

- [ ] Release cross-platform
  build (https://github.com/softprops/action-gh-release/issues/57#issuecomment-653802166)
- [ ] Manually trigger release
- [ ] Remove redundant semantic widget on TextField
  widget [![flutter/flutter/26336](https://img.shields.io/github/issues/detail/state/flutter/flutter/26336)](https://github.com/flutter/flutter/issues/26336)
- [ ] Cannot re-open dialog with long press in integration
  test [![flutter/flutter/98804](https://img.shields.io/github/issues/detail/state/flutter/flutter/98804)](https://github.com/flutter/flutter/issues/98804)
- [ ] Expandable sticky list for asset list and category management
  screen (https://stackoverflow.com/a/48618537/7736393 https://juejin.cn/post/6887396184015208461)

## Development

### Build

```bash
flutter build apk --split-per-abi --no-tree-shake-icons
```

### Add icon from Iconfont

1. Copy `iconfont.ttf` to `asset/fonts`
2. Replace `.icon-(.*):before[\s\S]+?"\\(.*?)";\n}\n`
   with `'$1': IconData(0x$2, fontFamily: 'HandnoteIcon'),` in `iconfont.css` and copy the result
   to `lib/constants/icons.dart`

## Thanks

- Icon: [网商银行无线图标库](https://www.iconfont.cn/collections/detail?cid=1260)
- Icon: [银行LOGO合集](https://www.iconfont.cn/collections/detail?cid=23316)
- Icon: [Rookie 3.0官方图标库](https://www.iconfont.cn/collections/detailcid=7077)
