1.
```
sudo apt update
sudo apt install gcc make g++ xclip curl nodejs
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
npm install -g yarn
```

2. Vim-plug
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

3.
```
:PlugInstall
```

4.
```
cd ~/.local/share/nvim/plugged/coc.nvim
yarn install
```
