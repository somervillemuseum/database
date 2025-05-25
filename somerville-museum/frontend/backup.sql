--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9
-- Dumped by pg_dump version 16.9 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: borrowers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.borrowers (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone_number character varying(15),
    borrow_history jsonb DEFAULT '{}'::jsonb,
    CONSTRAINT borrowers_email_check CHECK (((email)::text ~~ '%@%.%'::text))
);


--
-- Name: borrowers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.borrowers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: borrowers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.borrowers_id_seq OWNED BY public.borrowers.id;


--
-- Name: borrows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.borrows (
    id integer NOT NULL,
    borrower_id integer NOT NULL,
    item_id integer NOT NULL,
    date_borrowed character varying(10) DEFAULT to_char((CURRENT_DATE)::timestamp with time zone, 'MM/DD/YYYY'::text),
    return_date character varying(10),
    date_returned character varying(10),
    approver character varying(255),
    notes text
);


--
-- Name: borrows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.borrows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: borrows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.borrows_id_seq OWNED BY public.borrows.id;


--
-- Name: dummy_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dummy_data (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    status character varying(20) DEFAULT 'Available'::character varying,
    age_group character varying(10),
    gender character varying(10),
    color character varying(255)[],
    season character varying(255)[],
    garment_type character varying(255),
    size character varying(10),
    time_period character varying(255)[],
    condition character varying(255)[],
    cost integer,
    location character varying(255),
    date_added character varying(10) DEFAULT to_char((CURRENT_DATE)::timestamp with time zone, 'MM/DD/YYYY'::text),
    current_borrower integer,
    borrow_history integer[],
    notes text,
    image_keys character varying[],
    CONSTRAINT items_cost_check CHECK ((cost >= 0))
);


--
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.items_id_seq OWNED BY public.dummy_data.id;


--
-- Name: borrowers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.borrowers ALTER COLUMN id SET DEFAULT nextval('public.borrowers_id_seq'::regclass);


--
-- Name: borrows id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.borrows ALTER COLUMN id SET DEFAULT nextval('public.borrows_id_seq'::regclass);


--
-- Name: dummy_data id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dummy_data ALTER COLUMN id SET DEFAULT nextval('public.items_id_seq'::regclass);


--
-- Data for Name: borrowers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.borrowers (id, name, email, phone_number, borrow_history) FROM stdin;
1	John Doe	john.doe@example.com	555-123-4567	{}
2	Jane Smith	jane.smith@example.com	555-234-5678	{}
11	William Goldman	goldmanwilliam3@gmail.com	111-111-1111	{"1": {"note": "", "itemId": 1, "dueDate": "04/28/25", "approver": "William Goldman", "borrowerId": 11, "dateBorrowed": "04/07/25", "dateReturned": null}, "2": {"note": "", "itemId": 2, "dueDate": "04/21/25", "approver": "William Goldman", "borrowerId": 11, "dateBorrowed": "04/07/25", "dateReturned": null}, "16": {"note": "", "itemId": 16, "dueDate": "03/11/25", "approver": "", "borrowerId": 11, "dateBorrowed": "03/04/25", "dateReturned": null}, "3294241": {"note": "", "itemId": 3294241, "dueDate": "04/21/25", "approver": "William Goldman", "borrowerId": 11, "dateBorrowed": "04/07/25", "dateReturned": null}, "12546923": {"note": "", "itemId": 12546923, "dueDate": "03/06/25", "approver": "", "borrowerId": 11, "dateBorrowed": "02/27/25", "dateReturned": null}}
10	borrow monster	b@a.com	888-888-8888	{"16": {"note": "where is the success popup", "itemId": 16, "dueDate": "02/24/25", "approver": "", "borrowerId": 10, "dateBorrowed": "02/17/25", "dateReturned": null}}
3	john henderson	a@a.com	860-942-9116	{"1": {"note": "ima", "itemId": 1, "dueDate": "03/16/25", "approver": "", "borrowerId": 3, "dateBorrowed": "03/09/25", "dateReturned": null}, "3": {"note": "dklsdns", "itemId": 3, "dueDate": "04/13/25", "approver": "Zack White", "borrowerId": 3, "dateBorrowed": "04/06/25", "dateReturned": null}, "4": {"note": "advise", "itemId": 4, "dueDate": "04/13/25", "approver": "Zack White", "borrowerId": 3, "dateBorrowed": "04/06/25", "dateReturned": null}, "1776": {"note": "checkin", "itemId": 1776, "dueDate": "02/27/25", "approver": "", "borrowerId": 3, "dateBorrowed": "02/20/25", "dateReturned": null}, "12312": {"note": "1:24 AM", "itemId": 12312, "dueDate": "03/23/25", "approver": "", "borrowerId": 3, "dateBorrowed": "03/09/25", "dateReturned": null}, "25554": {"note": "none", "itemId": 25554, "dueDate": "2/24/2025", "approver": "John Henderson", "borrowerId": 3, "dateBorrowed": "2/17/2025", "dateReturned": null}, "42313": {"note": "bruhbruh", "itemId": 42313, "dueDate": "03/22/25", "approver": "", "borrowerId": 3, "dateBorrowed": "03/08/25", "dateReturned": null}, "42313543": {"note": "plz", "itemId": 42313543, "dueDate": "03/15/25", "approver": "", "borrowerId": 3, "dateBorrowed": "03/08/25", "dateReturned": null}}
12	jj licks	petercarlmorganelli@gmail.com	508-330-3922	{"1776": {"note": "helllo", "itemId": 1776, "dueDate": "03/14/25", "approver": "", "borrowerId": 12, "dateBorrowed": "02/28/25", "dateReturned": null}}
4	Elias Swartz	eliasl.swartz@gmail.com	718-687-3470	{"4": {"note": "ajksndfjkasdnfkj", "itemId": 4, "dueDate": "2/21/2025", "approver": "Barbara", "borrowerId": 4, "dateBorrowed": "2/14/2025", "dateReturned": "2/15/2025"}, "16": {"note": "hey hey hey", "itemId": 16, "dueDate": "2/21/2025", "approver": "fnkwsjed", "borrowerId": 4, "dateBorrowed": "2/14/2025", "dateReturned": null}, "31": {"note": "blalahhhhhh", "itemId": 31, "dueDate": "2/21/2025", "approver": "kjjhgj", "borrowerId": 4, "dateBorrowed": "2/14/2025", "dateReturned": null}, "134": {"note": "aye aye", "itemId": 134, "dueDate": "2/21/2025", "approver": "skjdnf", "borrowerId": 4, "dateBorrowed": "2/14/2025", "dateReturned": null}}
9	Holden Kittelberger	holdenkittelberger@gmail.com	111-111-1111	{"873": {"note": "test", "itemId": 873, "dueDate": "03/26/25", "approver": "", "borrowerId": 9, "dateBorrowed": "03/12/25", "dateReturned": null}, "1256": {"note": "For patriots day event", "itemId": 1256, "dueDate": "03/06/25", "approver": "", "borrowerId": 9, "dateBorrowed": "02/20/25", "dateReturned": null}, "1776": {"note": "Nuhthin", "itemId": 1776, "dueDate": "2/24/2025", "approver": "Me", "borrowerId": 9, "dateBorrowed": "2/17/2025", "dateReturned": null}, "8273": {"note": "this guy crazy", "itemId": 8273, "dueDate": "03/30/25", "approver": "", "borrowerId": 9, "dateBorrowed": "03/09/25", "dateReturned": null}, "42312": {"note": "sadsad", "itemId": 42312, "dueDate": "03/16/25", "approver": "", "borrowerId": 9, "dateBorrowed": "03/09/25", "dateReturned": null}, "83728": {"note": "asd", "itemId": 83728, "dueDate": "04/14/25", "approver": "", "borrowerId": 9, "dateBorrowed": "03/24/25", "dateReturned": null}, "3294238": {"note": "silly guy", "itemId": 3294238, "dueDate": "03/30/25", "approver": "", "borrowerId": 9, "dateBorrowed": "03/09/25", "dateReturned": null}}
38	t t	bottarimassimo0@gmail.com	781-732-1575	{"3294246": {"note": "ojiuygj", "itemId": 3294246, "dueDate": "05/12/25", "approver": "momimo bototino", "borrowerId": 38, "dateBorrowed": "04/14/25", "dateReturned": null}, "3294247": {"note": "rsatj", "itemId": 3294247, "dueDate": "05/05/25", "approver": "momimo bototino", "borrowerId": 38, "dateBorrowed": "04/14/25", "dateReturned": null}, "3294249": {"note": "rsatj", "itemId": 3294249, "dueDate": "05/05/25", "approver": "momimo bototino", "borrowerId": 38, "dateBorrowed": "04/14/25", "dateReturned": null}}
30	Angie Zhang	angiezhang54@gmail.com	626-474-3380	{"2": {"note": "", "itemId": 2, "dueDate": "04/22/25", "approver": "", "borrowerId": 30, "dateBorrowed": "03/25/25", "dateReturned": null}, "3": {"note": "", "itemId": 3, "dueDate": "04/15/25", "approver": "", "borrowerId": 30, "dateBorrowed": "03/25/25", "dateReturned": null}, "4": {"note": "", "itemId": 4, "dueDate": "04/15/25", "approver": "", "borrowerId": 30, "dateBorrowed": "03/25/25", "dateReturned": null}, "5": {"note": "", "itemId": 5, "dueDate": "04/15/25", "approver": "", "borrowerId": 30, "dateBorrowed": "03/25/25", "dateReturned": null}, "17": {"note": "", "itemId": 17, "dueDate": "04/22/25", "approver": "", "borrowerId": 30, "dateBorrowed": "03/25/25", "dateReturned": null}, "22": {"note": "", "itemId": 22, "dueDate": "04/08/25", "approver": "", "borrowerId": 30, "dateBorrowed": "03/25/25", "dateReturned": null}}
31	Bob Bob	bob@bob.com	222-222-2222	{"31": {"note": "", "itemId": 31, "dueDate": "04/16/25", "approver": "", "borrowerId": 31, "dateBorrowed": "03/26/25", "dateReturned": null}}
32	bob bob	bob@yahoo.com	222-222-2222	{"12349": {"note": "", "itemId": 12349, "dueDate": "04/09/25", "approver": "", "borrowerId": 32, "dateBorrowed": "03/26/25", "dateReturned": null}}
33	me me	megan.yi@tufts.edu	888-888-8888	{"134": {"note": "t", "itemId": 134, "dueDate": "04/14/25", "approver": "Megan Yi", "borrowerId": 33, "dateBorrowed": "04/07/25", "dateReturned": null}}
34	Danny Boi	daniel.glorioso@Tufts.edu	819-734-5891	{"5": {"note": "ajdskfjkasdnfjkasjndf", "itemId": 5, "dueDate": "04/20/25", "approver": "Dan G", "borrowerId": 34, "dateBorrowed": "04/13/25", "dateReturned": null}}
39	ee ee	robloxisthebestgame818@gmail.com	781-732-1575	{"3294246": {"note": "srftfggj", "itemId": 3294246, "dueDate": "05/05/25", "approver": "momimo bototino", "borrowerId": 39, "dateBorrowed": "04/14/25", "dateReturned": null}, "3294248": {"note": "srftfggj", "itemId": 3294248, "dueDate": "05/05/25", "approver": "momimo bototino", "borrowerId": 39, "dateBorrowed": "04/14/25", "dateReturned": null}, "3294249": {"note": "fghjkrf", "itemId": 3294249, "dueDate": "05/19/25", "approver": "momimo bototino", "borrowerId": 39, "dateBorrowed": "04/14/25", "dateReturned": null}, "3294250": {"note": "fghjkrf", "itemId": 3294250, "dueDate": "05/19/25", "approver": "momimo bototino", "borrowerId": 39, "dateBorrowed": "04/14/25", "dateReturned": null}}
40	Barbara Mangum	bmangum411@aol.com	617-331-7726	{}
\.


