CREATE TABLE crawler.agent_list
(
    agent_id                         NUMBER   (10)                   NOT NULL
  , agent_name                       VARCHAR2 (50)                   
  , agent_desc                       VARCHAR2 (500)                  
  , agent_ip                         VARCHAR2 (20)                   
  , create_time                      DATE                            
  , update_time                      DATE                            
)
ORGANIZATION        HEAP
MONITORING
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
NOCACHE
PCTFREE             10
INITRANS            1
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  PCTINCREASE       0
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

COMMENT ON TABLE crawler.agent_list IS '�����';

COMMENT ON COLUMN crawler.agent_list.agent_id IS '����';

COMMENT ON COLUMN crawler.agent_list.agent_name IS '��������';

COMMENT ON COLUMN crawler.agent_list.agent_desc IS '��������';

COMMENT ON COLUMN crawler.agent_list.agent_ip IS '����ip��ַ';

COMMENT ON COLUMN crawler.agent_list.create_time IS '����ʱ��';

COMMENT ON COLUMN crawler.agent_list.update_time IS '����ʱ��';

CREATE UNIQUE INDEX crawler.sys_c009437 ON crawler.agent_list
(
    agent_id
)
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
PCTFREE             10
INITRANS            2
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;
CREATE TABLE crawler.chl_list
(
    chl_id                           NUMBER   (38)                   NOT NULL
  , chl_hash                         VARCHAR2 (64)                   NOT NULL
  , chl_url                          VARCHAR2 (4000)                 NOT NULL
  , chl_name                         VARCHAR2 (200)                  
  , create_time                      DATE                            NOT NULL
  , job_id                           NUMBER   (38)                   NOT NULL
  , chl_stat                         VARCHAR2 (2)                    DEFAULT 0 NOT NULL
  , update_time                      DATE                            
  , fail_count                       NUMBER   (10)                   DEFAULT 0 
)
ORGANIZATION        HEAP
MONITORING
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
NOCACHE
PCTFREE             10
INITRANS            1
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  PCTINCREASE       0
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

COMMENT ON TABLE crawler.chl_list IS 'Ƶ����';

COMMENT ON COLUMN crawler.chl_list.chl_id IS 'Ƶ��id';

COMMENT ON COLUMN crawler.chl_list.chl_hash IS 'Ƶ��hash';

COMMENT ON COLUMN crawler.chl_list.chl_url IS 'Ƶ��url';

COMMENT ON COLUMN crawler.chl_list.chl_name IS 'Ƶ������';

COMMENT ON COLUMN crawler.chl_list.create_time IS '����ʱ��';

COMMENT ON COLUMN crawler.chl_list.job_id IS 'job_id';

COMMENT ON COLUMN crawler.chl_list.chl_stat IS 'Ƶ��״̬';

COMMENT ON COLUMN crawler.chl_list.update_time IS '����ʱ��';

COMMENT ON COLUMN crawler.chl_list.fail_count IS 'ʧ�ܴ���';

CREATE UNIQUE INDEX crawler.chl_list_hash_index ON crawler.chl_list
(
    chl_hash
)
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
PCTFREE             10
INITRANS            2
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

CREATE UNIQUE INDEX crawler.chl_list_pk ON crawler.chl_list
(
    chl_id
)
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
PCTFREE             10
INITRANS            2
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

CREATE TABLE crawler.col_list
(
    col_id                           NUMBER   (38)                   NOT NULL
  , col_hash                         VARCHAR2 (64)                   NOT NULL
  , col_name                         VARCHAR2 (1000)                 
  , col_url                          VARCHAR2 (4000)                 NOT NULL
  , chl_id                           NUMBER   (38)                   NOT NULL
  , create_time                      DATE                            NOT NULL
  , col_stat                         VARCHAR2 (2)                    NOT NULL
  , job_id                           NUMBER   (38)                   NOT NULL
  , update_time                      DATE                            
  , fail_count                       NUMBER   (10)                   DEFAULT 0 
  , col_alias                        VARCHAR2 (1000)                 
)
ORGANIZATION        HEAP
MONITORING
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
NOCACHE
PCTFREE             10
INITRANS            1
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  PCTINCREASE       0
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

