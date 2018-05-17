echo ""
echo "-----------------------------"
echo "Compliation"
echo "-----------------------------"
echo ""
nvcc ./src/main.cu -o ./main
if [ $? -eq 0 ]; then #look if there is no compiling error if $? == 0 no error
echo ""
echo "-----------------------------"
echo "Program starting"
echo "-----------------------------"
echo ""
./main
echo ""
echo "-----------------------------"
echo "Program is done"
echo "-----------------------------"
echo ""
fi