--
-- Data for Name: borrows; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.borrows (id, borrower_id, item_id, date_borrowed, return_date, date_returned, approver, notes) FROM stdin;
1	11	201	04/18/25	05/16/25	\N	William Goldman	
2	11	200	04/18/25	05/16/25	\N	William Goldman	
4	11	197	04/18/25	05/16/25	\N	William Goldman	
5	30	3	04/18/25	05/02/25	4/18/2025	Angie Zhang	
6	30	6	04/18/25	05/02/25	4/18/2025	Angie Zhang	
3	11	199	04/18/25	05/16/25	4/18/2025	William Goldman	
7	30	17	04/18/25	05/09/25	4/18/2025	Angie Zhang	
8	30	17	04/18/25	05/02/25	4/18/2025	Angie Zhang	
9	30	18	04/18/25	05/09/25	4/18/2025	Angie Zhang	
10	30	18	04/18/25	05/09/25	4/18/2025	Angie Zhang	
11	30	1	04/18/25	05/09/25	4/18/2025	Angie Zhang	
12	30	2	04/18/25	05/09/25	4/18/2025	Angie Zhang	
13	30	3	04/18/25	05/02/25	4/18/2025	Angie Zhang	
14	30	2	04/18/25	05/02/25	4/18/2025	Angie Zhang	
15	30	1	04/18/25	05/02/25	4/18/2025	Angie Zhang	
17	30	1	04/18/25	05/02/25	4/18/2025	Angie Zhang	
16	30	2	04/18/25	05/02/25	4/18/2025	Angie Zhang	
20	30	1	04/18/25	05/16/25	4/18/2025	Angie Zhang	
19	30	2	04/18/25	05/16/25	4/18/2025	Angie Zhang	
22	9	6	04/19/25	05/10/25	\N	Admin Account	tough
23	9	5	04/19/25	05/10/25	\N	Admin Account	tough
24	9	4	04/19/25	05/10/25	\N	Admin Account	tough
21	9	7	04/19/25	05/10/25	4/20/2025	Admin Account	tough
18	30	3	04/18/25	05/16/25	4/20/2025	Angie Zhang	
25	11	4	04/20/25	05/11/25	\N	William Goldman	
26	11	3	04/20/25	05/11/25	\N	William Goldman	
27	11	2	04/20/25	05/11/25	\N	William Goldman	
28	11	1	04/20/25	05/11/25	\N	William Goldman	
29	9	3	04/22/25	05/13/25	\N	Admin Account	
30	9	5	04/22/25	05/13/25	\N	Admin Account	
31	9	7	04/22/25	05/13/25	\N	Admin Account	
32	9	10	04/30/25	05/14/25	\N	Admin Account	
34	40	9	05/08/25	06/05/25	\N	Admin Account	
35	9	52	05/15/25	05/22/25	\N	Admin Account	
39	9	59	05/15/25	05/22/25	\N	Admin Account	
38	9	57	05/15/25	05/22/25	5/15/2025	Admin Account	not good
37	9	56	05/15/25	05/22/25	5/15/2025	Admin Account	do better
36	9	55	05/15/25	05/22/25	5/15/2025	Admin Account	torn
33	9	213	04/30/25	05/14/25	5/15/2025	Admin Account	sad
\.


