% this time we will concentrate on user input. We will introduce some of
% the most basic and important data calsses of MATLAN the numeric array and
% the cell array. We will handle the change of a string into a number, in
% relatio to user input. We will do a small intro to the assert function,
% which we can use to check that the program works as intended. Further we
% will have a quick look to basic control flow - for statement.

% get get rid of all information
% clear workspace
clear 
% close all figure
close all
% clear command window
clc

%% gather input from user exaple 1 using input
num_1 = input('please enter a number: ');
str_1 = input('please enter a string: ','s');

% check that no errors were done
assert(isnumeric(num_1), 'problens with numeric input')
assert(ischar(str_1), 'problens with string input')

% lets show that it works
disp(num_1)
disp(str_1)
%% gather input from user exaple 1 using input - assertion saving the day
num_1 = input('please enter a number: ','s');
str_1 = input('please enter a string: ','s');

% check that no erros were done
assert(isnumeric(num_1), 'problens with numeric input')
assert(ischar(str_1), 'problens with string input')

%% gather input from user exaple 2 using inputdlg a very nice prebuild UI
prompt = {'Enter your name: ','Enter your age: '};
dlg_title = 'User Input';
num_lines = 1;
defaultans = {'String','00'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

assert(~isempty(answer),'the user cancel input promt')
% now we change input string into number
num_1 = str2double(answer{2});
str_1 = answer{1};   
% check that no erros were done
assert(isnumeric(num_1), 'problens with numeric input')
assert(ischar(str_1), 'problens with string input')

fprintf('Name: %s; Age: %d \n',str_1,num_1)
%% gather a list of 3 names and ages - brute force
% we better create a place to store our informtion
% a list of number can be saved in a vector/matrix
age_list = zeros(3,1);
% a list of strings is betters handled by a cell array
name_list = cell(3,1);

prompt = {'Enter your name: ','Enter your age: '};
num_lines = [1, 50];
defaultans = {'String','00'};

% store first name
dlg_title = 'Please input name 1';
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
assert(~isempty(answer),'the user cancel input promt')
% now we change input into number
num_1 = str2double(answer{2});
str_1 = answer{1};   
% check that no erros were done
assert(isnumeric(num_1), 'problens with numeric input')
assert(ischar(str_1), 'problens with string input')
% all good so we continue
age_list(1) = num_1;
name_list{1} = str_1;

% store second name
dlg_title = 'Please input name 2';
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
assert(~isempty(answer),'the user cancel input promt')
% now we change input into number
num_1 = str2double(answer{2});
str_1 = answer{1};   
% check that no erros were done
assert(isnumeric(num_1), 'problens with numeric input')
assert(ischar(str_1), 'problens with string input')
% all good so we continue
age_list(2) = num_1;
name_list{2} = str_1;

% store third name
dlg_title = 'Please input name 3';
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
assert(~isempty(answer),'the user cancel input promt')
% now we change input into number
num_1 = str2double(answer{2});
str_1 = answer{1};   
% check that no erros were done
assert(isnumeric(num_1), 'problens with numeric input')
assert(ischar(str_1), 'problens with string input')
% all good so we continue
age_list(3) = num_1;
name_list{3} = str_1;

clc
fprintf('Name: %s; Age: %d \n',name_list{1},age_list(1))
fprintf('Name: %s; Age: %d \n',name_list{2},age_list(2))
fprintf('Name: %s; Age: %d \n',name_list{3},age_list(3))

%% gather a list of 3 names and ages - using a for loop - control flow
% we better create a place to store our informtion
n_inputs = 3;
% a list of number can be saved in a vector/matrix
age_list = zeros(n_inputs,1);
% a list of strings is betters handled by a cell array
name_list = cell(n_inputs,1);

% all things that do not change with iteration index 'i'
prompt = {'Enter your name: ','Enter your age: '};
num_lines = [1, 50];

for i = 1:n_inputs
    init_name = sprintf('Name-%d',i);
    defaultans = {init_name,'00'};
    % store first name
    dlg_title = sprintf('Please input name %d', i);
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
    assert(~isempty(answer),'the user cancel input promt')
    % now we change input into number
    num_1 = str2double(answer{2});
    str_1 = answer{1};   
    % check that no erros were done
    assert(isnumeric(num_1), 'problens with numeric input')
    assert(ischar(str_1), 'problens with string input')
    % all good so we continue
    age_list(i) = num_1;
    name_list{i} = str_1;
end

clc
disp('This is the user input');
fprintf('Name:\tAge:\n')
for i = 1:n_inputs
    fprintf('%s\t%d\n', name_list{i}, age_list(i));   
end

%% Asigment of the week
% Create a program that gathers a list of 10 Names, Sex, Ages. The program
% must print that information into a text file called output.txt where the
% first line indicates the name of the variables. Once all data has been
% printed you will add 2 extra lines that says: 
% 1) the mean age of the people in this data set is: <mean of all ages>
% 2) there are <number> women and <number> men in the data set.

% later on we will review other functions used for controllingnthe flow of
% a program. However, if you feel adventurous you can try to add some
% special cases to this program. To get some inspiration type 'doc control
% flow' on the command window. For example:

% 1) make the syntax correct if there are no women or men it is better to
% say so in text intead of printing a 0.

% 2) what if the user decides to input less than 10 names, can you do
% something so the program does not break but prints the output
% nevertheless after giving a warning to the user that indicates he did not
% place the 10 values as expected. Check 'doc control flow' and 'doc error
% handling' for inspiration.

% 3) Finally if you an do the above then you can also probably change the
% program in such a way that the number of people in the data set is not
% decided before hand. You just keep asking for data until the user decides
% it is enough. For this you will need concatenation
