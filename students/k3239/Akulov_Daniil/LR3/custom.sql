PGDMP                  
    {            postgres    16.0    16.0 Z    d           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            e           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            f           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            g           1262    5    postgres    DATABASE     |   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE postgres;
                postgres    false            h           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    4967                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            i           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1259    16492    client    TABLE     �  CREATE TABLE public.client (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    passportid character varying(10) NOT NULL,
    phonenumber character varying(11) NOT NULL,
    email character varying(100) NOT NULL,
    address character varying(100) NOT NULL,
    CONSTRAINT client_email_check CHECK (((email)::text ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'::text)),
    CONSTRAINT client_passportid_check CHECK (((passportid)::text ~ '^[0-9]{10}$'::text)),
    CONSTRAINT client_phonenumber_check CHECK (((phonenumber)::text ~ '^[0-9]{11}$'::text))
);
    DROP TABLE public.client;
       public         heap    postgres    false            �            1259    16491    client_id_seq    SEQUENCE     �   CREATE SEQUENCE public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.client_id_seq;
       public          postgres    false    217            j           0    0    client_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id;
          public          postgres    false    216            �            1259    24652    credit    TABLE     �  CREATE TABLE public.credit (
    id integer NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(30) NOT NULL,
    maximumamount numeric NOT NULL,
    interestrate real NOT NULL,
    CONSTRAINT credit_interestrate_check CHECK ((interestrate < (40)::double precision)),
    CONSTRAINT credit_maximumamount_check CHECK ((maximumamount > (0)::numeric))
);
    DROP TABLE public.credit;
       public         heap    postgres    false            �            1259    24675    credit_agreement    TABLE     N  CREATE TABLE public.credit_agreement (
    id integer NOT NULL,
    currencyid integer NOT NULL,
    creditid integer NOT NULL,
    employeeid integer NOT NULL,
    clientid integer NOT NULL,
    dayofaccrual integer NOT NULL,
    plannedclosingdate date NOT NULL,
    interestamount numeric DEFAULT 0,
    interestrate real NOT NULL,
    currentdebt numeric DEFAULT 0,
    initialamount numeric NOT NULL,
    dateofopening date NOT NULL,
    dateofclosing date,
    CONSTRAINT credit_agreement_check CHECK ((plannedclosingdate > dateofopening)),
    CONSTRAINT credit_agreement_dayofaccrual_check CHECK (((dayofaccrual > 0) AND (dayofaccrual < 29))),
    CONSTRAINT credit_agreement_initialamount_check CHECK ((initialamount > (0)::numeric)),
    CONSTRAINT credit_agreement_interestrate_check CHECK ((interestrate < (40)::double precision))
);
 $   DROP TABLE public.credit_agreement;
       public         heap    postgres    false            �            1259    24674    credit_agreement_id_seq    SEQUENCE     �   CREATE SEQUENCE public.credit_agreement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.credit_agreement_id_seq;
       public          postgres    false    229            k           0    0    credit_agreement_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.credit_agreement_id_seq OWNED BY public.credit_agreement.id;
          public          postgres    false    228            �            1259    24651    credit_id_seq    SEQUENCE     �   CREATE SEQUENCE public.credit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.credit_id_seq;
       public          postgres    false    225            l           0    0    credit_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.credit_id_seq OWNED BY public.credit.id;
          public          postgres    false    224            �            1259    24760    credit_payment_schedule    TABLE     �   CREATE TABLE public.credit_payment_schedule (
    id integer NOT NULL,
    creditagreementid integer NOT NULL,
    plannedpaymentdate date NOT NULL,
    actualpaymentdate date,
    interestpayment numeric NOT NULL,
    creditpayment numeric NOT NULL
);
 +   DROP TABLE public.credit_payment_schedule;
       public         heap    postgres    false            �            1259    24759    credit_payment_schedule_id_seq    SEQUENCE     �   CREATE SEQUENCE public.credit_payment_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.credit_payment_schedule_id_seq;
       public          postgres    false    235            m           0    0    credit_payment_schedule_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.credit_payment_schedule_id_seq OWNED BY public.credit_payment_schedule.id;
          public          postgres    false    234            �            1259    16527    currency    TABLE     �   CREATE TABLE public.currency (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    country character varying(20) NOT NULL
);
    DROP TABLE public.currency;
       public         heap    postgres    false            �            1259    16526    currency_id_seq    SEQUENCE     �   CREATE SEQUENCE public.currency_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.currency_id_seq;
       public          postgres    false    223            n           0    0    currency_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.currency_id_seq OWNED BY public.currency.id;
          public          postgres    false    222            �            1259    24664    deposit    TABLE     �  CREATE TABLE public.deposit (
    id integer NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(30) NOT NULL,
    minimumamount numeric NOT NULL,
    interestrate real NOT NULL,
    CONSTRAINT deposit_interestrate_check CHECK ((interestrate < (20)::double precision)),
    CONSTRAINT deposit_minimumamount_check CHECK ((minimumamount > (0)::numeric))
);
    DROP TABLE public.deposit;
       public         heap    postgres    false            �            1259    24710    deposit_agreement    TABLE     �  CREATE TABLE public.deposit_agreement (
    id integer NOT NULL,
    currencyid integer NOT NULL,
    depositid integer NOT NULL,
    employeeid integer NOT NULL,
    clientid integer NOT NULL,
    dayofaccrual integer NOT NULL,
    plannedclosingdate date NOT NULL,
    amountofpayments numeric DEFAULT 0,
    initialamount numeric NOT NULL,
    dateofopening date NOT NULL,
    dateofclosing date,
    CONSTRAINT deposit_agreement_check CHECK ((plannedclosingdate > dateofopening)),
    CONSTRAINT deposit_agreement_dayofaccrual_check CHECK (((dayofaccrual > 0) AND (dayofaccrual < 29))),
    CONSTRAINT deposit_agreement_initialamount_check CHECK ((initialamount > (0)::numeric))
);
 %   DROP TABLE public.deposit_agreement;
       public         heap    postgres    false            �            1259    24709    deposit_agreement_id_seq    SEQUENCE     �   CREATE SEQUENCE public.deposit_agreement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.deposit_agreement_id_seq;
       public          postgres    false    231            o           0    0    deposit_agreement_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.deposit_agreement_id_seq OWNED BY public.deposit_agreement.id;
          public          postgres    false    230            �            1259    24663    deposit_id_seq    SEQUENCE     �   CREATE SEQUENCE public.deposit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.deposit_id_seq;
       public          postgres    false    227            p           0    0    deposit_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.deposit_id_seq OWNED BY public.deposit.id;
          public          postgres    false    226            �            1259    24746    deposit_payment_schedule    TABLE     �   CREATE TABLE public.deposit_payment_schedule (
    id integer NOT NULL,
    depositagreementid integer NOT NULL,
    plannedpaymentdate date NOT NULL,
    actualpaymentdate date,
    paymentamount numeric NOT NULL
);
 ,   DROP TABLE public.deposit_payment_schedule;
       public         heap    postgres    false            �            1259    24745    deposit_payment_schedule_id_seq    SEQUENCE     �   CREATE SEQUENCE public.deposit_payment_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.deposit_payment_schedule_id_seq;
       public          postgres    false    233            q           0    0    deposit_payment_schedule_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.deposit_payment_schedule_id_seq OWNED BY public.deposit_payment_schedule.id;
          public          postgres    false    232            �            1259    16510    employee    TABLE     L  CREATE TABLE public.employee (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    passportid character varying(10) NOT NULL,
    phonenumber character varying(11) NOT NULL,
    email character varying(100) NOT NULL,
    address character varying(100) NOT NULL,
    dateofbirth character varying(10) NOT NULL,
    salary integer NOT NULL,
    categoryid integer NOT NULL,
    CONSTRAINT employee_email_check CHECK (((email)::text ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'::text)),
    CONSTRAINT employee_passportid_check CHECK (((passportid)::text ~ '^[0-9]{10}$'::text)),
    CONSTRAINT employee_phonenumber_check CHECK (((phonenumber)::text ~ '^[0-9]{11}$'::text)),
    CONSTRAINT employee_salary_check CHECK ((salary > 0))
);
    DROP TABLE public.employee;
       public         heap    postgres    false            �            1259    16502    employee_category    TABLE     �   CREATE TABLE public.employee_category (
    id integer NOT NULL,
    description character varying(200) NOT NULL,
    salary integer NOT NULL,
    name character varying(30) NOT NULL,
    CONSTRAINT employee_category_salary_check CHECK ((salary > 0))
);
 %   DROP TABLE public.employee_category;
       public         heap    postgres    false            �            1259    16501    employee_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.employee_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.employee_category_id_seq;
       public          postgres    false    219            r           0    0    employee_category_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.employee_category_id_seq OWNED BY public.employee_category.id;
          public          postgres    false    218            �            1259    16509    employee_id_seq    SEQUENCE     �   CREATE SEQUENCE public.employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.employee_id_seq;
       public          postgres    false    221            s           0    0    employee_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.employee_id_seq OWNED BY public.employee.id;
          public          postgres    false    220            ~           2604    16495 	   client id    DEFAULT     f   ALTER TABLE ONLY public.client ALTER COLUMN id SET DEFAULT nextval('public.client_id_seq'::regclass);
 8   ALTER TABLE public.client ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216    217            �           2604    24655 	   credit id    DEFAULT     f   ALTER TABLE ONLY public.credit ALTER COLUMN id SET DEFAULT nextval('public.credit_id_seq'::regclass);
 8   ALTER TABLE public.credit ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    225    225            �           2604    24678    credit_agreement id    DEFAULT     z   ALTER TABLE ONLY public.credit_agreement ALTER COLUMN id SET DEFAULT nextval('public.credit_agreement_id_seq'::regclass);
 B   ALTER TABLE public.credit_agreement ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228    229            �           2604    24763    credit_payment_schedule id    DEFAULT     �   ALTER TABLE ONLY public.credit_payment_schedule ALTER COLUMN id SET DEFAULT nextval('public.credit_payment_schedule_id_seq'::regclass);
 I   ALTER TABLE public.credit_payment_schedule ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    235    235            �           2604    16530    currency id    DEFAULT     j   ALTER TABLE ONLY public.currency ALTER COLUMN id SET DEFAULT nextval('public.currency_id_seq'::regclass);
 :   ALTER TABLE public.currency ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    222    223            �           2604    24667 
   deposit id    DEFAULT     h   ALTER TABLE ONLY public.deposit ALTER COLUMN id SET DEFAULT nextval('public.deposit_id_seq'::regclass);
 9   ALTER TABLE public.deposit ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    226    227            �           2604    24713    deposit_agreement id    DEFAULT     |   ALTER TABLE ONLY public.deposit_agreement ALTER COLUMN id SET DEFAULT nextval('public.deposit_agreement_id_seq'::regclass);
 C   ALTER TABLE public.deposit_agreement ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    231    231            �           2604    24749    deposit_payment_schedule id    DEFAULT     �   ALTER TABLE ONLY public.deposit_payment_schedule ALTER COLUMN id SET DEFAULT nextval('public.deposit_payment_schedule_id_seq'::regclass);
 J   ALTER TABLE public.deposit_payment_schedule ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    232    233            �           2604    16513    employee id    DEFAULT     j   ALTER TABLE ONLY public.employee ALTER COLUMN id SET DEFAULT nextval('public.employee_id_seq'::regclass);
 :   ALTER TABLE public.employee ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221                       2604    16505    employee_category id    DEFAULT     |   ALTER TABLE ONLY public.employee_category ALTER COLUMN id SET DEFAULT nextval('public.employee_category_id_seq'::regclass);
 C   ALTER TABLE public.employee_category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            O          0    16492    client 
   TABLE DATA           S   COPY public.client (id, name, passportid, phonenumber, email, address) FROM stdin;
    public          postgres    false    217   �x       W          0    24652    credit 
   TABLE DATA           T   COPY public.credit (id, description, name, maximumamount, interestrate) FROM stdin;
    public          postgres    false    225   �y       [          0    24675    credit_agreement 
   TABLE DATA           �   COPY public.credit_agreement (id, currencyid, creditid, employeeid, clientid, dayofaccrual, plannedclosingdate, interestamount, interestrate, currentdebt, initialamount, dateofopening, dateofclosing) FROM stdin;
    public          postgres    false    229   ^z       a          0    24760    credit_payment_schedule 
   TABLE DATA           �   COPY public.credit_payment_schedule (id, creditagreementid, plannedpaymentdate, actualpaymentdate, interestpayment, creditpayment) FROM stdin;
    public          postgres    false    235   �z       U          0    16527    currency 
   TABLE DATA           5   COPY public.currency (id, name, country) FROM stdin;
    public          postgres    false    223   :{       Y          0    24664    deposit 
   TABLE DATA           U   COPY public.deposit (id, description, name, minimumamount, interestrate) FROM stdin;
    public          postgres    false    227   d{       ]          0    24710    deposit_agreement 
   TABLE DATA           �   COPY public.deposit_agreement (id, currencyid, depositid, employeeid, clientid, dayofaccrual, plannedclosingdate, amountofpayments, initialamount, dateofopening, dateofclosing) FROM stdin;
    public          postgres    false    231   [|       _          0    24746    deposit_payment_schedule 
   TABLE DATA           �   COPY public.deposit_payment_schedule (id, depositagreementid, plannedpaymentdate, actualpaymentdate, paymentamount) FROM stdin;
    public          postgres    false    233   �|       S          0    16510    employee 
   TABLE DATA           v   COPY public.employee (id, name, passportid, phonenumber, email, address, dateofbirth, salary, categoryid) FROM stdin;
    public          postgres    false    221   �|       Q          0    16502    employee_category 
   TABLE DATA           J   COPY public.employee_category (id, description, salary, name) FROM stdin;
    public          postgres    false    219   y}       t           0    0    client_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.client_id_seq', 4, true);
          public          postgres    false    216            u           0    0    credit_agreement_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.credit_agreement_id_seq', 1, false);
          public          postgres    false    228            v           0    0    credit_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.credit_id_seq', 1, false);
          public          postgres    false    224            w           0    0    credit_payment_schedule_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.credit_payment_schedule_id_seq', 8, true);
          public          postgres    false    234            x           0    0    currency_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.currency_id_seq', 2, true);
          public          postgres    false    222            y           0    0    deposit_agreement_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.deposit_agreement_id_seq', 1, false);
          public          postgres    false    230            z           0    0    deposit_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.deposit_id_seq', 1, false);
          public          postgres    false    226            {           0    0    deposit_payment_schedule_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.deposit_payment_schedule_id_seq', 1, false);
          public          postgres    false    232            |           0    0    employee_category_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.employee_category_id_seq', 2, true);
          public          postgres    false    218            }           0    0    employee_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.employee_id_seq', 7, true);
          public          postgres    false    220            �           2606    24773    credit_agreement ch1    CHECK CONSTRAINT     n   ALTER TABLE public.credit_agreement
    ADD CONSTRAINT ch1 CHECK ((dateofopening > dateofclosing)) NOT VALID;
 9   ALTER TABLE public.credit_agreement DROP CONSTRAINT ch1;
       public          postgres    false    229    229    229    229            �           2606    24775    deposit_agreement ch1    CHECK CONSTRAINT     o   ALTER TABLE public.deposit_agreement
    ADD CONSTRAINT ch1 CHECK ((dateofopening < dateofclosing)) NOT VALID;
 :   ALTER TABLE public.deposit_agreement DROP CONSTRAINT ch1;
       public          postgres    false    231    231    231    231            �           2606    16500    client client_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.client DROP CONSTRAINT client_pkey;
       public            postgres    false    217            �           2606    24688 &   credit_agreement credit_agreement_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.credit_agreement
    ADD CONSTRAINT credit_agreement_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.credit_agreement DROP CONSTRAINT credit_agreement_pkey;
       public            postgres    false    229            �           2606    24767 4   credit_payment_schedule credit_payment_schedule_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.credit_payment_schedule
    ADD CONSTRAINT credit_payment_schedule_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.credit_payment_schedule DROP CONSTRAINT credit_payment_schedule_pkey;
       public            postgres    false    235            �           2606    24661    credit credit_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.credit
    ADD CONSTRAINT credit_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.credit DROP CONSTRAINT credit_pkey;
       public            postgres    false    225            �           2606    16532    currency currency_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.currency DROP CONSTRAINT currency_pkey;
       public            postgres    false    223            �           2606    24721 (   deposit_agreement deposit_agreement_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.deposit_agreement
    ADD CONSTRAINT deposit_agreement_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.deposit_agreement DROP CONSTRAINT deposit_agreement_pkey;
       public            postgres    false    231            �           2606    24753 6   deposit_payment_schedule deposit_payment_schedule_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.deposit_payment_schedule
    ADD CONSTRAINT deposit_payment_schedule_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.deposit_payment_schedule DROP CONSTRAINT deposit_payment_schedule_pkey;
       public            postgres    false    233            �           2606    24673    deposit deposit_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.deposit
    ADD CONSTRAINT deposit_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.deposit DROP CONSTRAINT deposit_pkey;
       public            postgres    false    227            �           2606    16508 (   employee_category employee_category_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.employee_category
    ADD CONSTRAINT employee_category_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.employee_category DROP CONSTRAINT employee_category_pkey;
       public            postgres    false    219            �           2606    16520    employee employee_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.employee DROP CONSTRAINT employee_pkey;
       public            postgres    false    221            �           2606    24704 /   credit_agreement credit_agreement_clientid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.credit_agreement
    ADD CONSTRAINT credit_agreement_clientid_fkey FOREIGN KEY (clientid) REFERENCES public.client(id);
 Y   ALTER TABLE ONLY public.credit_agreement DROP CONSTRAINT credit_agreement_clientid_fkey;
       public          postgres    false    217    229    4769            �           2606    24694 /   credit_agreement credit_agreement_creditid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.credit_agreement
    ADD CONSTRAINT credit_agreement_creditid_fkey FOREIGN KEY (creditid) REFERENCES public.credit(id);
 Y   ALTER TABLE ONLY public.credit_agreement DROP CONSTRAINT credit_agreement_creditid_fkey;
       public          postgres    false    229    4777    225            �           2606    24689 1   credit_agreement credit_agreement_currencyid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.credit_agreement
    ADD CONSTRAINT credit_agreement_currencyid_fkey FOREIGN KEY (currencyid) REFERENCES public.currency(id);
 [   ALTER TABLE ONLY public.credit_agreement DROP CONSTRAINT credit_agreement_currencyid_fkey;
       public          postgres    false    4775    223    229            �           2606    24699 1   credit_agreement credit_agreement_employeeid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.credit_agreement
    ADD CONSTRAINT credit_agreement_employeeid_fkey FOREIGN KEY (employeeid) REFERENCES public.employee(id);
 [   ALTER TABLE ONLY public.credit_agreement DROP CONSTRAINT credit_agreement_employeeid_fkey;
       public          postgres    false    4773    221    229            �           2606    24768 F   credit_payment_schedule credit_payment_schedule_creditagreementid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.credit_payment_schedule
    ADD CONSTRAINT credit_payment_schedule_creditagreementid_fkey FOREIGN KEY (creditagreementid) REFERENCES public.credit_agreement(id);
 p   ALTER TABLE ONLY public.credit_payment_schedule DROP CONSTRAINT credit_payment_schedule_creditagreementid_fkey;
       public          postgres    false    235    229    4781            �           2606    24737 1   deposit_agreement deposit_agreement_clientid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.deposit_agreement
    ADD CONSTRAINT deposit_agreement_clientid_fkey FOREIGN KEY (clientid) REFERENCES public.client(id);
 [   ALTER TABLE ONLY public.deposit_agreement DROP CONSTRAINT deposit_agreement_clientid_fkey;
       public          postgres    false    4769    231    217            �           2606    24722 3   deposit_agreement deposit_agreement_currencyid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.deposit_agreement
    ADD CONSTRAINT deposit_agreement_currencyid_fkey FOREIGN KEY (currencyid) REFERENCES public.currency(id);
 ]   ALTER TABLE ONLY public.deposit_agreement DROP CONSTRAINT deposit_agreement_currencyid_fkey;
       public          postgres    false    4775    231    223            �           2606    24727 2   deposit_agreement deposit_agreement_depositid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.deposit_agreement
    ADD CONSTRAINT deposit_agreement_depositid_fkey FOREIGN KEY (depositid) REFERENCES public.deposit(id);
 \   ALTER TABLE ONLY public.deposit_agreement DROP CONSTRAINT deposit_agreement_depositid_fkey;
       public          postgres    false    227    4779    231            �           2606    24732 3   deposit_agreement deposit_agreement_employeeid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.deposit_agreement
    ADD CONSTRAINT deposit_agreement_employeeid_fkey FOREIGN KEY (employeeid) REFERENCES public.employee(id);
 ]   ALTER TABLE ONLY public.deposit_agreement DROP CONSTRAINT deposit_agreement_employeeid_fkey;
       public          postgres    false    4773    231    221            �           2606    24754 I   deposit_payment_schedule deposit_payment_schedule_depositagreementid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.deposit_payment_schedule
    ADD CONSTRAINT deposit_payment_schedule_depositagreementid_fkey FOREIGN KEY (depositagreementid) REFERENCES public.deposit_agreement(id);
 s   ALTER TABLE ONLY public.deposit_payment_schedule DROP CONSTRAINT deposit_payment_schedule_depositagreementid_fkey;
       public          postgres    false    231    233    4783            �           2606    16521 !   employee employee_categoryid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_categoryid_fkey FOREIGN KEY (categoryid) REFERENCES public.employee_category(id);
 K   ALTER TABLE ONLY public.employee DROP CONSTRAINT employee_categoryid_fkey;
       public          postgres    false    221    219    4771            O   �   x�E�MJ1�יS� et�4Mv=��mGڵV����S����3gx��/u!Y$/���~�oh�J4h%^�C�	��5v<o%�){z��c'2���3^���.�Co��(���׋�/Ng�X	|0�E3�+(�/�r�h�=:�<�p�6H�#��Y�I�J⑁�2��X���IO�X'�;��X���9��י5�l:Y-��|9���<�;|��'M�-��*\����1C<%'i�$�p�      W   �   x�����@DϻU� A�bR5�p@�T ��e�'�0��wV�jl��'u8i!�DPc@���e���9~�F�h�	z�5gӰ)�zDE1��#�-^����bv.�Sۢw�q|n�,���4#���z�u��	W����&2@K9m�p8�M�-FPg�hiPױ�D3|Sϓ����9@��      [   c   x�M��	�0��/�D��I�D'��sT�Т���q�`��e]�� cӂOfFJ�p��s7EV��ei4<_7͸�����?�Z�b*=V�E��|�����/      a   Y   x�e���0Dѳ��`���T���HrD�2�?j�yt���El���DR������YA�yAh%Zً���o��� ���/z      U      x�3�,*M�*-.�L����� 2N�      Y   �   x��P�i�@��U��6��#�0�(D��!-(�gdْ[��(�B i��q������2�#��pL�'�&mt'Zk��=m	�u�J�ָ#a2ભ8�`�FϹj�l��N�^�%�ۘ9fH�!ġ�B�N���1=!���l���Jz�����Y�j6� Й&��C#R��O����	��M�������ɖ;�6���I�����r��'�Tl�sB��      ]   G   x�M��� �\/f �I����ȩy>���7�0ݛ�*j�D���5a>�t�)7b�w����"�P��      _      x������ � �      S   �   x�%�;
�0���S� %6�ymĥnRT(�vpqr�AQJ�=×���=��%��F���qC�&���/����D@�0]$���i�5Y���x%��M^��*��r1�(��{���߄�
��x�X�0�}m�	!���2��H���y2F�)el)c��P      Q   t   x�e�A
�@ϻ���&�YQ�A���(YŘ/T��Y��@3U�&q�2G&T��T��Ň{d�Y'��qc����Ƣ�/y@���֮�ei��:��]�%.�UW��*���e_     