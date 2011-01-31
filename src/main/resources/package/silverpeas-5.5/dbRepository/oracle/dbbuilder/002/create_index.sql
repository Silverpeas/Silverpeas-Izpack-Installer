create index R_24_FK on SR_UNINSTITEMS (SR_PACKAGE asc)
/

create index SR_UNINSTITEMS_I1 on SR_UNINSTITEMS (SR_PACKAGE asc, SR_ACTION_TAG asc, SR_ITEM_ORDER asc)
/

create index RELATION_46_FK on SR_SCRIPTS (SR_ITEM_ID asc)
/

create index SR_ITEM_ID on SR_SCRIPTS (SR_ITEM_ID asc, SR_SEQ_NUM asc)
/

create unique index IN_DEPENDENCIES_1 on SR_DEPENDENCIES (SR_PACKAGE asc, SR_PKDEPENDENCY asc)
/
