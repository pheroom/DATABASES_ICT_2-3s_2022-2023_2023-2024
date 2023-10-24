--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

-- Started on 2023-10-24 15:38:47

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

--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16492)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id integer NOT NULL,
    name character varying(50),
    passportid character varying(10),
    phonenumber character varying(11),
    email character varying(100),
    address character varying(100),
    CONSTRAINT client_email_check CHECK (((email)::text ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'::text)),
    CONSTRAINT client_passportid_check CHECK (((passportid)::text ~ '^[0-9]{10}$'::text)),
    CONSTRAINT client_phonenumber_check CHECK (((phonenumber)::text ~ '^[0-9]{11}$'::text))
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16491)
-- Name: client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_id_seq OWNER TO postgres;

--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 216
-- Name: client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id;


--
-- TOC entry 230 (class 1259 OID 16592)
-- Name: credit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credit (
    id integer NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(30) NOT NULL,
    minimumamount integer NOT NULL,
    interestrate real NOT NULL,
    CONSTRAINT credit_minimumamount_check CHECK ((minimumamount > 0))
);


ALTER TABLE public.credit OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16600)
-- Name: credit_agreement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credit_agreement (
    id integer NOT NULL,
    currencyid integer NOT NULL,
    creditid integer NOT NULL,
    employeeid integer NOT NULL,
    clientid integer NOT NULL,
    dayofaccrual integer NOT NULL,
    plannedclosingdate date NOT NULL,
    interestamount integer DEFAULT 0,
    currentdebt integer NOT NULL,
    initialamount integer NOT NULL,
    dateofopening date NOT NULL,
    dateofclosing date,
    CONSTRAINT credit_agreement_dayofaccrual_check CHECK (((dayofaccrual > 0) AND (dayofaccrual < 29)))
);


ALTER TABLE public.credit_agreement OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16599)
-- Name: credit_agreement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.credit_agreement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.credit_agreement_id_seq OWNER TO postgres;

--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 231
-- Name: credit_agreement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.credit_agreement_id_seq OWNED BY public.credit_agreement.id;


--
-- TOC entry 229 (class 1259 OID 16591)
-- Name: credit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.credit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.credit_id_seq OWNER TO postgres;

--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 229
-- Name: credit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.credit_id_seq OWNED BY public.credit.id;


--
-- TOC entry 233 (class 1259 OID 16628)
-- Name: credit_payment_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credit_payment_schedule (
    creditagreementid integer NOT NULL,
    plannedpaymentdate date NOT NULL,
    actualpaymentdate date,
    interestpayment integer,
    creditpayment integer
);


ALTER TABLE public.credit_payment_schedule OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16527)
-- Name: currency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.currency (
    id integer NOT NULL,
    name character varying(30)
);


ALTER TABLE public.currency OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16526)
-- Name: currency_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.currency_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.currency_id_seq OWNER TO postgres;

--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 222
-- Name: currency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.currency_id_seq OWNED BY public.currency.id;


--
-- TOC entry 225 (class 1259 OID 16534)
-- Name: deposit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deposit (
    id integer NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(30) NOT NULL,
    minimumamount integer NOT NULL,
    interestrate real NOT NULL,
    CONSTRAINT deposit_minimumamount_check CHECK ((minimumamount > 0))
);


ALTER TABLE public.deposit OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16543)
-- Name: deposit_agreement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deposit_agreement (
    id integer NOT NULL,
    currencyid integer NOT NULL,
    depositid integer NOT NULL,
    employeeid integer NOT NULL,
    clientid integer NOT NULL,
    dayofaccrual integer NOT NULL,
    plannedclosingdate date NOT NULL,
    amountofpayments integer DEFAULT 0,
    initialamount integer NOT NULL,
    dateofopening date NOT NULL,
    dateofclosing date,
    CONSTRAINT deposit_agreement_dayofaccrual_check CHECK (((dayofaccrual > 0) AND (dayofaccrual < 29)))
);


ALTER TABLE public.deposit_agreement OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16542)
-- Name: deposit_agreement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deposit_agreement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.deposit_agreement_id_seq OWNER TO postgres;

--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 226
-- Name: deposit_agreement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deposit_agreement_id_seq OWNED BY public.deposit_agreement.id;


--
-- TOC entry 224 (class 1259 OID 16533)
-- Name: deposit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deposit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.deposit_id_seq OWNER TO postgres;

