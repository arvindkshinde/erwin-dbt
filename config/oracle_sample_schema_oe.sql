
-- File Name: sample oracle DDL file
-- Description:
--  	This is a "SAMPLE" Oracle DDL file used for testing with erwin-dbt integration
 


CREATE TABLE oe_customers
(
	customer_id_col      NUMBER(6)  NOT NULL ,
	cust_first_name_col  VARCHAR2(20 BYTE)  NOT NULL ,
	cust_last_name_col   VARCHAR2(20 BYTE)  NOT NULL ,
	cust_address_col     CUST_ADDRESS_TYP  NULL ,
	phone_numbers_col    PHONE_LIST_TYP  NULL ,
	nls_language_col     VARCHAR2(3 BYTE)  NULL ,
	nls_territory_col    VARCHAR2(30 BYTE)  NULL ,
	credit_limit_col     NUMBER(9,2)  NULL ,
	cust_email_col       VARCHAR2(30 BYTE)  NULL ,
	account_mgr_id_col   NUMBER(6)  NULL ,
	cust_geo_location_col DECIMAL  NULL ,
	date_of_birth_col    DATE  NULL ,
	marital_status_col   VARCHAR2(20 BYTE)  NULL ,
	gender_col           VARCHAR2(1 BYTE)  NULL ,
	income_level_col     VARCHAR2(20 BYTE)  NULL 
);

CREATE UNIQUE INDEX CUSTOMERS_PK ON oe_customers
(customer_id_col   ASC);

ALTER TABLE oe_customers
	ADD CONSTRAINT  CUSTOMERS_PK PRIMARY KEY (customer_id_col);

ALTER TABLE oe_customers
	ADD CONSTRAINT  CUSTOMER_ID_MIN CHECK  (customer_id > 0);

ALTER TABLE oe_customers
	ADD CONSTRAINT  CUSTOMER_CREDIT_LIMIT_MAX CHECK  (credit_limit <= 5000);

CREATE INDEX CUST_UPPER_NAME_IX ON oe_customers
(UPPER ("CUST_LAST_NAME")   ASC,UPPER ("CUST_FIRST_NAME")   ASC);

CREATE INDEX CUST_ACCOUNT_MANAGER_IX ON oe_customers
(account_mgr_id_col   ASC);

CREATE INDEX CUST_LNAME_IX ON oe_customers
(cust_last_name_col   ASC);

CREATE INDEX CUST_EMAIL_IX ON oe_customers
(cust_email_col   ASC);

CREATE TABLE oe_inventories
(
	prod_id_col          NUMBER(6)  NOT NULL ,
	warehouse_id_col     NUMBER(3)  NOT NULL ,
	quantity_on_hand_col NUMBER(8)  NOT NULL 
);

CREATE UNIQUE INDEX INVENTORY_PK ON oe_inventories
(prod_id_col   ASC,warehouse_id_col   ASC);

ALTER TABLE oe_inventories
	ADD CONSTRAINT  INVENTORY_PK PRIMARY KEY (prod_id_col,warehouse_id_col);

CREATE TABLE oe_orders
(
	order_id_col         NUMBER(12)  NOT NULL ,
	order_date_col       TIMESTAMP WITH LOCAL TIME ZONE  NOT NULL ,
	order_mode_col       VARCHAR2(8 BYTE)  NULL ,
	customer_id_col      NUMBER(6)  NOT NULL ,
	order_status_col     NUMBER(2)  NULL ,
	order_total_col      NUMBER(8,2)  NULL ,
	sales_rep_id_col     NUMBER(6)  NULL ,
	promotion_id_col     NUMBER(6)  NULL 
);

CREATE UNIQUE INDEX ORDER_PK ON oe_orders
(order_id_col   ASC);

ALTER TABLE oe_orders
	ADD CONSTRAINT  ORDER_PK PRIMARY KEY (order_id_col);

ALTER TABLE oe_orders
	ADD CONSTRAINT  ORDER_MODE_LOV CHECK  (order_mode
 IN ('direct', 'online'));

ALTER TABLE oe_orders
	ADD CONSTRAINT  ORDER_TOTAL_MIN CHECK  (order_total >= 0);

CREATE INDEX ORD_SALES_REP_IX ON oe_orders
(sales_rep_id_col   ASC);

CREATE INDEX ORD_ORDER_DATE_IX ON oe_orders
(order_date_col   ASC);

