# Copy over configs
mkdir -p ~/.config
cp -R "$OMADORA_PATH/config/." ~/.config/

# Use default bashrc
cp "$OMADORA_PATH/default/bashrc" ~/.bashrc