--
-- Data for Name: dummy_data; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.dummy_data (id, name, status, age_group, gender, color, season, garment_type, size, time_period, condition, cost, location, date_added, current_borrower, borrow_history, notes, image_keys) FROM stdin;
8	Vintage Pants	Available	Adult	Female	{Grey}	{Fall}	Shoes	Large	{1750s-1800s}	{"Not usable"}	243	\N	02/24/2025	\N	\N	Note 27	{}
12	Stylish Coat	Missing	Adult	Female	{Pink,Orange}	{Winter,Spring}	Gowns/dresses	Medium	{1800s-1840s,1750s-1800s}	{"Not usable"}	160	\N	11/28/2024	\N	\N	Note 39	{}
13	Casual Jacket	Available	Adult	Female	{Red,Black}	{Summer}	Gowns/dresses	Large	{Post-1920s,1800s-1840s}	{Great}	281	Location 69	05/13/2024	\N	\N	Note 48	{}
14	Stylish Scarf	Missing	Adult	Female	{Yellow,Pink}	{Summer}	Vests	X-Large	{1750s-1800s}	{Great,"Needs dry cleaning"}	176	\N	09/07/2024	\N	\N	\N	{}
15	Elegant Coat	Available	Youth	Male	{Red,Grey}	{Fall,Spring}	Bottoms	X-Large	{1750s-1800s,Post-1920s}	{"Needs dry cleaning","Needs repair"}	193	\N	12/17/2024	\N	\N	\N	{}
16	Trendy Scarf	Missing	Adult	Unisex	{Orange,Pink}	{Fall}	Vests	Medium	{1750s-1800s}	{"Needs repair","Needs dry cleaning"}	162	Location 28	09/28/2024	\N	\N	Note 7	{}
19	Stylish Hat	Available	Youth	Male	{Green}	{Winter,Fall}	Outerwear	Large	{Post-1920s}	{Good,"Needs repair"}	16	\N	09/26/2024	\N	\N	Note 31	{}
20	Classic Boots	Available	Youth	Unisex	{Black,White}	{Summer,Spring}	Gowns/dresses	X-Large	{Pre-1700s,1750s-1800s}	{Good,"Needs dry cleaning"}	186	Location 54	03/30/2024	\N	\N	Note 49	{}
22	Classic Sweater	Missing	Adult	Male	{Yellow}	{Fall}	Socks/hose	Small	{Post-1920s,1800s-1840s}	{"Needs dry cleaning"}	237	\N	04/18/2024	\N	\N	\N	{}
23	Vintage Dress	Available	Youth	Female	{Yellow}	{Spring}	Outerwear	Large	{Post-1920s}	{"Needs washing","Needs dry cleaning"}	269	Location 83	01/21/2025	\N	\N	Note 5	{}
24	Stylish Pants	Available	Adult	Unisex	{Pink}	{Fall,Winter}	Shoes	X-Large	{Post-1920s,1800s-1840s}	{"Needs repair"}	59	Location 99	06/23/2024	\N	\N	Note 44	{}
25	Classic Coat	Available	Adult	Male	{Blue,Orange}	{Fall,Winter}	Gowns/dresses	Medium	{1750s-1800s}	{"Needs dry cleaning"}	298	Location 96	10/01/2024	\N	\N	Note 25	{}
26	Stylish Jacket	Available	Adult	Male	{Green}	{Spring,Fall}	Vests	Large	{Pre-1700s}	{Great}	246	\N	02/14/2025	\N	\N	\N	{}
27	Casual Boots	Missing	Adult	Unisex	{Red,Black}	{Summer,Winter}	Shoes	Large	{Post-1920s}	{Great}	227	Location 3	08/13/2024	\N	\N	\N	{}
9	Trendy Coat	Borrowed	Youth	Female	{White}	{Fall}	Outerwear	Small	{Post-1920s}	{"Needs dry cleaning"}	126	Location 9	03/28/2024	40	\N	\N	{}
2	Trendy Sweater	Available	Adult	Unisex	{Red,Pink}	{Winter}	Tops	X-Large	{Pre-1700s,1800s-1840s}	{"Needs dry cleaning"}	133	Location 37	03/15/2025	11	\N	\N	{}
7	Elegant Coat	Borrowed	Youth	Unisex	{Black,Blue}	{Spring,Summer}	Bottoms	Medium	{Pre-1700s}	{Great,Good}	28	Location 53	07/26/2024	9	\N	Note 25	{}
21	Trendy Pants	Available	Youth	Female	{Yellow}	{Summer}	Outerwear	X-Large	{Pre-1700s}	{"Needs dry cleaning"}	193	\N	08/01/2024	\N	\N	\N	{}
17	Modern Skirt	Available	Youth	Unisex	{Pink}	{Spring,Summer}	Socks/hose	Medium	{Pre-1700s,Post-1920s}	{"Needs repair"}	205	Location 71	12/04/2024	\N	\N	Note 29	{}
18	Modern Jacket	Available	Adult	Unisex	{Brown}	{Summer}	Outerwear	Medium	{Pre-1700s,1800s-1840s}	{"Needs dry cleaning"}	148	\N	05/31/2024	\N	\N	Note 33	{}
6	Modern Dress	Missing	Youth	Female	{Grey,White}	{Fall,Spring}	Socks/hose	Medium	{1750s-1800s}	{"Needs dry cleaning"}	229	Location 9	01/05/2024	9	\N	\N	{}
11	Casual Sweater	Available	Adult	Unisex	{Yellow,Purple}	{Summer}	Accessories	Small	{1750s-1800s}	{Great}	30	Location 86	10/18/2024	\N	\N	Note 19	{}
4	Classic Sweater	Available	Adult	Male	{White}	{Summer,Fall}	Socks/hose	Large	{Post-1920s,1750s-1800s}	{"Needs washing"}	123	Location 18	10/18/2024	11	\N	Note 33	{}
1	Classic Shirt	Available	Adult	Male	{Purple,Yellow}	{Spring}	Accessories	X-Large	{Post-1920s,Pre-1700s}	{"Not usable"}	56	\N	11/02/2024	\N	\N	\N	{}
28	Elegant Sweater	Missing	Adult	Female	{Red}	{Spring,Winter}	Outerwear	Large	{1800s-1840s,Post-1920s}	{Great,"Not usable"}	16	Location 27	07/21/2024	\N	\N	Note 6	{}
29	Formal Skirt	Available	Youth	Unisex	{White}	{Summer,Spring}	Tops	Large	{Pre-1700s,Post-1920s}	{"Needs dry cleaning"}	24	Location 86	03/05/2025	\N	\N	\N	{}
30	Classic Boots	Available	Youth	Female	{Purple,Black}	{Fall,Spring}	Tops	X-Large	{Post-1920s,1800s-1840s}	{Good,Great}	96	Location 14	06/18/2024	\N	\N	Note 13	{}
31	Casual Vest	Available	Youth	Unisex	{Pink}	{Spring}	Bottoms	Large	{1800s-1840s,Post-1920s}	{Good,"Not usable"}	117	Location 51	01/25/2025	\N	\N	\N	{}
32	Casual Hat	Missing	Youth	Unisex	{Green,Purple}	{Winter}	Socks/hose	Medium	{1800s-1840s}	{"Needs washing","Not usable"}	203	\N	09/16/2024	\N	\N	Note 6	{}
33	Elegant Skirt	Missing	Adult	Unisex	{Orange}	{Spring}	Gowns/dresses	Medium	{1750s-1800s,Post-1920s}	{"Needs washing",Great}	174	Location 31	03/13/2025	\N	\N	\N	{}
34	Vintage Sweater	Available	Youth	Unisex	{Purple,Grey}	{Fall}	Vests	Small	{Pre-1700s,Post-1920s}	{"Needs washing","Needs repair"}	192	\N	10/13/2024	\N	\N	Note 14	{}
35	Elegant Skirt	Missing	Adult	Male	{Black,Yellow}	{Summer,Winter}	Bottoms	Large	{1800s-1840s,Post-1920s}	{Great,"Needs washing"}	96	Location 42	05/21/2024	\N	\N	Note 13	{}
36	Elegant Coat	Missing	Youth	Male	{Green}	{Spring,Winter}	Socks/hose	Small	{1800s-1840s,Post-1920s}	{"Needs repair","Needs dry cleaning"}	252	Location 51	09/27/2024	\N	\N	\N	{}
37	Modern Hat	Available	Adult	Female	{Orange,Black}	{Winter,Summer}	Socks/hose	Medium	{1750s-1800s,Post-1920s}	{Great}	260	\N	02/07/2025	\N	\N	Note 31	{}
38	Casual Scarf	Missing	Youth	Female	{Red,Grey}	{Spring}	Bottoms	X-Large	{Pre-1700s,Post-1920s}	{"Needs washing"}	193	Location 41	01/29/2025	\N	\N	\N	{}
39	Modern Scarf	Missing	Youth	Unisex	{Yellow}	{Summer}	Vests	Small	{1800s-1840s}	{Great}	140	Location 60	12/03/2024	\N	\N	\N	{}
40	Vintage Shirt	Available	Adult	Unisex	{Yellow,Black}	{Spring}	Socks/hose	Small	{1750s-1800s}	{"Needs repair","Not usable"}	152	Location 20	08/22/2024	\N	\N	Note 28	{}
41	Elegant Jacket	Available	Youth	Male	{Red,Green}	{Winter}	Socks/hose	Small	{Post-1920s}	{Great}	80	Location 57	10/07/2024	\N	\N	Note 8	{}
42	Formal Sweater	Available	Youth	Unisex	{Blue}	{Spring,Summer}	Shoes	X-Large	{Post-1920s,1750s-1800s}	{Good}	190	Location 37	04/29/2024	\N	\N	Note 28	{}
43	Formal Skirt	Available	Adult	Male	{White}	{Fall,Spring}	Tops	Medium	{Post-1920s}	{"Needs dry cleaning",Great}	81	Location 76	10/17/2024	\N	\N	Note 45	{}
44	Formal Shirt	Missing	Youth	Male	{Grey,Red}	{Summer}	Shoes	Large	{1800s-1840s}	{"Not usable","Needs repair"}	258	Location 3	03/22/2024	\N	\N	Note 11	{}
45	Vintage Pants	Missing	Youth	Female	{Yellow}	{Fall,Winter}	Accessories	Medium	{1750s-1800s}	{"Needs repair"}	197	Location 50	12/20/2024	\N	\N	\N	{}
46	Modern Dress	Missing	Youth	Male	{Black}	{Fall}	Vests	Medium	{1750s-1800s}	{Great}	289	Location 7	02/14/2025	\N	\N	Note 4	{}
47	Casual Sweater	Missing	Youth	Male	{Brown}	{Spring}	Gowns/dresses	Small	{1750s-1800s,Pre-1700s}	{Good}	245	\N	05/02/2024	\N	\N	\N	{}
48	Stylish Dress	Available	Youth	Male	{Yellow}	{Winter,Spring}	Gowns/dresses	Medium	{Post-1920s}	{"Not usable","Needs repair"}	32	\N	10/15/2024	\N	\N	\N	{}
49	Vintage Scarf	Available	Adult	Unisex	{Pink,Orange}	{Fall}	Outerwear	Medium	{Post-1920s}	{"Needs dry cleaning","Not usable"}	82	Location 59	03/08/2025	\N	\N	Note 12	{}
50	Vintage Vest	Available	Adult	Female	{Black,Purple}	{Fall}	Bottoms	Medium	{1750s-1800s,1800s-1840s}	{"Needs repair"}	273	Location 63	03/24/2025	\N	\N	Note 20	{}
51	Formal Dress	Missing	Adult	Male	{Green}	{Spring}	Socks/hose	Large	{1800s-1840s}	{"Needs washing","Needs dry cleaning"}	292	Location 84	01/21/2024	\N	\N	\N	{}
53	Vintage Scarf	Missing	Youth	Unisex	{Yellow}	{Summer,Fall}	Shoes	X-Large	{Post-1920s}	{"Not usable"}	170	Location 95	02/18/2024	\N	\N	Note 12	{}
54	Trendy Scarf	Missing	Adult	Male	{Yellow}	{Fall,Summer}	Vests	X-Large	{Pre-1700s}	{"Not usable","Needs dry cleaning"}	82	Location 11	02/03/2024	\N	\N	Note 26	{}
58	Trendy Sweater	Missing	Youth	Unisex	{Red,Purple}	{Winter,Summer}	Socks/hose	Medium	{1750s-1800s,Post-1920s}	{Great,"Needs dry cleaning"}	161	\N	12/03/2024	\N	\N	\N	{}
60	Formal Scarf	Available	Youth	Male	{Blue}	{Summer}	Accessories	X-Large	{1800s-1840s,Post-1920s}	{"Needs repair"}	132	Location 40	08/25/2024	\N	\N	Note 32	{}
61	Stylish Shirt	Available	Youth	Unisex	{Black}	{Spring}	Vests	Medium	{Post-1920s,Pre-1700s}	{"Needs repair"}	163	Location 82	06/24/2024	\N	\N	\N	{}
62	Elegant Skirt	Missing	Youth	Unisex	{Yellow,Pink}	{Winter}	Shoes	Small	{1750s-1800s,Pre-1700s}	{"Needs repair"}	180	Location 26	08/22/2024	\N	\N	Note 9	{}
63	Vintage Shirt	Available	Adult	Unisex	{Orange}	{Winter}	Outerwear	Medium	{Pre-1700s,Post-1920s}	{"Not usable"}	221	Location 3	01/05/2024	\N	\N	Note 24	{}
64	Modern Skirt	Missing	Youth	Male	{Red,White}	{Fall}	Vests	Medium	{Pre-1700s}	{"Not usable","Needs washing"}	65	Location 55	08/30/2024	\N	\N	Note 29	{}
65	Casual Shirt	Available	Adult	Female	{White}	{Summer,Winter}	Bottoms	Small	{1800s-1840s}	{Good}	237	Location 11	02/19/2024	\N	\N	\N	{}
66	Trendy Boots	Missing	Youth	Female	{Grey,White}	{Summer}	Gowns/dresses	X-Large	{Post-1920s}	{"Needs dry cleaning",Good}	48	Location 37	04/20/2024	\N	\N	\N	{}
67	Stylish Boots	Available	Adult	Female	{Orange,Green}	{Winter}	Outerwear	Medium	{1800s-1840s,Pre-1700s}	{"Needs washing"}	265	\N	05/04/2024	\N	\N	Note 28	{}
68	Vintage Coat	Missing	Youth	Female	{Grey}	{Winter}	Accessories	X-Large	{1750s-1800s}	{Great,"Needs dry cleaning"}	119	Location 76	07/31/2024	\N	\N	Note 2	{}
69	Casual Skirt	Available	Youth	Male	{Black,Brown}	{Spring}	Bottoms	X-Large	{1800s-1840s,Pre-1700s}	{"Needs repair","Needs dry cleaning"}	184	\N	02/21/2025	\N	\N	\N	{}
71	Formal Pants	Available	Youth	Female	{Purple}	{Spring}	Vests	X-Large	{1750s-1800s}	{Good}	85	Location 46	03/16/2024	\N	\N	\N	{}
72	Formal Coat	Available	Adult	Male	{Orange,Purple}	{Spring}	Tops	Medium	{Pre-1700s}	{"Needs dry cleaning"}	20	Location 30	03/25/2024	\N	\N	Note 47	{}
73	Classic Shirt	Missing	Adult	Unisex	{Red}	{Fall,Spring}	Vests	X-Large	{1800s-1840s,Post-1920s}	{"Not usable","Needs washing"}	258	Location 91	03/30/2024	\N	\N	\N	{}
74	Trendy Skirt	Available	Adult	Female	{Grey,Purple}	{Winter,Summer}	Outerwear	X-Large	{Post-1920s,1750s-1800s}	{"Needs washing","Needs dry cleaning"}	17	Location 75	01/31/2024	\N	\N	\N	{}
75	Trendy Coat	Available	Youth	Male	{Brown}	{Winter,Spring}	Outerwear	X-Large	{Post-1920s,Pre-1700s}	{"Needs washing",Great}	204	\N	05/25/2024	\N	\N	\N	{}
76	Elegant Skirt	Available	Adult	Unisex	{White,Black}	{Spring,Fall}	Shoes	X-Large	{Pre-1700s,1750s-1800s}	{"Needs repair","Not usable"}	72	\N	02/28/2024	\N	\N	Note 4	{}
77	Stylish Dress	Available	Adult	Male	{Red,Yellow}	{Winter,Fall}	Vests	Medium	{Pre-1700s,1750s-1800s}	{Great,"Needs washing"}	180	Location 30	06/08/2024	\N	\N	Note 5	{}
78	Stylish Boots	Available	Adult	Female	{Green}	{Spring,Winter}	Accessories	X-Large	{Pre-1700s}	{"Needs washing","Not usable"}	96	Location 5	02/25/2025	\N	\N	Note 14	{}
79	Vintage Jacket	Available	Adult	Male	{Black}	{Winter}	Outerwear	Medium	{Pre-1700s}	{Good}	187	Location 25	12/30/2024	\N	\N	Note 15	{}
80	Formal Jacket	Available	Youth	Unisex	{Green}	{Summer,Fall}	Socks/hose	Large	{1800s-1840s,Post-1920s}	{Good}	224	Location 14	10/02/2024	\N	\N	\N	{}
55	Trendy Coat	Available	Adult	Male	{Red,Yellow}	{Spring}	Tops	X-Large	{1800s-1840s}	{"Not usable","Needs repair"}	133	Location 31	07/12/2024	\N	\N	Note 8	{}
56	Stylish Shirt	Available	Adult	Female	{Green}	{Winter}	Shoes	X-Large	{Pre-1700s,Post-1920s}	{Great}	291	\N	10/20/2024	\N	\N	\N	{}
59	Formal Dress	Borrowed	Youth	Female	{Brown,Green}	{Summer,Winter}	Gowns/dresses	X-Large	{1750s-1800s,1800s-1840s}	{"Needs repair"}	54	\N	02/19/2024	9	\N	\N	{}
57	Formal Sweater	Available	Adult	Unisex	{Green,Red}	{Winter,Fall}	Tops	Medium	{Post-1920s}	{"Needs repair",Good}	156	Location 98	01/25/2025	\N	\N	Note 28	{}
81	Trendy Boots	Available	Adult	Female	{Grey,Yellow}	{Spring}	Gowns/dresses	X-Large	{Pre-1700s,1800s-1840s}	{"Needs washing"}	228	Location 32	02/27/2025	\N	\N	\N	{}
82	Casual Shirt	Missing	Adult	Female	{Pink,Red}	{Winter}	Shoes	Medium	{1750s-1800s}	{"Needs washing","Not usable"}	65	\N	03/20/2025	\N	\N	\N	{}
83	Trendy Skirt	Available	Youth	Female	{Orange}	{Fall,Summer}	Bottoms	Medium	{1750s-1800s,1800s-1840s}	{Good}	157	Location 99	02/09/2024	\N	\N	\N	{}
84	Stylish Jacket	Available	Youth	Unisex	{Blue}	{Winter,Spring}	Accessories	Large	{Post-1920s,1800s-1840s}	{"Needs washing"}	132	Location 38	02/14/2025	\N	\N	\N	{}
85	Stylish Skirt	Missing	Youth	Female	{Orange,Black}	{Winter,Fall}	Gowns/dresses	X-Large	{1750s-1800s,Pre-1700s}	{"Needs washing"}	235	\N	03/23/2025	\N	\N	\N	{}
86	Elegant Jacket	Missing	Adult	Female	{Green,Orange}	{Fall}	Bottoms	Small	{Pre-1700s,1800s-1840s}	{Good,"Needs dry cleaning"}	60	Location 94	03/05/2024	\N	\N	Note 8	{}
87	Casual Coat	Missing	Youth	Male	{Brown}	{Summer}	Gowns/dresses	Small	{Post-1920s,1750s-1800s}	{"Needs washing"}	108	Location 24	05/16/2024	\N	\N	\N	{}
88	Formal Dress	Available	Adult	Female	{Yellow,Red}	{Spring,Fall}	Shoes	Small	{Pre-1700s}	{Good}	97	Location 59	03/31/2025	\N	\N	Note 16	{}
89	Casual Scarf	Missing	Youth	Male	{Pink}	{Spring,Fall}	Shoes	Large	{1750s-1800s}	{"Not usable",Great}	71	Location 7	03/10/2025	\N	\N	\N	{}
90	Vintage Coat	Available	Adult	Female	{Green}	{Spring}	Socks/hose	Medium	{1800s-1840s,1750s-1800s}	{"Needs repair","Needs washing"}	130	\N	11/25/2024	\N	\N	\N	{}
91	Stylish Skirt	Available	Adult	Unisex	{Pink,Blue}	{Spring}	Accessories	Small	{Pre-1700s}	{Good}	236	Location 34	06/13/2024	\N	\N	\N	{}
92	Stylish Skirt	Available	Adult	Female	{Grey,Orange}	{Summer}	Gowns/dresses	Medium	{Pre-1700s,1800s-1840s}	{Great}	165	Location 29	11/07/2024	\N	\N	\N	{}
93	Modern Dress	Missing	Youth	Unisex	{White}	{Winter}	Gowns/dresses	X-Large	{Pre-1700s,1750s-1800s}	{"Needs repair","Needs washing"}	213	\N	02/11/2024	\N	\N	\N	{}
94	Vintage Boots	Available	Youth	Male	{Pink,Green}	{Fall,Winter}	Bottoms	X-Large	{1800s-1840s,1750s-1800s}	{"Not usable"}	239	Location 29	12/27/2024	\N	\N	Note 48	{}
95	Formal Scarf	Available	Youth	Unisex	{Yellow}	{Summer}	Tops	Medium	{1800s-1840s}	{Good}	29	Location 59	12/08/2024	\N	\N	\N	{}
96	Classic Jacket	Missing	Adult	Unisex	{Black}	{Winter,Summer}	Tops	Medium	{Post-1920s}	{"Not usable",Good}	37	\N	06/30/2024	\N	\N	Note 21	{}
97	Formal Hat	Available	Youth	Female	{Pink}	{Summer}	Gowns/dresses	Medium	{1800s-1840s,Pre-1700s}	{Great}	261	\N	11/30/2024	\N	\N	Note 4	{}
98	Formal Sweater	Available	Adult	Female	{Red,Grey}	{Winter,Summer}	Tops	X-Large	{Post-1920s,1800s-1840s}	{Great,"Needs repair"}	147	Location 58	05/21/2024	\N	\N	\N	{}
100	Classic Sweater	Available	Youth	Unisex	{Grey}	{Summer,Winter}	Outerwear	X-Large	{1800s-1840s}	{"Needs repair",Good}	124	\N	02/13/2024	\N	\N	Note 14	{}
101	Casual Pants	Missing	Adult	Female	{Red}	{Fall,Winter}	Shoes	Medium	{1800s-1840s}	{Great,"Needs repair"}	195	\N	03/13/2025	\N	\N	Note 18	{}
102	Trendy Sweater	Available	Adult	Female	{Black,Red}	{Fall,Summer}	Accessories	Small	{Post-1920s}	{Great}	230	Location 22	04/02/2024	\N	\N	Note 10	{}
103	Elegant Jacket	Available	Adult	Male	{Red,Blue}	{Winter,Spring}	Outerwear	X-Large	{Pre-1700s}	{Great}	79	\N	12/08/2024	\N	\N	\N	{}
104	Formal Sweater	Available	Adult	Unisex	{White}	{Spring,Winter}	Outerwear	Small	{Post-1920s}	{"Needs repair",Good}	57	Location 54	01/04/2025	\N	\N	\N	{}
105	Casual Jacket	Available	Youth	Male	{Green}	{Summer,Spring}	Shoes	Large	{1750s-1800s}	{"Needs dry cleaning"}	178	Location 50	03/14/2024	\N	\N	Note 35	{}
106	Trendy Skirt	Missing	Adult	Female	{Grey,Red}	{Spring}	Accessories	Large	{1750s-1800s,Pre-1700s}	{"Needs washing","Needs dry cleaning"}	189	\N	11/10/2024	\N	\N	Note 3	{}
107	Trendy Shirt	Missing	Adult	Unisex	{Pink}	{Winter}	Socks/hose	Large	{Pre-1700s,Post-1920s}	{"Needs dry cleaning"}	32	\N	07/26/2024	\N	\N	\N	{}
108	Modern Dress	Missing	Youth	Female	{Red,Blue}	{Fall}	Vests	Large	{Post-1920s,1750s-1800s}	{"Not usable"}	151	Location 86	03/11/2025	\N	\N	\N	{}
109	Stylish Hat	Missing	Adult	Female	{Green}	{Winter}	Tops	X-Large	{1800s-1840s,1750s-1800s}	{"Not usable",Great}	124	Location 5	04/03/2024	\N	\N	Note 11	{}
110	Stylish Scarf	Available	Youth	Unisex	{Black,Blue}	{Spring}	Tops	Medium	{Pre-1700s,Post-1920s}	{"Needs repair","Needs washing"}	131	Location 94	12/20/2024	\N	\N	\N	{}
111	Vintage Scarf	Available	Youth	Female	{Purple,Brown}	{Winter,Spring}	Accessories	X-Large	{1800s-1840s,Post-1920s}	{"Needs dry cleaning"}	279	Location 68	05/07/2024	\N	\N	Note 39	{}
112	Stylish Vest	Available	Adult	Female	{Purple}	{Spring}	Accessories	Medium	{1750s-1800s,Post-1920s}	{Great,"Not usable"}	193	Location 24	09/08/2024	\N	\N	Note 45	{}
113	Vintage Boots	Available	Youth	Male	{Brown}	{Winter}	Gowns/dresses	Small	{1750s-1800s,1800s-1840s}	{Good}	57	Location 67	03/06/2024	\N	\N	\N	{}
114	Modern Sweater	Available	Youth	Female	{Grey,Yellow}	{Summer,Winter}	Bottoms	Small	{1750s-1800s,Post-1920s}	{Great}	26	Location 100	07/15/2024	\N	\N	\N	{}
115	Vintage Jacket	Missing	Youth	Female	{Pink}	{Fall,Summer}	Tops	Large	{Pre-1700s,1750s-1800s}	{"Needs repair","Needs washing"}	82	Location 53	09/10/2024	\N	\N	Note 15	{}
116	Vintage Boots	Available	Adult	Unisex	{Brown,Green}	{Summer,Spring}	Shoes	Medium	{1800s-1840s,1750s-1800s}	{Great}	212	Location 34	01/24/2024	\N	\N	Note 6	{}
117	Elegant Skirt	Available	Youth	Male	{Red}	{Winter,Fall}	Socks/hose	Small	{Pre-1700s}	{"Needs washing",Great}	47	\N	08/19/2024	\N	\N	\N	{}
118	Elegant Boots	Missing	Youth	Male	{Brown,Orange}	{Winter,Spring}	Bottoms	Large	{Pre-1700s}	{"Needs repair",Great}	26	Location 87	02/26/2024	\N	\N	Note 46	{}
119	Trendy Scarf	Missing	Adult	Male	{Purple}	{Summer,Fall}	Tops	Small	{1800s-1840s}	{"Needs dry cleaning","Not usable"}	156	Location 37	01/30/2024	\N	\N	\N	{}
120	Classic Shirt	Available	Youth	Unisex	{Purple}	{Spring}	Tops	X-Large	{Post-1920s,Pre-1700s}	{"Not usable"}	67	Location 74	11/06/2024	\N	\N	\N	{}
121	Modern Boots	Available	Youth	Male	{White}	{Summer,Spring}	Gowns/dresses	Large	{Pre-1700s,1750s-1800s}	{"Needs washing"}	106	Location 97	02/21/2024	\N	\N	\N	{}
122	Modern Hat	Available	Adult	Male	{Green,Red}	{Fall,Summer}	Vests	Small	{Pre-1700s,1750s-1800s}	{"Needs repair"}	206	\N	04/04/2024	\N	\N	\N	{}
123	Vintage Coat	Missing	Adult	Male	{White,Pink}	{Winter}	Socks/hose	Small	{Pre-1700s,Post-1920s}	{Great}	25	\N	12/19/2024	\N	\N	\N	{}
124	Trendy Dress	Missing	Youth	Unisex	{Brown}	{Winter,Spring}	Socks/hose	Medium	{Post-1920s}	{Good}	80	\N	11/03/2024	\N	\N	\N	{}
125	Casual Scarf	Missing	Youth	Male	{Brown}	{Summer}	Shoes	Large	{1800s-1840s,1750s-1800s}	{"Needs dry cleaning","Needs washing"}	138	Location 55	03/18/2025	\N	\N	Note 23	{}
126	Vintage Dress	Missing	Youth	Unisex	{Black}	{Fall}	Accessories	Small	{Pre-1700s,1800s-1840s}	{"Not usable"}	76	Location 72	05/28/2024	\N	\N	Note 23	{}
127	Vintage Dress	Available	Youth	Female	{Green,Yellow}	{Summer}	Shoes	X-Large	{Pre-1700s,Post-1920s}	{Great,"Needs dry cleaning"}	229	Location 65	12/20/2024	\N	\N	\N	{}
128	Formal Pants	Missing	Youth	Female	{Purple,Green}	{Summer}	Tops	Medium	{Pre-1700s}	{"Needs repair","Not usable"}	214	Location 61	11/20/2024	\N	\N	\N	{}
129	Classic Coat	Missing	Youth	Unisex	{Brown}	{Summer,Winter}	Bottoms	X-Large	{Pre-1700s}	{Great}	77	Location 99	07/05/2024	\N	\N	Note 1	{}
130	Vintage Boots	Missing	Adult	Female	{Brown,Orange}	{Winter,Spring}	Gowns/dresses	Small	{Post-1920s}	{Good}	141	Location 59	10/24/2024	\N	\N	\N	{}
131	Modern Dress	Missing	Youth	Female	{Blue,Orange}	{Fall,Spring}	Bottoms	Medium	{Post-1920s,1800s-1840s}	{"Not usable"}	74	Location 95	05/22/2024	\N	\N	\N	{}
132	Stylish Hat	Available	Youth	Male	{Grey}	{Spring,Fall}	Gowns/dresses	X-Large	{Post-1920s}	{"Needs repair","Needs washing"}	300	\N	01/22/2025	\N	\N	\N	{}
133	Vintage Sweater	Available	Adult	Female	{Blue}	{Summer,Spring}	Outerwear	Small	{1750s-1800s}	{"Needs dry cleaning"}	217	Location 84	09/28/2024	\N	\N	\N	{}
134	Classic Sweater	Missing	Adult	Male	{Blue,Black}	{Summer}	Vests	X-Large	{1750s-1800s,1800s-1840s}	{Great,"Needs dry cleaning"}	66	Location 83	01/02/2025	\N	\N	Note 44	{}
135	Casual Vest	Available	Adult	Male	{Purple,Blue}	{Fall,Spring}	Socks/hose	Large	{Post-1920s}	{"Needs repair"}	274	Location 1	04/11/2024	\N	\N	Note 10	{}
136	Elegant Jacket	Available	Adult	Female	{Red}	{Winter}	Accessories	X-Large	{1750s-1800s}	{"Needs washing"}	160	\N	07/24/2024	\N	\N	\N	{}
137	Vintage Vest	Missing	Youth	Female	{Purple,Grey}	{Fall}	Socks/hose	X-Large	{Post-1920s}	{Good}	100	Location 43	03/24/2024	\N	\N	Note 26	{}
138	Vintage Hat	Missing	Youth	Female	{Black}	{Winter,Spring}	Socks/hose	X-Large	{Pre-1700s,Post-1920s}	{"Needs repair",Good}	136	\N	02/27/2025	\N	\N	Note 19	{}
139	Formal Skirt	Available	Adult	Unisex	{Red,Blue}	{Spring}	Outerwear	X-Large	{Pre-1700s,Post-1920s}	{Great}	85	Location 66	08/03/2024	\N	\N	\N	{}
140	Vintage Jacket	Available	Youth	Unisex	{Purple}	{Fall,Spring}	Gowns/dresses	Small	{1750s-1800s}	{Great,"Needs washing"}	278	Location 45	09/13/2024	\N	\N	\N	{}
141	Elegant Skirt	Missing	Adult	Male	{Blue}	{Spring,Winter}	Vests	Medium	{1800s-1840s,1750s-1800s}	{Good}	171	Location 33	01/24/2024	\N	\N	\N	{}
142	Elegant Dress	Available	Adult	Male	{White,Orange}	{Fall,Spring}	Outerwear	Small	{Pre-1700s}	{"Needs repair",Great}	278	Location 31	02/26/2025	\N	\N	\N	{}
143	Formal Dress	Available	Adult	Unisex	{Green,Blue}	{Spring}	Shoes	Medium	{Post-1920s,Pre-1700s}	{Good}	161	Location 74	02/07/2024	\N	\N	Note 42	{}
144	Modern Coat	Missing	Adult	Unisex	{Yellow,Black}	{Fall,Spring}	Outerwear	Medium	{1800s-1840s}	{"Needs repair"}	56	Location 76	08/09/2024	\N	\N	\N	{}
145	Casual Vest	Missing	Youth	Unisex	{White}	{Winter,Fall}	Tops	Small	{Post-1920s,1800s-1840s}	{Good}	27	Location 22	03/20/2024	\N	\N	\N	{}
146	Formal Pants	Missing	Youth	Male	{Blue}	{Winter,Summer}	Bottoms	X-Large	{Pre-1700s,1750s-1800s}	{"Needs washing","Needs dry cleaning"}	60	Location 58	04/26/2024	\N	\N	\N	{}
147	Stylish Vest	Available	Adult	Unisex	{Pink}	{Summer}	Socks/hose	Medium	{1800s-1840s,Post-1920s}	{Good,Great}	188	Location 18	02/13/2024	\N	\N	\N	{}
148	Trendy Scarf	Missing	Adult	Male	{Grey,Yellow}	{Spring,Winter}	Socks/hose	Medium	{1750s-1800s,Post-1920s}	{Good,Great}	255	Location 11	03/13/2024	\N	\N	\N	{}
149	Stylish Boots	Missing	Youth	Unisex	{Yellow,Brown}	{Winter}	Tops	Large	{1750s-1800s}	{"Needs washing","Not usable"}	144	\N	06/03/2024	\N	\N	Note 8	{}
150	Vintage Pants	Available	Youth	Female	{Pink}	{Spring}	Tops	Large	{Pre-1700s}	{"Needs dry cleaning"}	250	Location 11	11/09/2024	\N	\N	\N	{}
151	Classic Pants	Missing	Adult	Female	{White}	{Winter}	Shoes	X-Large	{Post-1920s}	{"Needs dry cleaning","Needs repair"}	167	Location 80	03/13/2024	\N	\N	\N	{}
152	Elegant Skirt	Available	Youth	Male	{Black}	{Winter}	Bottoms	Large	{Post-1920s,1800s-1840s}	{Great,"Needs repair"}	276	Location 7	01/08/2024	\N	\N	Note 25	{}
153	Modern Pants	Missing	Adult	Unisex	{Purple}	{Winter,Spring}	Vests	X-Large	{1750s-1800s}	{Great,"Needs washing"}	181	Location 63	02/19/2025	\N	\N	Note 6	{}
154	Trendy Coat	Missing	Adult	Male	{Blue}	{Summer,Fall}	Outerwear	Small	{Pre-1700s,Post-1920s}	{"Not usable"}	228	\N	01/18/2025	\N	\N	Note 8	{}
155	Elegant Skirt	Missing	Adult	Unisex	{Red}	{Summer}	Shoes	Small	{Pre-1700s}	{"Needs dry cleaning","Needs repair"}	287	Location 7	08/28/2024	\N	\N	Note 12	{}
156	Stylish Coat	Missing	Adult	Unisex	{Orange}	{Fall}	Outerwear	X-Large	{1800s-1840s,Post-1920s}	{"Needs repair","Needs washing"}	196	Location 35	09/17/2024	\N	\N	Note 37	{}
157	Modern Pants	Available	Adult	Unisex	{Pink,Blue}	{Winter}	Accessories	Small	{1800s-1840s,Post-1920s}	{"Not usable"}	109	\N	05/06/2024	\N	\N	\N	{}
158	Classic Scarf	Available	Youth	Unisex	{Brown,Yellow}	{Fall}	Shoes	Small	{1800s-1840s,1750s-1800s}	{Good,"Needs repair"}	119	\N	02/17/2025	\N	\N	\N	{}
159	Stylish Hat	Available	Adult	Unisex	{Green,Grey}	{Fall}	Bottoms	X-Large	{1800s-1840s,Post-1920s}	{Great}	213	\N	02/06/2025	\N	\N	\N	{}
160	Elegant Dress	Missing	Adult	Unisex	{Brown}	{Spring}	Accessories	X-Large	{Post-1920s}	{Good}	223	Location 71	09/10/2024	\N	\N	\N	{}
161	Trendy Pants	Available	Adult	Unisex	{Black,Brown}	{Summer,Winter}	Tops	Medium	{Pre-1700s,1750s-1800s}	{"Needs washing","Needs dry cleaning"}	292	Location 100	03/19/2024	\N	\N	\N	{}
162	Vintage Scarf	Available	Youth	Male	{Orange,Brown}	{Summer,Winter}	Accessories	Medium	{Pre-1700s}	{"Needs washing"}	71	Location 56	06/26/2024	\N	\N	\N	{}
163	Formal Sweater	Available	Youth	Unisex	{Green,Brown}	{Winter}	Shoes	Small	{Pre-1700s,1750s-1800s}	{"Not usable"}	135	Location 90	12/05/2024	\N	\N	Note 50	{}
164	Vintage Scarf	Missing	Youth	Unisex	{Blue}	{Winter,Fall}	Shoes	Large	{1750s-1800s,Post-1920s}	{"Needs dry cleaning",Good}	135	\N	12/24/2024	\N	\N	\N	{}
165	Trendy Skirt	Missing	Youth	Male	{Purple}	{Winter,Fall}	Bottoms	X-Large	{1750s-1800s}	{"Needs dry cleaning"}	262	\N	04/30/2024	\N	\N	Note 30	{}
166	Elegant Shirt	Available	Youth	Unisex	{Brown,Orange}	{Winter,Summer}	Bottoms	Medium	{Post-1920s,1800s-1840s}	{"Not usable"}	25	Location 90	07/14/2024	\N	\N	Note 6	{}
167	Stylish Jacket	Missing	Adult	Female	{Green,Brown}	{Spring,Winter}	Socks/hose	Medium	{Post-1920s,Pre-1700s}	{Good,"Needs washing"}	136	\N	02/24/2025	\N	\N	\N	{}
168	Elegant Sweater	Missing	Youth	Male	{Brown,Black}	{Spring}	Tops	Large	{1800s-1840s,1750s-1800s}	{"Needs washing","Needs dry cleaning"}	85	\N	01/30/2024	\N	\N	\N	{}
169	Trendy Hat	Missing	Youth	Male	{Brown,Yellow}	{Spring,Summer}	Gowns/dresses	Large	{Pre-1700s}	{"Needs dry cleaning","Needs repair"}	167	Location 93	02/18/2024	\N	\N	\N	{}
170	Modern Dress	Available	Adult	Female	{Brown,Green}	{Summer,Fall}	Tops	Large	{1800s-1840s,Pre-1700s}	{Good}	284	Location 25	02/06/2025	\N	\N	Note 35	{}
171	Stylish Dress	Available	Youth	Unisex	{Pink,White}	{Spring}	Bottoms	X-Large	{Pre-1700s}	{"Needs washing"}	81	\N	06/02/2024	\N	\N	\N	{}
172	Modern Shirt	Missing	Adult	Unisex	{Brown,Red}	{Winter}	Outerwear	X-Large	{1800s-1840s}	{"Needs repair","Needs dry cleaning"}	23	Location 3	08/25/2024	\N	\N	Note 50	{}
173	Casual Coat	Missing	Youth	Male	{White}	{Spring}	Accessories	X-Large	{1800s-1840s}	{Great,Good}	134	Location 62	03/03/2025	\N	\N	Note 12	{}
174	Casual Sweater	Missing	Adult	Female	{Blue,Red}	{Winter,Fall}	Accessories	Medium	{1750s-1800s,Pre-1700s}	{"Needs repair"}	216	Location 25	03/01/2024	\N	\N	Note 49	{}
175	Elegant Hat	Available	Adult	Unisex	{Yellow,Blue}	{Spring}	Outerwear	Large	{Pre-1700s,Post-1920s}	{"Needs washing"}	163	Location 6	03/24/2024	\N	\N	Note 26	{}
176	Elegant Pants	Missing	Youth	Female	{Green,White}	{Winter,Spring}	Vests	X-Large	{Pre-1700s,1800s-1840s}	{"Not usable","Needs repair"}	33	Location 3	01/11/2025	\N	\N	Note 49	{}
177	Stylish Dress	Missing	Youth	Female	{Grey}	{Fall}	Gowns/dresses	X-Large	{1750s-1800s}	{"Not usable","Needs repair"}	204	Location 64	05/02/2024	\N	\N	\N	{}
178	Classic Shirt	Available	Adult	Male	{Red}	{Winter}	Outerwear	X-Large	{Post-1920s,Pre-1700s}	{Great}	19	\N	07/25/2024	\N	\N	\N	{}
179	Modern Skirt	Available	Youth	Male	{Orange}	{Summer}	Vests	Large	{Post-1920s}	{"Not usable",Great}	193	Location 9	02/23/2025	\N	\N	\N	{}
180	Trendy Dress	Available	Adult	Unisex	{Brown,Purple}	{Winter}	Shoes	Small	{Pre-1700s,1800s-1840s}	{"Needs dry cleaning"}	28	Location 19	03/23/2025	\N	\N	\N	{}
181	Classic Scarf	Missing	Youth	Male	{White}	{Fall,Summer}	Socks/hose	Medium	{Post-1920s}	{"Needs repair","Not usable"}	129	Location 60	01/01/2025	\N	\N	Note 40	{}
182	Classic Shirt	Missing	Youth	Unisex	{Black,Red}	{Spring}	Vests	Medium	{1800s-1840s,1750s-1800s}	{"Needs washing"}	39	\N	08/05/2024	\N	\N	\N	{}
183	Stylish Scarf	Missing	Adult	Male	{Blue}	{Summer,Spring}	Vests	Large	{1800s-1840s,Pre-1700s}	{Good}	130	Location 5	04/09/2024	\N	\N	\N	{}
185	Classic Coat	Missing	Adult	Female	{Yellow,White}	{Summer}	Shoes	Medium	{1750s-1800s,Post-1920s}	{"Needs dry cleaning"}	214	Location 22	12/12/2024	\N	\N	\N	{}
186	Classic Boots	Available	Adult	Unisex	{Brown,Black}	{Fall,Spring}	Outerwear	Small	{1800s-1840s}	{"Not usable",Great}	276	\N	01/06/2025	\N	\N	\N	{}
187	Stylish Pants	Available	Adult	Female	{Orange,Red}	{Summer}	Bottoms	Small	{Post-1920s}	{"Needs washing",Great}	83	\N	02/27/2025	\N	\N	Note 2	{}
188	Formal Hat	Available	Youth	Female	{Brown}	{Spring}	Gowns/dresses	X-Large	{Post-1920s,Pre-1700s}	{Great,"Needs repair"}	73	Location 86	12/16/2024	\N	\N	\N	{}
189	Vintage Boots	Missing	Youth	Male	{Pink}	{Spring}	Shoes	Large	{Pre-1700s,1800s-1840s}	{Good,"Not usable"}	102	Location 51	05/26/2024	\N	\N	Note 12	{}
190	Vintage Pants	Missing	Youth	Male	{Yellow}	{Summer}	Bottoms	Large	{Post-1920s}	{Great}	76	Location 15	09/17/2024	\N	\N	Note 4	{}
191	Casual Boots	Available	Youth	Male	{Blue}	{Spring,Winter}	Outerwear	Large	{Pre-1700s}	{"Needs dry cleaning","Needs washing"}	185	\N	01/03/2025	\N	\N	\N	{}
192	Elegant Boots	Available	Adult	Unisex	{Orange}	{Spring}	Vests	Medium	{1750s-1800s}	{"Needs repair"}	69	Location 14	10/18/2024	\N	\N	\N	{}
193	Formal Pants	Available	Youth	Female	{Yellow}	{Spring,Summer}	Outerwear	X-Large	{Post-1920s}	{Great,"Needs repair"}	33	Location 83	12/10/2024	\N	\N	Note 21	{}
194	Classic Boots	Available	Adult	Female	{Brown,Red}	{Fall,Spring}	Socks/hose	Small	{1750s-1800s,1800s-1840s}	{Good,"Needs dry cleaning"}	190	Location 32	02/18/2025	\N	\N	\N	{}
195	Classic Skirt	Missing	Adult	Unisex	{Pink,Yellow}	{Winter}	Shoes	Medium	{Pre-1700s}	{"Needs repair"}	96	\N	06/30/2024	\N	\N	\N	{}
196	Vintage Coat	Missing	Youth	Female	{Purple,Red}	{Summer,Spring}	Tops	Small	{1750s-1800s,Pre-1700s}	{"Needs dry cleaning"}	40	\N	04/08/2024	\N	\N	Note 50	{}
201	dasda	Borrowed	Youth	Male	{Green}	{Winter}	Outerwear	Small	{1750s-1800s}	{"Needs repair"}	\N	\N	04/18/2025	11	\N	aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadasd	{}
200	Vintage Jacket	Borrowed	Youth	Male	{White}	{Spring,Winter}	Bottoms	Small	{1750s-1800s,Post-1920s}	{Great}	58	Location 4	03/02/2025	11	\N	\N	{}
99	Vintage Coat	Available	Adult	Male	{Red,Pink}	{Spring,Winter}	Gowns/dresses	Small	{Post-1920s,1750s-1800s}	{"Not usable","Needs dry cleaning"}	15	Location 52	12/01/2024	\N	\N	\N	{}
197	Casual Jacket	Missing	Youth	Unisex	{Pink}	{Fall,Summer}	Socks/hose	Medium	{Pre-1700s,Post-1920s}	{"Needs washing",Good}	264	Location 37	01/15/2025	11	\N	\N	{}
198	Stylish Coat	Available	Adult	Unisex	{Purple}	{Summer}	Outerwear	Medium	{Pre-1700s}	{"Needs dry cleaning"}	164	Location 94	01/10/2024	\N	\N	Note 14	{}
204	we talking hype	Available	Adult	Male	{Blue,Brown}	{Spring,Fall}	Tops	Large	{Post-1920s}	{Great}	\N	\N	04/20/2025	\N	\N	delete later	{4c203e94-7264-4236-9787-54b10ebf254d,040dbed1-0f49-4574-8860-fdb91f303693}
199	Formal Dress	Available	Adult	Male	{Yellow}	{Spring}	Vests	Medium	{Pre-1700s,1750s-1800s}	{"Not usable",Good}	78	Location 61	01/21/2025	\N	\N	Note 43	{}
205	test	Available	Adult	Male	{Purple,Brown}	{Fall}	Accessories	Medium	{Pre-1700s}	{Great}	\N	\N	04/20/2025	\N	\N	\N	{5697b45f-79f3-4f14-bebd-59a73d533021,689de2e6-869d-4cec-9b4e-630727611197}
5	Classic Jacket	Available	Youth	Female	{Black}	{Winter}	Gowns/dresses	X-Large	{1750s-1800s,1800s-1840s}	{"Needs dry cleaning","Needs washing"}	158	Location 54	12/27/2024	9	\N	\N	{}
203	Peter's Test	Available	Adult	Male	{Brown,Pink}	{Spring}	Gowns/dresses	Medium	{Post-1920s,Pre-1700s}	{Good,"Not usable"}	4000	JCC	04/20/2025	\N	\N	Testing this works	{}
207	hype	Available	Adult	Male	{Purple}	{Winter}	Accessories	Medium	{1750s-1800s}	{Good}	12	\N	04/20/2025	\N	\N	\N	{0f118eeb-2e4d-432f-98bf-c25ae0d3a808}
208	sda	Available	Youth	Male	{Gray}	{Winter}	Bottoms	Medium	{Pre-1700s}	{"Not usable"}	\N	\N	04/20/2025	\N	\N	das	{8a854cd2-fc74-4f0e-815e-c210b33a35d5}
3	Trendy Vest	Borrowed	Youth	Male	{Purple}	{Spring}	Shoes	Large	{Post-1920s,Pre-1700s}	{Good}	66	Location 71	06/07/2024	9	\N	Note 1	{}
202	two phones	Missing	Adult	Male	{Purple}	{Winter}	Accessories	Medium	{1750s-1800s}	{"Not usable"}	728	\N	04/18/2025	\N	\N	asdfjnkansjkdfnjk	{1c97ad78-51b0-46f0-9a36-95d5f2b0152f,176cbbbc-ac4b-4748-ab50-c6b9b56920cf}
206	dsa	Available	Youth	Male	{Blue,Purple}	{Fall}	Outerwear	Small	{Pre-1700s}	{Great}	\N	\N	04/20/2025	\N	\N	\N	{c3ca5937-fd3e-4902-b598-066cab919cc6}
210	sticks	Available	Youth	Male	{Green}	{Fall}	Outerwear	Small	{1750s-1800s}	{"Needs washing"}	\N	\N	04/20/2025	\N	\N	sda	{fd3a771a-b05e-4c07-a237-3588b91c1f90}
211	two test	Available	Adult	Male	{Green}	{Fall}	Bottoms	Medium	{1750s-1800s}	{Great}	\N	\N	04/20/2025	\N	\N	das	{0ab088d1-025c-4a1d-970f-31e623aca8af,e371dd0a-b3ff-41fb-881d-e1de24b9780c}
209	big test 2	Available	Adult	Male	{Brown}	{Winter}	Outerwear	Small	{Pre-1700s}	{"Not usable"}	\N	\N	04/20/2025	\N	\N	asd	{bfdfd7be-7ffd-4c3b-8b93-d7ca3b244c8d}
212	Demo image	Missing	Youth	Male	{Yellow,Green}	{Winter}	Outerwear	Small	{Pre-1700s,1750s-1800s}	{Good}	200	\N	04/22/2025	\N	\N	write whatever	{398cccca-5fb8-478d-8e14-2727d0bae618}
184	Trendy Coat	Available	Youth	Unisex	{Blue}	{Winter}	Shoes	Medium	{1750s-1800s}	{"Not usable"}	107	Location 72	06/14/2024	\N	\N	\N	{}
220	aaaa	Available	Youth	Male	{Pink}	{Winter}	Gowns/dresses	Medium	{Post-1920s}	{"Needs dry cleaning"}	1	\N	05/14/2025	\N	\N	1	{e3a1f1e9-4537-487b-83fc-5794dbc47789}
10	cs40	Borrowed	Adult	Male	{White,Gray}	{Fall}	Gowns/dresses	Medium	{"1750s - 1800s",Pre-1700s}	{Great}	22	\N	04/30/2025	9	\N	hi hi	{69ad2b30-3d07-48b9-9d62-01e60cfd52ef}
214	bonnet and dress	Available	Youth	Female	{Red}	{Spring,Fall}	Gowns/dresses	Medium	{1750s-1800s}	{Great}	15	\N	05/06/2025	\N	\N	\N	{d9378392-f774-404c-a407-07891ab8ab4e,5c38c9a4-c37c-4659-b408-abc3691b6fbd}
221	jc	Available	Youth	Male	{Yellow}	{Fall}	Gowns/dresses	Small	{Post-1920s}	{"Needs repair"}	\N	\N	05/14/2025	\N	\N	111	{75b3a972-2a76-426e-99a1-2107513f240c}
222	aa	Available	Youth	Male	{Yellow}	{Fall}	Gowns/dresses	Small	{Post-1920s}	{"Needs washing"}	99	\N	05/14/2025	\N	\N	aa	{111bc900-f6c7-4857-94a5-2c2f3df4048d}
215	new images	Available	Adult	Male	{Green,Brown}	{Winter}	Outerwear	Medium	{1800s-1840s}	{"Needs washing"}	2134	\N	05/11/2025	\N	\N	asdfjknasjdfnjkasdf	{9762ec3d-13b4-4510-b8d2-e1cc68012a81}
216	jumbocode	Available	Youth	Male	{Purple}	{Winter}	Outerwear	Small	{Pre-1700s}	{"Not usable"}	89	\N	05/14/2025	\N	\N	hi there	{873f82f6-26c8-4b56-929c-084f33ce997a,63dde262-dc60-4c92-b5a5-933f07494f85}
217	another one	Available	Youth	Male	{Brown}	{Fall}	Outerwear	Small	{Post-1920s}	{"Not usable"}	\N	\N	05/14/2025	\N	\N	sup	{2b4db593-4904-42e5-b9a5-7d096ef6dea8}
218	anotha	Available	Youth	Male	{Green}	{Winter}	Outerwear	Small	{1750s-1800s}	{"Not usable"}	1	\N	05/14/2025	\N	\N	hmmm	{9ac20034-5874-40f4-9cbe-10743b936b77}
219	hmmm	Available	Youth	Male	{Gray}	{Fall}	Outerwear	Small	{1750s-1800s}	{"Needs dry cleaning"}	\N	\N	05/14/2025	\N	\N	trying again	{ef9cea49-ad07-417d-b5a6-8142ea6209f1}
223	eric bruh	Available	Youth	Male	{Green}	{Fall}	Gowns/dresses	Small	{Post-1920s}	{"Needs washing"}	56	golf course	05/15/2025	\N	\N	hello	{98522be6-dc4d-4f08-95e4-177d54a3786a}
52	Modern Boots	Borrowed	Adult	Male	{Yellow}	{Spring}	Gowns/dresses	X-Large	{Pre-1700s,1800s-1840s}	{Good,"Needs dry cleaning"}	258	\N	06/04/2024	9	\N	Note 5	{}
213	Dress	Available	Youth	Male	{Purple}	{Fall}	Outerwear	Small	{Pre-1700s}	{"Not usable"}	9032	\N	04/30/2025	\N	\N	sdad	{ed6183c0-2669-4820-8817-aa1fd442fd12}
\.


--
-- Name: borrowers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.borrowers_id_seq', 40, true);


--
-- Name: borrows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.borrows_id_seq', 39, true);


--
-- Name: items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.items_id_seq', 200, true);


--
-- Name: borrowers borrowers_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.borrowers
    ADD CONSTRAINT borrowers_email_key UNIQUE (email);


--
-- Name: borrowers borrowers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.borrowers
    ADD CONSTRAINT borrowers_pkey PRIMARY KEY (id);


--
-- Name: borrows borrows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.borrows
    ADD CONSTRAINT borrows_pkey PRIMARY KEY (id);


--
-- Name: dummy_data items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dummy_data
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: borrows borrows_borrower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.borrows
    ADD CONSTRAINT borrows_borrower_id_fkey FOREIGN KEY (borrower_id) REFERENCES public.borrowers(id) ON DELETE CASCADE;


--
-- Name: borrows borrows_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.borrows
    ADD CONSTRAINT borrows_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.dummy_data(id) ON DELETE CASCADE;


--
-- Name: dummy_data items_current_borrower_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dummy_data
    ADD CONSTRAINT items_current_borrower_fkey FOREIGN KEY (current_borrower) REFERENCES public.borrowers(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

