let grade = 'A';

switch (grade) {    
    case 'A':
        console.log('You got an A! You did great!');
        break;
    case 'B':
        console.log('You got a B! You did good!');
        break;
    case 'C':
        console.log('You got a C! You bearly passed!');
        break;
    case 'D':
        console.log('You got a D! You need to study more!');
        break;
    case 'F':
        console.log('You got an F! You failed!');
        break;
    default:
        console.log('Invalid grade.Try again with a valid grade.');
        break;
}