CREATE TABLE oe_prod_information
(
	prod_id_col          NUMBER(6)  NOT NULL ,
	prod_name_col        VARCHAR2(50 BYTE)  NULL ,
	prod_description_col VARCHAR2(2000 BYTE)  NULL ,
	category_id_col      NUMBER(2)  NULL ,
	weight_class_col     NUMBER(1)  NULL ,
	warranty_period_col  INTERVAL YEAR TO MONTH  NULL ,
	supplier_id_col      NUMBER(6)  NULL ,
	prod_status_col      VARCHAR2(20 BYTE)  NULL ,
	list_price_col       NUMBER(8,2)  NULL ,
	min_price_col        NUMBER(8,2)  NULL ,
	catalog_url_col      VARCHAR2(50 BYTE)  NULL 
);

CREATE UNIQUE INDEX PRODUCT_INFORMATION_PK ON oe_prod_information
(prod_id_col   ASC);

ALTER TABLE oe_prod_information
	ADD CONSTRAINT  PRODUCT_INFORMATION_PK PRIMARY KEY (prod_id_col);

ALTER TABLE oe_prod_information
	ADD CONSTRAINT  PRODUCT_STATUS_LOV CHECK  (product_status
 IN ('orderable', 'planned', 'under development', 'obsolete'));

CREATE INDEX PROD_SUPPLIER_IX ON oe_prod_information
(supplier_id_col   ASC);

CREATE TABLE oe_prod_descriptions
(
	prod_id_col          NUMBER(6)  NOT NULL ,
	language_id_col      VARCHAR2(3 BYTE)  NOT NULL ,
	translated_name_col  NVARCHAR2(50)  NOT NULL ,
	translated_description_col NVARCHAR2(2000)  NOT NULL 
);

CREATE UNIQUE INDEX PRODUCT_DESCRIPTIONS_PK ON oe_prod_descriptions
(prod_id_col   ASC,language_id_col   ASC);

ALTER TABLE oe_prod_descriptions
	ADD CONSTRAINT  PRODUCT_DESCRIPTIONS_PK PRIMARY KEY (prod_id_col,language_id_col);

CREATE INDEX PROD_NAME_IX ON oe_prod_descriptions
(translated_name_col   ASC);

CREATE TABLE oe_order_items
(
	order_id_col         NUMBER(12)  NOT NULL ,
	line_item_id_col     NUMBER(3)  NOT NULL ,
	prod_id_col          NUMBER(6)  NOT NULL ,
	unit_price_col       NUMBER(8,2)  NULL ,
	quantity_col         NUMBER(8)  NULL 
);

CREATE UNIQUE INDEX ORDER_ITEMS_PK ON oe_order_items
(order_id_col   ASC,line_item_id_col   ASC);

ALTER TABLE oe_order_items
	ADD CONSTRAINT  ORDER_ITEMS_PK PRIMARY KEY (order_id_col,line_item_id_col);

CREATE UNIQUE INDEX ORDER_ITEMS_UK ON oe_order_items
(order_id_col   ASC,prod_id_col   ASC);

CREATE INDEX ITEM_PRODUCT_IX ON oe_order_items
(prod_id_col   ASC);

CREATE TABLE oe_promotions
(
	promo_id_col         NUMBER(6)  NOT NULL ,
	promo_name_col       VARCHAR2(20 BYTE)  NULL 
);

CREATE UNIQUE INDEX PROMO_ID_PK ON oe_promotions
(promo_id_col   ASC);

ALTER TABLE oe_promotions
	ADD CONSTRAINT  PROMO_ID_PK PRIMARY KEY (promo_id_col);

CREATE TABLE oe_warehouses
(
	warehouse_id_col     NUMBER(3)  NOT NULL ,
	warehouse_spec_col   XMLType  NULL ,
	warehouse_name_col   VARCHAR2(35 BYTE)  NULL ,
	location_id_col      NUMBER(4)  NULL ,
	wh_geo_location_col  DECIMAL  NULL 
);

CREATE UNIQUE INDEX WAREHOUSES_PK ON oe_warehouses
(warehouse_id_col   ASC);

ALTER TABLE oe_warehouses
	ADD CONSTRAINT  WAREHOUSES_PK PRIMARY KEY (warehouse_id_col);

CREATE INDEX WHS_LOCATION_IX ON oe_warehouses
(location_id_col   ASC);

CREATE OR REPLACE VIEW account_managers ( acct_mgr,region,country,province,num_customers ) 
	 AS  SELECT c.account_mgr_id_col,cr.region_id,c.cust_address.country_id,c.cust_address.state_province,count(*)
		FROM oe_customers c,countries cr
		WHERE c.cust_address.country_id = cr.country_id
		GROUP BY ROLLUP (c.account_mgr_id, cr.region_id, c.cust_address.country_id, c.cust_address.state_province);

