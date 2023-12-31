PGDMP                      {            OMS    16.0    16.0     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16468    OMS    DATABASE     ~   CREATE DATABASE "OMS" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Philippines.1252';
    DROP DATABASE "OMS";
                postgres    false            �            1255    16469 j   addnewtrader(character varying, character varying, character varying, character varying, integer, integer) 	   PROCEDURE     s  CREATE PROCEDURE public.addnewtrader(IN username character varying, IN userpass character varying, IN fname character varying, IN lname character varying, IN age integer, IN ttype integer)
    LANGUAGE plpgsql
    AS $$
begin
    Insert into Traders (userid,userpass,firstname,lastname,age,tradertype) 
	values (username, userpass, fname, lname, age, ttype); 
	
end;
$$;
 �   DROP PROCEDURE public.addnewtrader(IN username character varying, IN userpass character varying, IN fname character varying, IN lname character varying, IN age integer, IN ttype integer);
       public          postgres    false            �            1255    16470 g   insertnewtrade(character varying, date, character varying, bigint, character varying, numeric, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.insertnewtrade(IN tradeordid character varying, IN transactdate date, IN symbol character varying, IN volume bigint, IN traderid character varying, IN price numeric, IN side integer)
    LANGUAGE plpgsql
    AS $$
begin
    Insert Into Trades (tradeordid, transactdate,symbol,volume,traderid,price,totval,Side)
	Values (
		tradeOrdID,
		transactdate,
		Symbol,
		volume,
		traderID,
		price,
		volume * price,
		side
	);

end;
$$;
 �   DROP PROCEDURE public.insertnewtrade(IN tradeordid character varying, IN transactdate date, IN symbol character varying, IN volume bigint, IN traderid character varying, IN price numeric, IN side integer);
       public          postgres    false            �            1255    16471 /   updatetrade(character varying, bigint, numeric) 	   PROCEDURE       CREATE PROCEDURE public.updatetrade(IN tradeordid character varying, IN nvolume bigint, IN nprice numeric)
    LANGUAGE plpgsql
    AS $$
begin
    Update Trades 
	SET
	  volume = nvolume.
	  price = nprice,
	  totval = nvolume * nprice
	Where tradeordid = tradeordid; 
	
end;
$$;
 j   DROP PROCEDURE public.updatetrade(IN tradeordid character varying, IN nvolume bigint, IN nprice numeric);
       public          postgres    false            �            1259    16472    traders    TABLE     �   CREATE TABLE public.traders (
    idnum integer NOT NULL,
    userid character varying(255),
    userpass character varying(255),
    firstname character varying(255),
    lastname character varying(255),
    age integer,
    tradertype integer
);
    DROP TABLE public.traders;
       public         heap    postgres    false            �            1259    16477    traders_idnum_seq    SEQUENCE     �   CREATE SEQUENCE public.traders_idnum_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.traders_idnum_seq;
       public          postgres    false    215            �           0    0    traders_idnum_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.traders_idnum_seq OWNED BY public.traders.idnum;
          public          postgres    false    216            �            1259    16478    trades    TABLE       CREATE TABLE public.trades (
    ordnum integer NOT NULL,
    tradeordid character varying(16),
    transactdate date,
    symbol character varying(255),
    volume bigint,
    traderid character varying(255),
    price numeric(10,4),
    totval numeric(10,4),
    side integer
);
    DROP TABLE public.trades;
       public         heap    postgres    false            �            1259    16483    trades_ordnum_seq    SEQUENCE     �   CREATE SEQUENCE public.trades_ordnum_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.trades_ordnum_seq;
       public          postgres    false    217            �           0    0    trades_ordnum_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.trades_ordnum_seq OWNED BY public.trades.ordnum;
          public          postgres    false    218            "           2604    16484    traders idnum    DEFAULT     n   ALTER TABLE ONLY public.traders ALTER COLUMN idnum SET DEFAULT nextval('public.traders_idnum_seq'::regclass);
 <   ALTER TABLE public.traders ALTER COLUMN idnum DROP DEFAULT;
       public          postgres    false    216    215            #           2604    16485    trades ordnum    DEFAULT     n   ALTER TABLE ONLY public.trades ALTER COLUMN ordnum SET DEFAULT nextval('public.trades_ordnum_seq'::regclass);
 <   ALTER TABLE public.trades ALTER COLUMN ordnum DROP DEFAULT;
       public          postgres    false    218    217            %           2606    16487    traders traders_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.traders
    ADD CONSTRAINT traders_pkey PRIMARY KEY (idnum);
 >   ALTER TABLE ONLY public.traders DROP CONSTRAINT traders_pkey;
       public            postgres    false    215            '           2606    16489    trades trades_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.trades
    ADD CONSTRAINT trades_pkey PRIMARY KEY (ordnum);
 <   ALTER TABLE ONLY public.trades DROP CONSTRAINT trades_pkey;
       public            postgres    false    217            )           2606    16491    trades trades_tradeordid_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.trades
    ADD CONSTRAINT trades_tradeordid_key UNIQUE (tradeordid);
 F   ALTER TABLE ONLY public.trades DROP CONSTRAINT trades_tradeordid_key;
       public            postgres    false    217           