# PL-SQL_Parameter_Mode

#### Question 1:
&nbsp;Create a procedure that accepts 3 parameters, the first two are of mode IN
with number as their datatype and the third one is of mode OUT in form of Varchar2. 
The procedure will compare the first two numbers and output the result as EQUAL, or DIFFERENT.
<br>Create a second procedure called L8Q1 that accepts the two sides of a rectangle. 
The procedure will calculate the area and the perimeter of the rectangle. 
Use the procedure created previously to display if the shape is a square or a rectangle. 
The following are the example on how we execute the procedure and the expected output.
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SQL > exec L4Q1(2,2)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The area of a square size 2 by 2 is 4. It's perimeter is 8.
<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SQL > exec L4Q1(2,3)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The area of a rectangle size 2 by 3 is 6. It's perimeter is 10.
#### Question 2:
&nbsp;Create a pseudo function called pseudo_fun that accepts 2 parameters represented the 
height and width of a rectangle. The pseudo function should return the area and the perimeter of the rectangle.
<br>Create a second procedure called L4Q2 that accepts the two sides of a rectangle. 
The procedure will use the pseudo function to display the shape, the area and the perimeter.
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SQL > exec L4Q2(2,2)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The area of a square size 2 by 2 is 4. It's perimeter is 8.
<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SQL > exec L4Q2(2,3)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The area of a rectangle size 2 by 3 is 6. It's perimeter is 10.
#### Question 3: (use schemas des02, and script 7Clearwater)
&nbsp;Create a pseudo function that accepts 2 parameters represented the inv_id, and the percentage 
increase in price. The pseudo function should first update the database with the new
price then return the new price and the quantity on hand.
<br>Create a second procedure called L4Q3 that accepts the inv_id and the percentage increase in price. 
The procedure will use the pseudo function to display the new value of the inventory 
<br>(HINT: value = price X quantity on hand)