--
-- TOC entry 4957 (class 0 OID 0)
-- Dependencies: 224
-- Name: deposit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deposit_id_seq OWNED BY public.deposit.id;


--
-- TOC entry 228 (class 1259 OID 16581)
-- Name: deposit_payment_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deposit_payment_schedule (
    depositagreementid integer NOT NULL,
    plannedpaymentdate date NOT NULL,
    actualpaymentdate date,
    paymentamount integer
);


ALTER TABLE public.deposit_payment_schedule OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16510)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    id integer NOT NULL,
    name character varying(50),
    passportid character varying(10),
    phonenumber character varying(11),
    email character varying(100),
    address character varying(100),
    dateofbirth character varying(10),
    salary integer,
    categoryid integer,
    CONSTRAINT employee_email_check CHECK (((email)::text ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'::text)),
    CONSTRAINT employee_passportid_check CHECK (((passportid)::text ~ '^[0-9]{10}$'::text)),
    CONSTRAINT employee_phonenumber_check CHECK (((phonenumber)::text ~ '^[0-9]{11}$'::text)),
    CONSTRAINT employee_salary_check CHECK ((salary > 0))
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16502)
-- Name: employee_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_category (
    id integer NOT NULL,
    description character varying(200),
    salary integer,
    name character varying(30),
    CONSTRAINT employee_category_salary_check CHECK ((salary > 0))
);


ALTER TABLE public.employee_category OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16501)
-- Name: employee_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employee_category_id_seq OWNER TO postgres;

--
-- TOC entry 4958 (class 0 OID 0)
-- Dependencies: 218
-- Name: employee_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_category_id_seq OWNED BY public.employee_category.id;


--
-- TOC entry 220 (class 1259 OID 16509)
-- Name: employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employee_id_seq OWNER TO postgres;

--
-- TOC entry 4959 (class 0 OID 0)
-- Dependencies: 220
-- Name: employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_id_seq OWNED BY public.employee.id;


--
-- TOC entry 4732 (class 2604 OID 16495)
-- Name: client id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN id SET DEFAULT nextval('public.client_id_seq'::regclass);


--
-- TOC entry 4739 (class 2604 OID 16595)
-- Name: credit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit ALTER COLUMN id SET DEFAULT nextval('public.credit_id_seq'::regclass);


--
-- TOC entry 4740 (class 2604 OID 16603)
-- Name: credit_agreement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_agreement ALTER COLUMN id SET DEFAULT nextval('public.credit_agreement_id_seq'::regclass);


--
-- TOC entry 4735 (class 2604 OID 16530)
-- Name: currency id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currency ALTER COLUMN id SET DEFAULT nextval('public.currency_id_seq'::regclass);


--
-- TOC entry 4736 (class 2604 OID 16537)
-- Name: deposit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposit ALTER COLUMN id SET DEFAULT nextval('public.deposit_id_seq'::regclass);


--
-- TOC entry 4737 (class 2604 OID 16546)
-- Name: deposit_agreement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposit_agreement ALTER COLUMN id SET DEFAULT nextval('public.deposit_agreement_id_seq'::regclass);


--
-- TOC entry 4734 (class 2604 OID 16513)
-- Name: employee id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee ALTER COLUMN id SET DEFAULT nextval('public.employee_id_seq'::regclass);


--
-- TOC entry 4733 (class 2604 OID 16505)
-- Name: employee_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_category ALTER COLUMN id SET DEFAULT nextval('public.employee_category_id_seq'::regclass);


--
-- TOC entry 4929 (class 0 OID 16492)
-- Dependencies: 217
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, name, passportid, phonenumber, email, address) FROM stdin;
3	Михаил Дмитриевич Прохоров	1914323849	72298165946	prohorovm79@mail.ru	Сочи, Параллельная ул., 9/2
4	Леонид Арнольдович Федун	2809346819	78843693164	fedunleonid@mail.ru	Выборг, Ленинградское ш., 45Б
\.


--
-- TOC entry 4942 (class 0 OID 16592)
-- Dependencies: 230
-- Data for Name: credit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credit (id, description, name, minimumamount, interestrate) FROM stdin;
1	От 21 года на дату получения кредита	Автокредит наличными	10000	4.7
2	От 21 года на дату получения кредита, общий стаж работы не менее 3 лет	Под залог недвижимости	50000	16
\.