CREATE OR REPLACE VIEW bombay_inventory ( product_id,product_name,quantity_on_hand_col ) 
	 AS  SELECT p.product_id,p.product_name,i.quantity_on_hand_col
		FROM oe_inventories i,oe_warehouses w,products p
		WHERE p.product_id = i.product_id AND
 i.warehouse_id = w.warehouse_id AND
 w.warehouse_name = 'Bombay';

CREATE OR REPLACE VIEW customers_view ( customer_id_col,cust_first_name_col,cust_last_name_col,street_address,postal_code,city,state_province,country_id,country_name,region_id,nls_language_col,nls_territory_col,credit_limit_col,cust_email_col,primary_phone_number,phone_number_2,phone_number_3,phone_number_4,phone_number_5,account_mgr_id_col,location_gtype,location_srid,location_x,location_y,location_z ) 
	 AS  SELECT c.customer_id_col,c.cust_first_name_col,c.cust_last_name_col,c.cust_address.street_address,c.cust_address.postal_code,c.cust_address.city,c.cust_address.state_province,co.country_id,co.country_name,co.region_id,c.nls_language_col,c.nls_territory_col,c.credit_limit_col,c.cust_email_col,substr (get_phone_number_f (1, phone_numbers), 1, 25),substr (get_phone_number_f (2, phone_numbers), 1, 25),substr (get_phone_number_f (3, phone_numbers), 1, 25),substr (get_phone_number_f (4, phone_numbers), 1, 25),substr (get_phone_number_f (5, phone_numbers), 1, 25),c.account_mgr_id_col,c.cust_geo_location.sdo_gtype,c.cust_geo_location.sdo_srid,c.cust_geo_location.sdo_point.x,c.cust_geo_location.sdo_point.y,c.cust_geo_location.sdo_point.z
		FROM countries co,oe_customers c
		WHERE c.cust_address.country_id = co.country_id(+);

CREATE OR REPLACE VIEW product_prices ( category_id_col,#_of_products,low_price,high_price ) 
	 AS  SELECT oe_prod_information.category_id_col,COUNT(*),MIN (list_price),MAX (list_price)
		FROM oe_prod_information 
		GROUP BY category_id;

CREATE OR REPLACE VIEW sydney_inventory ( product_id,product_name,quantity_on_hand_col ) 
	 AS  SELECT p.product_id,p.product_name,i.quantity_on_hand_col
		FROM oe_inventories i,oe_warehouses w,products p
		WHERE p.product_id = i.product_id AND
 i.warehouse_id = w.warehouse_id AND
 w.warehouse_name = 'Sydney';

CREATE OR REPLACE VIEW toronto_inventory ( product_id,product_name,quantity_on_hand_col ) 
	 AS  SELECT p.product_id,p.product_name,i.quantity_on_hand_col
		FROM oe_inventories i,oe_warehouses w,products p
		WHERE p.product_id = i.product_id AND
 i.warehouse_id = w.warehouse_id AND
 w.warehouse_name = 'Toronto';

ALTER TABLE oe_inventories
	ADD (
CONSTRAINT INVENTORIES_PRODUCT_ID_FK FOREIGN KEY (prod_id_col) REFERENCES oe_prod_information (prod_id_col)  NOT DEFERRABLE);

ALTER TABLE oe_inventories
	ADD (
CONSTRAINT INVENTORIES_WAREHOUSES_FK FOREIGN KEY (warehouse_id_col) REFERENCES oe_warehouses (warehouse_id_col)  NOT DEFERRABLE);

ALTER TABLE oe_orders
	ADD (
CONSTRAINT ORDERS_CUSTOMER_ID_FK FOREIGN KEY (customer_id_col) REFERENCES oe_customers (customer_id_col)  NOT DEFERRABLE ON DELETE SET NULL);

ALTER TABLE oe_prod_descriptions
	ADD (
CONSTRAINT PD_PRODUCT_ID_FK FOREIGN KEY (prod_id_col) REFERENCES oe_prod_information (prod_id_col)  NOT DEFERRABLE);

ALTER TABLE oe_order_items
	ADD (
CONSTRAINT ORDER_ITEMS_ORDER_ID_FK FOREIGN KEY (order_id_col) REFERENCES oe_orders (order_id_col)  NOT DEFERRABLE ON DELETE CASCADE);

ALTER TABLE oe_order_items
	ADD (
CONSTRAINT ORDER_ITEMS_PRODUCT_ID_FK FOREIGN KEY (prod_id_col) REFERENCES oe_prod_information (prod_id_col)  NOT DEFERRABLE);
