[![.github/workflows/ci.yml](https://github.com/mshafer1/chrome_headless/actions/workflows/ci.yml/badge.svg)](https://github.com/mshafer1/chrome_headless/actions/workflows/ci.yml) [![GitHub](https://img.shields.io/github/license/mshafer1/chrome_headless)](https://github.com/mshafer1/chrome_headless/blob/main/LICENSE)  [![Static Badge](https://img.shields.io/badge/Dockerfile-GitHub-blue)
](https://github.com/mshafer1/chrome_headless/blob/main/Dockerfile)

# Headless Chrome

A simple container built with chrome and matching chrome-driver pre-installed.

## Examples

```bash
docker run -v "$PWD/chrome:/tmp/chrome"  -it --rm mshafer1/headless_chrome google-chrome --headless --disable-gpu --no-sandbox --screenshot http
s://www.chromestatus.com/
```

`#./chrome/shreenshot.png`

![output image](https://i.imgur.com/fy4cRz0.png)