--
-- TOC entry 4944 (class 0 OID 16600)
-- Dependencies: 232
-- Data for Name: credit_agreement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credit_agreement (id, currencyid, creditid, employeeid, clientid, dayofaccrual, plannedclosingdate, interestamount, currentdebt, initialamount, dateofopening, dateofclosing) FROM stdin;
1	2	1	7	3	25	2024-10-24	0	56000	60000	2023-10-24	\N
2	2	2	7	3	12	2023-12-12	5000	20000	55000	2023-03-12	\N
\.


--
-- TOC entry 4945 (class 0 OID 16628)
-- Dependencies: 233
-- Data for Name: credit_payment_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credit_payment_schedule (creditagreementid, plannedpaymentdate, actualpaymentdate, interestpayment, creditpayment) FROM stdin;
1	2023-11-25	\N	560	5600
\.


--
-- TOC entry 4935 (class 0 OID 16527)
-- Dependencies: 223
-- Data for Name: currency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.currency (id, name) FROM stdin;
2	rub
\.


--
-- TOC entry 4937 (class 0 OID 16534)
-- Dependencies: 225
-- Data for Name: deposit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deposit (id, description, name, minimumamount, interestrate) FROM stdin;
\.


--
-- TOC entry 4939 (class 0 OID 16543)
-- Dependencies: 227
-- Data for Name: deposit_agreement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deposit_agreement (id, currencyid, depositid, employeeid, clientid, dayofaccrual, plannedclosingdate, amountofpayments, initialamount, dateofopening, dateofclosing) FROM stdin;
\.


--
-- TOC entry 4940 (class 0 OID 16581)
-- Dependencies: 228
-- Data for Name: deposit_payment_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deposit_payment_schedule (depositagreementid, plannedpaymentdate, actualpaymentdate, paymentamount) FROM stdin;
\.


--
-- TOC entry 4933 (class 0 OID 16510)
-- Dependencies: 221
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (id, name, passportid, phonenumber, email, address, dateofbirth, salary, categoryid) FROM stdin;
7	Игорь Викторович Макаров	1919385795	78843693165	markovbankir@bank.ru	Воронеж, ул. Карла Маркса, 67/2	12.05.1989	66500	2
\.


--
-- TOC entry 4931 (class 0 OID 16502)
-- Dependencies: 219
-- Data for Name: employee_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee_category (id, description, salary, name) FROM stdin;
2	Менеджер, руководящий банком и проводящий им финансовые операции	60000	Банкир
\.


--
-- TOC entry 4960 (class 0 OID 0)
-- Dependencies: 216
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_id_seq', 4, true);


--
-- TOC entry 4961 (class 0 OID 0)
-- Dependencies: 231
-- Name: credit_agreement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.credit_agreement_id_seq', 2, true);


--
-- TOC entry 4962 (class 0 OID 0)
-- Dependencies: 229
-- Name: credit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.credit_id_seq', 2, true);


--
-- TOC entry 4963 (class 0 OID 0)
-- Dependencies: 222
-- Name: currency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.currency_id_seq', 2, true);


--
-- TOC entry 4964 (class 0 OID 0)
-- Dependencies: 226
-- Name: deposit_agreement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deposit_agreement_id_seq', 1, false);


--
-- TOC entry 4965 (class 0 OID 0)
-- Dependencies: 224
-- Name: deposit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deposit_id_seq', 1, false);


--
-- TOC entry 4966 (class 0 OID 0)
-- Dependencies: 218
-- Name: employee_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_category_id_seq', 2, true);


--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 220
-- Name: employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_id_seq', 7, true);


--
-- TOC entry 4755 (class 2606 OID 16500)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- TOC entry 4771 (class 2606 OID 16607)
-- Name: credit_agreement credit_agreement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_agreement
    ADD CONSTRAINT credit_agreement_pkey PRIMARY KEY (id);


--
-- TOC entry 4773 (class 2606 OID 16632)
-- Name: credit_payment_schedule credit_payment_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_payment_schedule
    ADD CONSTRAINT credit_payment_schedule_pkey PRIMARY KEY (creditagreementid, plannedpaymentdate);


--
-- TOC entry 4769 (class 2606 OID 16598)
-- Name: credit credit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit
    ADD CONSTRAINT credit_pkey PRIMARY KEY (id);


