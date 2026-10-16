@echo off
chcp 65001 >nul
cd /d D:\NormolStudy\Notes

echo ============================
echo   正在推送笔记到 GitHub
echo ============================

git add .
git commit -m "更新笔记 %date% %time%"
git push

echo.
echo ============================
echo   推送完成！
echo ============================
pause