@echo off
chcp 65001 >nul
cd /d D:\NormolStudy\Notes

echo ============================
echo   正在清空 GitHub 远程仓库
echo   本地文件不会删除
echo ============================

git rm -r --cached .
git commit -m "清空远程仓库，重新按目录整理"
git push

echo.
echo ============================
echo   远程仓库已清空
echo   现在可以重新推送整理好的笔记
echo ============================
pause