--
-- TOC entry 4761 (class 2606 OID 16532)
-- Name: currency currency_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_pkey PRIMARY KEY (id);


--
-- TOC entry 4765 (class 2606 OID 16550)
-- Name: deposit_agreement deposit_agreement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposit_agreement
    ADD CONSTRAINT deposit_agreement_pkey PRIMARY KEY (id);


--
-- TOC entry 4767 (class 2606 OID 16585)
-- Name: deposit_payment_schedule deposit_payment_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposit_payment_schedule
    ADD CONSTRAINT deposit_payment_schedule_pkey PRIMARY KEY (depositagreementid, plannedpaymentdate);


--
-- TOC entry 4763 (class 2606 OID 16540)
-- Name: deposit deposit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposit
    ADD CONSTRAINT deposit_pkey PRIMARY KEY (id);


--
-- TOC entry 4757 (class 2606 OID 16508)
-- Name: employee_category employee_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_category
    ADD CONSTRAINT employee_category_pkey PRIMARY KEY (id);


--
-- TOC entry 4759 (class 2606 OID 16520)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);


--
-- TOC entry 4780 (class 2606 OID 16623)
-- Name: credit_agreement credit_agreement_clientid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_agreement
    ADD CONSTRAINT credit_agreement_clientid_fkey FOREIGN KEY (clientid) REFERENCES public.client(id);


--
-- TOC entry 4781 (class 2606 OID 16613)
-- Name: credit_agreement credit_agreement_creditid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_agreement
    ADD CONSTRAINT credit_agreement_creditid_fkey FOREIGN KEY (creditid) REFERENCES public.credit(id);


--
-- TOC entry 4782 (class 2606 OID 16608)
-- Name: credit_agreement credit_agreement_currencyid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_agreement
    ADD CONSTRAINT credit_agreement_currencyid_fkey FOREIGN KEY (currencyid) REFERENCES public.currency(id);


--
-- TOC entry 4783 (class 2606 OID 16618)
-- Name: credit_agreement credit_agreement_employeeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_agreement
    ADD CONSTRAINT credit_agreement_employeeid_fkey FOREIGN KEY (employeeid) REFERENCES public.employee(id);


--
-- TOC entry 4784 (class 2606 OID 16633)
-- Name: credit_payment_schedule credit_payment_schedule_creditagreementid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_payment_schedule
    ADD CONSTRAINT credit_payment_schedule_creditagreementid_fkey FOREIGN KEY (creditagreementid) REFERENCES public.credit_agreement(id);


--
-- TOC entry 4775 (class 2606 OID 16566)
-- Name: deposit_agreement deposit_agreement_clientid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposit_agreement
    ADD CONSTRAINT deposit_agreement_clientid_fkey FOREIGN KEY (clientid) REFERENCES public.client(id);


--
-- TOC entry 4776 (class 2606 OID 16551)
-- Name: deposit_agreement deposit_agreement_currencyid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposit_agreement
    ADD CONSTRAINT deposit_agreement_currencyid_fkey FOREIGN KEY (currencyid) REFERENCES public.currency(id);


--
-- TOC entry 4777 (class 2606 OID 16556)
-- Name: deposit_agreement deposit_agreement_depositid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposit_agreement
    ADD CONSTRAINT deposit_agreement_depositid_fkey FOREIGN KEY (depositid) REFERENCES public.deposit(id);


--
-- TOC entry 4778 (class 2606 OID 16561)
-- Name: deposit_agreement deposit_agreement_employeeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposit_agreement
    ADD CONSTRAINT deposit_agreement_employeeid_fkey FOREIGN KEY (employeeid) REFERENCES public.employee(id);


--
-- TOC entry 4779 (class 2606 OID 16586)
-- Name: deposit_payment_schedule deposit_payment_schedule_depositagreementid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposit_payment_schedule
    ADD CONSTRAINT deposit_payment_schedule_depositagreementid_fkey FOREIGN KEY (depositagreementid) REFERENCES public.deposit_agreement(id);


--
-- TOC entry 4774 (class 2606 OID 16521)
-- Name: employee employee_categoryid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_categoryid_fkey FOREIGN KEY (categoryid) REFERENCES public.employee_category(id);


-- Completed on 2023-10-24 15:38:47

--
-- PostgreSQL database dump complete
--

