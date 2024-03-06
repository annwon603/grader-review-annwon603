

CPATH='.;lib\hamcrest-core-1.3.jar;lib\junit-4.13.2.jar'
RPATH='.;lib\hamcrest-core-1.3.jar;lib\junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples'
#rm -rf forcefully and recursively remove files and directoires
rm -rf student-submission
rm -rf grading-area
#make a new directory name grading-area
mkdir grading-area
#clone the first command agurment respoatory into student submission
git clone $1 student-submission
#prints out finish cloning
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
#MUST HAVE SPACE IN THE IF CONDITION OR ELSE IT WONT WORK
#if it finds the specific file
if [[ -f student-submission/ListExamples.java ]]
then 
#prints out file found 
    echo "file found"
else
#otherwise print not found and exit the program
    echo "file not found"
    exit
fi

#copy the file in student-submission and the TestListExamples and paste it into grading-area folder
cp student-submission/ListExamples.java TestListExamples.java grading-area
#recursivly copy files and directory inside the lib file and paste it into the grading-area
cp -r lib grading-area
#change directory into grading-area
cd grading-area
#compile the Junit test
javac -cp $CPATH *.java
#if the exit status is 0 then print compliation is successful
if [[ $? -eq 0 ]]
then 
    echo "Compliation successful"
else
    echo "Compliation not successful"
    echo "There must be a syntax error"
    
    exit
fi

#run the Junit test
java -cp $RPATH > output
NUMOFTESTRUN=$(grep -Eo "Tests run: [0-9]+" output | grep -Eo "[0-9]+")

NUMFAIL=$(grep -Eo "Failures: [0-9]+" output | grep -Eo "[0-9]+")

let NUMSUCCESS=$NUMOFTESTRUN-$NUMFAIL

OK=$(grep OK output)
if [[ $OK = "" ]]
then
    # echo $NUMOFTESTRUN
    # echo $NUMFAIL
    echo "Test Pass: ${NUMSUCCESS}/${NUMOFTESTRUN}"
    echo "Test Fail: ${NUMFAIL}/${NUMOFTESTRUN}"

else
    echo 100 points!
fi

