CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'
#rm -rf forcefully and recursively remove files and directoires
rm -rf student-submission
rm -rf grading-area
#make a new directory name grading-area
mkdir grading-area

# clone the first command agurment respoatory into student submission
git clone $1 student-submission
# let the user know we're done cloning
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
#MUST HAVE SPACE IN THE IF CONDITION OR ELSE IT WONT WORK
#if it finds the specific file
if [[ -f student-submission/ListExamples.java ]]
then
    echo "Submimssion files found."
else
    echo "ListExamples.java file missing."
    exit
fi

# copy the file in student-submission and the TestListExamples and paste it into grading-area folder
cp student-submission/ListExamples.java TestListExamples.java grading-area
# recursivly copy files and directory inside the lib file and paste it into the grading-area
cp -r lib grading-area
# change directory into grading-area
cd grading-area
# compile the Junit test
javac -cp $CPATH *.java
# check if the compilation was successful
if [[ $? -eq 0 ]]
then 
    echo "Compliation successful"
else
    echo "Compliation not successful"
    exit
fi

# run the Junit test
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > output

NUMOFTESTRUN=$(grep -Eo "Tests run: [0-9]+" output | grep -Eo "[0-9]+")
NUMFAIL=$(grep -Eo "Failures: [0-9]+" output | grep -Eo "[0-9]+")

let NUMSUCCESS=$NUMOFTESTRUN-$NUMFAIL

OK=$(grep OK output)
if [[ $OK = "" ]]
then
    echo "Tests Passed: ${NUMSUCCESS}/${NUMOFTESTRUN}"
    echo "Tests Failed: ${NUMFAIL}/${NUMOFTESTRUN}"
else
    echo 100 points!
fi
