SPOOL /tmp/oracle/projectPart4_spool.txt

SELECT
    to_char(sysdate, 'DD Month YYYY Year Day HH:MI:SS Am')
FROM
    dual;


/* Question 1:
    Create a procedure that accepts 3 parameters, 
the first two are of mode IN with number as 
their datatype and the third one is of mode OUT in form of Varchar2. 
The procedure will compare the first two numbers and output 
the result as EQUAL, or DIFFERENT. 
    Create a second procedure called L8Q1 that accepts the two sides 
of a rectangle. The 
procedure will calculate the area and the perimeter of the rectangle. 
Use the procedure created previously to display if the 
shape is a square or a rectangle. The following are the 
example on how we execute the procedure and the expected output.
SQL > exec L4Q1(2,2)
The area of a square size 2 by 2 is 4. It`s perimeter is 8.
SQL > exec L4Q1(2,3)
The area of a rectangle size 2 by 3 is 6. It`s perimeter is 10. */
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE equal_different(p_one IN NUMBER, p_two IN NUMBER, p_result OUT VARCHAR2) AS

BEGIN
    if p_one = p_two THEN
        p_result := 'EQUAL';
    ELSE
        p_result := 'DIFFERENT';
    END IF;
END;
/

CREATE OR REPLACE PROCEDURE L4Q1(p_side1 IN NUMBER, p_side2 IN NUMBER) AS
    shape VARCHAR2(10);
    perimeter NUMBER;
    area NUMBER;
    result VARCHAR(10);
BEGIN
    equal_different(p_side1, p_side2, result);
    IF result = 'EQUAL' THEN
        shape := 'square';
    ELSE
        shape := 'rectangle';
    END IF;
    perimeter := 2 * (p_side1 + p_side2);
    area := p_side1 * p_side2;
    
    DBMS_OUTPUT.PUT_LINE('The area of a ' || shape || ' size ' || p_side1 || ' by ' || p_side2 || ' is ' || area || '.' || chr(10) ||
                        'It''s perimeter is ' || perimeter || '.');
END;
/

exec L4Q1(2,2)

exec L4Q1(2,3)


/* Question 2:
    Create a pseudo function called pseudo_fun that accepts 2 parameters 
represented the height and width of a rectangle. The pseudo function 
should return the area and the perimeter of the rectangle.
    Create a second procedure called L4Q2 that accepts the two sides 
of a rectangle. The procedure will use the pseudo function to display 
the shape, the area and the perimeter.
SQL > exec L4Q2(2,2)
The area of a square size 2 by 2 is 4. It`s perimeter is 8.
SQL > exec L4Q2(2,3)
The area of a rectangle size 2 by 3 is 6. It`s perimeter is 10 */
CREATE OR REPLACE FUNCTION pseudo_fun(p_height IN NUMBER, p_width IN NUMBER, p_area OUT NUMBER)
RETURN NUMBER AS
    area NUMBER;
    perimeter NUMBER;
BEGIN
    p_area := area;
    area := p_height * p_width;
    perimeter := 2 * (p_height + p_width);
    RETURN perimeter;
END;
/

CREATE OR REPLACE PROCEDURE L4Q2(p_height IN NUMBER, p_width IN NUMBER) AS
    shape VARCHAR(10);
    perimeter NUMBER;
    p_area NUMBER;
BEGIN
    IF p_height = p_width THEN
        shape := 'square';
    ELSE
        shape := 'rectangle';
    END IF;
    perimeter := pseudo_fun(p_height, p_width, p_area);
    DBMS_OUTPUT.PUT_LINE('The area of a ' || shape || ' size ' || p_height || ' by ' || p_width || ' is ' || p_area || '.' || chr(10) ||
                        'It''s perimeter is ' || perimeter || '.');
END;
/

exec L4Q2(2,2)

exec L4Q2(2,3)


/* Question 3:
    Create a pseudo function that accepts 2 parameters represented the 
inv_id, and the percentage increase in price. The pseudo function 
should first update the database with the new price then return 
the new price and the quantity on hand.
    Create a second procedure 
called L4Q3 that accepts the inv_id and the percentage increase 
in price. The procedure will use the pseudo function to display 
the new value of the 
inventory (hint: value = price X quantity on hand) */
CONNECT des02/des02;

SET SERVEROUTPUT ON

CREATE OR REPLACE FUNCTION pseudo_fun2(p_inv_id IN NUMBER, p_percentage IN NUMBER, p_inv_qoh OUT NUMBER)
RETURN NUMBER AS
    price INVENTORY.INV_ID%TYPE;
    stock INVENTORY.INV_QOH%TYPE;
    percentage NUMBER;
    new_price INVENTORY.INV_PRICE%TYPE;
BEGIN
    SELECT
        INV_PRICE,
        INV_QOH INTO
        price,
        stock
    FROM
        INVENTORY
    WHERE
        INV_ID = p_inv_id;
    percentage := price / 100 * p_percentage;
    new_price := price + percentage;
    p_inv_qoh := stock;
    UPDATE
        INVENTORY
    SET
        INV_PRICE = new_price
    WHERE
        INV_ID = p_inv_id;   
    COMMIT;
    RETURN new_price;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Inventory ID ' || p_inv_id || ' doesn''t EXIST!');
    RETURN NULL;
END;
/

CREATE OR REPLACE PROCEDURE L4Q3(p_inv_id IN NUMBER, p_percentage IN NUMBER) AS
    new_value NUMBER;
    new_price INVENTORY.INV_PRICE%TYPE;
    stock INVENTORY.INV_QOH%TYPE;
    existing_inv_id NUMBER;
BEGIN
    IF p_percentage > -100 THEN
        SELECT
            count(*) INTO
            existing_inv_id
        FROM
            INVENTORY
        WHERE
            INV_ID = p_inv_id;

        new_price := pseudo_fun2(p_inv_id, p_percentage, stock);
        new_value := new_price * stock;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid percentage!');
    END IF;

    IF existing_inv_id > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Item with ID ' || p_inv_id || ' has new value: $' || new_value);
    END IF;
END;
/

exec L4Q3(32, 10)

exec L4Q3(50, 10)

exec L4Q3(32, 100)

exec L4Q3(32, -75)


SPOOL OFF;