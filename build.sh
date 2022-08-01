#! /bin/bash

# 打包显示的日志
git tag v1.0
git commit --allow-empty -m "v1.0 Build"
git push origin $branch