COMMENT ON TABLE crawler.col_list IS 'Ƶ����';

COMMENT ON COLUMN crawler.col_list.col_id IS '��Ŀid';

COMMENT ON COLUMN crawler.col_list.col_hash IS '��Ŀhash';

COMMENT ON COLUMN crawler.col_list.col_name IS '��Ŀ����';

COMMENT ON COLUMN crawler.col_list.col_url IS '��Ŀurl';

COMMENT ON COLUMN crawler.col_list.chl_id IS 'Ƶ��id';

COMMENT ON COLUMN crawler.col_list.create_time IS '����ʱ��';

COMMENT ON COLUMN crawler.col_list.col_stat IS '��Ŀ״̬';

COMMENT ON COLUMN crawler.col_list.job_id IS 'job_id';

COMMENT ON COLUMN crawler.col_list.update_time IS '����ʱ��';

COMMENT ON COLUMN crawler.col_list.fail_count IS 'ʧ�ܴ���';

COMMENT ON COLUMN crawler.col_list.col_alias IS '��Ŀ����';

CREATE UNIQUE INDEX crawler.col_list_hash_index ON crawler.col_list
(
    col_hash
)
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
PCTFREE             10
INITRANS            2
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

CREATE UNIQUE INDEX crawler.col_list_pk ON crawler.col_list
(
    col_id
)
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
PCTFREE             10
INITRANS            2
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

CREATE TABLE crawler.crawler_list
(
    crawler_id                       NUMBER   (10)                   NOT NULL
  , crawler_name                     VARCHAR2 (50)                   
  , crawler_status                   NUMBER   (2)                    
  , create_time                      DATE                            
  , update_time                      DATE                            
  , agent_id                         NUMBER   (10)                   
)
ORGANIZATION        HEAP
MONITORING
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
NOCACHE
PCTFREE             10
INITRANS            1
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  PCTINCREASE       0
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

COMMENT ON TABLE crawler.crawler_list IS '�����';

COMMENT ON COLUMN crawler.crawler_list.crawler_id IS '����id';

COMMENT ON COLUMN crawler.crawler_list.crawler_name IS '��������';

COMMENT ON COLUMN crawler.crawler_list.crawler_status IS '����״̬';

COMMENT ON COLUMN crawler.crawler_list.create_time IS '����ʱ��';

COMMENT ON COLUMN crawler.crawler_list.update_time IS '����ʱ��';

COMMENT ON COLUMN crawler.crawler_list.agent_id IS '����id';

CREATE UNIQUE INDEX crawler.sys_c009456 ON crawler.crawler_list
(
    crawler_id
)
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
PCTFREE             10
INITRANS            2
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

CREATE TABLE crawler.job_list
(
    job_id                           NUMBER   (38)                   NOT NULL
  , job_name                         VARCHAR2 (200)                  NOT NULL
  , job_comment                      VARCHAR2 (4000)                 
  , create_time                      DATE                            NOT NULL
  , job_seed_url                     VARCHAR2 (4000)                 
  , job_seed_type                    VARCHAR2 (2)                    
  , update_time                      DATE                            
  , job_stat                         VARCHAR2 (2)                    DEFAULT '0' 
  , job_seed_category                VARCHAR2 (1)                    DEFAULT '1' 
  , dredb                            VARCHAR2 (50)                   
  , run_interval                     NUMBER   (10)                   
  , interval                         NUMBER   (10)                   
)
ORGANIZATION        HEAP
MONITORING
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
NOCACHE
PCTFREE             10
INITRANS            1
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  PCTINCREASE       0
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

COMMENT ON TABLE crawler.job_list IS 'job��';

COMMENT ON COLUMN crawler.job_list.job_id IS 'job_id';

COMMENT ON COLUMN crawler.job_list.job_name IS 'job����';

COMMENT ON COLUMN crawler.job_list.job_comment IS 'jobע��';

