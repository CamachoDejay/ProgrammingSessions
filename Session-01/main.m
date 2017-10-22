% This is the most basic of all programs. We wish to learn the basics of
% MATLAB's integrated development environment (IDE). We will learn basic
% ways in which we can make MATLAB report information back to the user.
% Namely, the 'disp' function and how to print information to a text file.
% We will also quickly introduce some string formatting. Note that this
% text is displayed in green by MATLAB's IDE. This tells you that this text
% is a 'comment', which means it is ignored by the computer when excecuting
% your instruction and its purpose is only to give information to the
% human reading/writting the program. To comment a line you must add a "%"
% symbol at the begining of the line.

% clear the command window. This removes any text currently present on the
% comand window.
clc

% display information to the user via the command window
disp('Hello world!')
% please note that 'Hello world!'is displayed in a purple color by the IDE.
% This highlights to the user the presence of a string (or character
% vector).
%% now we do it with a variable isntead
% during the example above we did not create any variables, now we will. We
% create a variable called str1 of class char: single character or string.
str1 = 'Hellow world 2!';
% display the information contained on the variable str1
disp(str1)

% create a variable called num1 of class double: numeric double precision
num1 = 5;
% display the information contained on the variable num1
disp(num1)

% create another string variable
str2 = '5';
% display the information contained on the variable str2
disp(str2)
% can you tell the difference between the way MATLAB displayed n and str2?
%% string formating 
% Note that num1 already exists, so this time we are rewriting the
% information contained in the variable num1
num1 = 7.34267;
% we use the function sprintf to write formatted data to a string variable
% named str3.
str3 = sprintf('The number is %0.2f', num1);
disp(str3)

%% print to file
% now istead of displaying the information through the Command Window we
% will do it by generating a text file and printing information into it.
% This will be very usefull later on when we want to save outputs generated
% by our software.

% 1st we create a new file called 'output.txt' and we make sure we have
% writing permission. Write "doc fopen" on the Command Window for more
% information. Notice that we keep a 'handle' to the file (think of it as
% an unique ID number) stored in the variable fileID. We will use that
% handle to then write info to that text file.
fileID = fopen('output.txt','wt');
% now we write formated data to the text file with identifier fileID.
fprintf (fileID, 'The number is %0.2f', num1);
% finally after we saved all the information we wanted we close the file.
% Closing a file is very important because if not MATLAB still has rights
% over it meaning that for example you can not move that file to another
% folder without a complain.
fclose(fileID);

% Now the task for this session is to use the information in this example to
% generate a main script that will:
% Save into a variable the name of the student,
% Save into a variable the age of the student,
% print to a text file called 'output.txt' the following output:
% Hello, my name is <student's name>
% And I'm <student's age> years old.
% Note that the output consists of two distinct lines. Also please pay
% attention to the formatting of the number, to say that you are 23.00
% years old makes little sense.