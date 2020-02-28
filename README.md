# U.S-Electoral-System-Database-Design
A database designed to identify the rogue voters in the U.S 

Problem statement:
The US presidential elections takes place every 4 years. These elections happen over a span of one year. Primary elections and caucuses are held by each state to select delegates who form a part of an electoral college that in turn decide on which candidate wins the election. With emerging technology and increase in population, there is a need to track the process and manage the enormous amount of data that is created for advertising, campaigning, funding, and also recording voters data.

The scope of this database system is to manage information regarding the candidates, the voters, and the electoral college.

This system will contain 4 models, namely,
1. Voter information including a background check
This would check for people who can vote and cannot vote for the primary or caucuses according to the state’s criteria. Eg. the person needs to be above 18 years of age, not currently in prison or on parole for a felony conviction(in certain states), should be a citizen of US.

2. Candidate information
Our database will contain all the past and present information on the candidate running for election

3. Campaign information including social media
This database will keep an account of the funds allocated for the party campaigns which   take  place either through social media, television, news broadcast etc  

4. Electoral College
During the primary elections, people vote for delegates who in turn select a president. This database will contain all the information about the delegates that people will be voting for.

Objective of Project: 
1. Avoiding rogue voters
2. Tracking the data for the election administration to ensure smooth and faster processing of the elections 

-> An ERD diagram is added to show the different tables used in this project
-> The different datasets used in this project are zipped in the "Data" folder
-> The rules used for this database can be found in the "Business Rules" folder
-> the SQL scripts can be found in the USelectoral1.sql 
-> A bief documentation of this project is given in the report