COMMENT ON COLUMN crawler.job_list.create_time IS '����ʱ��';

COMMENT ON COLUMN crawler.job_list.job_seed_url IS 'job seed url';

COMMENT ON COLUMN crawler.job_list.job_seed_type IS '���ͣ�1-Ƶ�� 2-��Ŀ';

COMMENT ON COLUMN crawler.job_list.update_time IS '����ʱ��';

COMMENT ON COLUMN crawler.job_list.job_stat IS 'job״̬';

COMMENT ON COLUMN crawler.job_list.job_seed_category IS 'seed���ࣺ1-��ͨ��Ŀ 2-�����б�';

COMMENT ON COLUMN crawler.job_list.dredb IS 'dredb��';

COMMENT ON COLUMN crawler.job_list.run_interval IS '������ץȡʱ����';

COMMENT ON COLUMN crawler.job_list.interval IS 'Ĭ�ϳ�ʼץȡʱ����';

CREATE UNIQUE INDEX crawler.job_list_pk ON crawler.job_list
(
    job_id
)
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
PCTFREE             10
INITRANS            2
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

CREATE UNIQUE INDEX crawler.job_list_index ON crawler.job_list
(
    job_name
)
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
PCTFREE             10
INITRANS            2
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

ALTER TABLE crawler.job_list ADD CONSTRAINT job_list_pk PRIMARY KEY
(
    job_id
)
NOT DEFERRABLE
INITIALLY IMMEDIATE
ENABLE NOVALIDATE;


CREATE TABLE crawler.task_list
(
    task_id                          NUMBER   (10)                   NOT NULL
  , job_id                           NUMBER   (10)                   
  , wrapper_id                       NUMBER   (10)                   
  , wrapper_version                  NUMBER   (10)                   
  , job_type                         NUMBER   (1)                    
  , crawler_id                       NUMBER   (10)                   
  , ids                              VARCHAR2 (4000)                 
  , create_time                      DATE                            
  , task_status                      NUMBER   (2)                    
  , update_time                      DATE                            
)
ORGANIZATION        HEAP
MONITORING
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
NOCACHE
PCTFREE             10
INITRANS            1
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  PCTINCREASE       0
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

COMMENT ON TABLE crawler.task_list IS '�����';

COMMENT ON COLUMN crawler.task_list.task_id IS '����ID';

COMMENT ON COLUMN crawler.task_list.job_id IS 'job_id';

COMMENT ON COLUMN crawler.task_list.wrapper_id IS 'wrapper_id';

COMMENT ON COLUMN crawler.task_list.wrapper_version IS 'wrapper�汾';

COMMENT ON COLUMN crawler.task_list.job_type IS 'job����';

COMMENT ON COLUMN crawler.task_list.crawler_id IS '����id';

COMMENT ON COLUMN crawler.task_list.ids IS 'ids';

COMMENT ON COLUMN crawler.task_list.create_time IS '����ʱ��';

COMMENT ON COLUMN crawler.task_list.task_status IS 'task״̬';

COMMENT ON COLUMN crawler.task_list.update_time IS '����ʱ��';

CREATE UNIQUE INDEX crawler.sys_c009462 ON crawler.task_list
(
    task_id
)
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
PCTFREE             10
INITRANS            2
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

CREATE TABLE crawler.url_att
(
    url_att_id                       NUMBER   (38)                   NOT NULL
  , url_id                           NUMBER   (38)                   NOT NULL
  , col_id                           NUMBER   (38)                   NOT NULL
  , create_time                      DATE                            NOT NULL
  , update_time                      DATE                            
)
ORGANIZATION        HEAP
MONITORING
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
NOCACHE
PCTFREE             10
INITRANS            1
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  PCTINCREASE       0
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

COMMENT ON TABLE crawler.url_att IS '��Ŀ��url������';

COMMENT ON COLUMN crawler.url_att.url_att_id IS '����id';

COMMENT ON COLUMN crawler.url_att.url_id IS 'url_id';

COMMENT ON COLUMN crawler.url_att.col_id IS '��Ŀid';

COMMENT ON COLUMN crawler.url_att.create_time IS '����ʱ��';

COMMENT ON COLUMN crawler.url_att.update_time IS '�޸�ʱ��';

CREATE UNIQUE INDEX crawler.url_att_index ON crawler.url_att
(
    url_id
  , col_id
)
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
PCTFREE             10
INITRANS            2
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

CREATE UNIQUE INDEX crawler.url_att_pk ON crawler.url_att
(
    url_att_id
)
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
PCTFREE             10
INITRANS            2
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

CREATE TABLE crawler.url_list
(
    url_id                           NUMBER   (38)                   NOT NULL
  , url_hash                         VARCHAR2 (64)                   NOT NULL
  , url_url                          VARCHAR2 (4000)                 NOT NULL
  , url_name                         VARCHAR2 (1000)                 
  , create_time                      DATE                            NOT NULL
  , url_stat                         VARCHAR2 (2)                    NOT NULL
  , job_id                           VARCHAR2 (4000)                 
  , update_time                      DATE                            
  , fail_count                       NUMBER   (10)                   DEFAULT 0 
)
ORGANIZATION        HEAP
MONITORING
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
NOCACHE
PCTFREE             10
INITRANS            1
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  PCTINCREASE       0
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

COMMENT ON TABLE crawler.url_list IS 'url��';

COMMENT ON COLUMN crawler.url_list.url_id IS 'url_id';

COMMENT ON COLUMN crawler.url_list.url_hash IS 'url_hash';

COMMENT ON COLUMN crawler.url_list.url_url IS 'url';

COMMENT ON COLUMN crawler.url_list.url_name IS 'url����';

COMMENT ON COLUMN crawler.url_list.create_time IS '����ʱ��';

COMMENT ON COLUMN crawler.url_list.url_stat IS 'url״̬';

COMMENT ON COLUMN crawler.url_list.job_id IS 'job_id';

COMMENT ON COLUMN crawler.url_list.update_time IS '����ʱ��';

COMMENT ON COLUMN crawler.url_list.fail_count IS 'ʧ�ܴ���';

CREATE UNIQUE INDEX crawler.url_list_hash_index ON crawler.url_list
(
    url_hash
)
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
PCTFREE             10
INITRANS            2
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

CREATE UNIQUE INDEX crawler.url_list_pk ON crawler.url_list
(
    url_id
)
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
PCTFREE             10
INITRANS            2
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

CREATE TABLE crawler.wrapper_list
(
    wrap_id                          NUMBER   (38)                   NOT NULL
  , wrap_type                        VARCHAR2 (2)                    NOT NULL
  , wrapper                          CLOB                            NOT NULL
  , create_time                      DATE                            NOT NULL
  , job_id                           NUMBER   (38)                   NOT NULL
  , wrap_comment                     VARCHAR2 (1000)                 
  , wrap_version                     NUMBER   (38)                   DEFAULT 1 NOT NULL
  , wrap_var_gen                     VARCHAR2 (4000)                 
  , update_time                      DATE                            
  , wrap_stat                        VARCHAR2 (2)                    DEFAULT '0' 
)
ORGANIZATION        HEAP
MONITORING
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
NOCACHE
PCTFREE             10
INITRANS            1
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  PCTINCREASE       0
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

COMMENT ON TABLE crawler.wrapper_list IS 'wrapper��';

COMMENT ON COLUMN crawler.wrapper_list.wrap_id IS 'wrap_id';

COMMENT ON COLUMN crawler.wrapper_list.wrap_type IS 'wrap���� 1-Ƶ�� 2-��Ŀ 3-url';

COMMENT ON COLUMN crawler.wrapper_list.wrapper IS 'wrapper';

COMMENT ON COLUMN crawler.wrapper_list.create_time IS '����ʱ��';

COMMENT ON COLUMN crawler.wrapper_list.job_id IS 'job_id';

COMMENT ON COLUMN crawler.wrapper_list.wrap_comment IS 'wrapע��';

COMMENT ON COLUMN crawler.wrapper_list.wrap_version IS 'wrap�汾';

COMMENT ON COLUMN crawler.wrapper_list.wrap_var_gen IS 'wrapѧϰ����(����ѧϰ��)';

COMMENT ON COLUMN crawler.wrapper_list.update_time IS '����ʱ��';

COMMENT ON COLUMN crawler.wrapper_list.wrap_stat IS 'wrap״̬';

CREATE UNIQUE INDEX crawler.wrapper_list_pk ON crawler.wrapper_list
(
    wrap_id
)
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
PCTFREE             10
INITRANS            2
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

CREATE UNIQUE INDEX crawler.wrap_list_index ON crawler.wrapper_list
(
    wrap_type
  , job_id
)
PARALLEL
(
  DEGREE            1
  INSTANCES         1
)
PCTFREE             10
INITRANS            2
MAXTRANS            255
STORAGE
(
  INITIAL           65536
  MINEXTENTS        1
  MAXEXTENTS        unlimited
  FREELISTS         1
  FREELIST GROUPS   1
  BUFFER_POOL       default
)
LOGGING
TABLESPACE          tbs_crawler
;

ALTER TABLE crawler.wrapper_list ADD CONSTRAINT wrapper_list_pk PRIMARY KEY
(
    wrap_id
)
NOT DEFERRABLE
INITIALLY IMMEDIATE
ENABLE NOVALIDATE;






CREATE SEQUENCE crawler.chl_id_sequence
   START WITH       1
   INCREMENT BY     1
   MINVALUE         1
   MAXVALUE         10000000000
   NOCACHE
   CYCLE
   NOORDER
;

CREATE SEQUENCE crawler.col_id_sequence
   START WITH       1
   INCREMENT BY     1
   MINVALUE         1
   MAXVALUE         1000000000
   NOCACHE
   CYCLE
   NOORDER
;

CREATE SEQUENCE crawler.job_id_sequence
   START WITH       1
   INCREMENT BY     1
   MINVALUE         1
   MAXVALUE         1000000000
   NOCACHE
   CYCLE
   NOORDER
;
CREATE SEQUENCE crawler.seq_agent_list
   START WITH       1
   INCREMENT BY     1
   MINVALUE         1
   MAXVALUE         1000000000
   NOCACHE
   CYCLE
   NOORDER
;
CREATE SEQUENCE crawler.seq_crawler_list
   START WITH       1
   INCREMENT BY     1
   MINVALUE         1
   MAXVALUE         1000000000
   NOCACHE
   CYCLE
   NOORDER
;
CREATE SEQUENCE crawler.seq_agent_list
   START WITH       1
   INCREMENT BY     1
   MINVALUE         1
   MAXVALUE         1000000000
   NOCACHE
   CYCLE
   NOORDER
;
CREATE SEQUENCE crawler.seq_crawler_list
   START WITH       1
   INCREMENT BY     1
   MINVALUE         1
   MAXVALUE         1000000000
   NOCACHE
   CYCLE
   NOORDER
;
CREATE SEQUENCE crawler.seq_task_list
   START WITH       1
   INCREMENT BY     1
   MINVALUE         1
   MAXVALUE         10000000000
   NOCACHE
   CYCLE
   NOORDER
;

CREATE SEQUENCE crawler.url_att_seq
   START WITH       1
   INCREMENT BY     1
   MINVALUE         1
   MAXVALUE         10000000000
   NOCACHE
   CYCLE
   NOORDER
;

CREATE SEQUENCE crawler.url_id_sequence
   START WITH       1
   INCREMENT BY     1
   MINVALUE         1
   MAXVALUE         100000000000
   NOCACHE
   CYCLE
   NOORDER
;

CREATE SEQUENCE crawler.wrapper_id_sequence
   START WITH       1
   INCREMENT BY     1
   MINVALUE         1
   MAXVALUE         1000000000
   NOCACHE
   CYCLE
   NOORDER
;