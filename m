Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjRYi-0003s4-Sb
 for kexec@lists.infradead.org; Fri, 14 Dec 2012 09:27:57 +0000
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 14 Dec 2012 04:27:22 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D3E0A38C803F
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2012 04:26:28 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBE9QSRr345180
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2012 04:26:28 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBE9QR1r017434
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2012 07:26:28 -0200
Subject: [PATCH v3 3/7] Eppic call back functions to query a dump image
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Fri, 14 Dec 2012 14:56:23 +0530
Message-ID: <20121214092623.4854.23019.stgit@aravinda>
In-Reply-To: <20121214092300.4854.30720.stgit@aravinda>
References: <20121214092300.4854.30720.stgit@aravinda>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org
Cc: LChouinard@s2sys.com, mahesh@linux.vnet.ibm.com, tachibana@mxm.nes.nec.co.jp, ananth@in.ibm.com, buendgen@de.ibm.com

This patch implements a series of apigetuint* call back functions
which are used to access data from the dump image. Eppic uses these
call back functions to fetch the actual value of the global variables.

This patch also adds other call back functions as a place holder which
will be implemented in later patches. This is mainly to avoid
compilation error while registering the call back functions using
eppic_apiset() function.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 extension_eppic.c |  128 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 extension_eppic.h |   49 ++++++++++++++++++++
 2 files changed, 175 insertions(+), 2 deletions(-)

diff --git a/extension_eppic.c b/extension_eppic.c
index 48a3cbe..774d16e 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -20,6 +20,7 @@
 #include <sys/types.h>
 #include <fcntl.h>
 
+#include "makedumpfile.h"
 #include "extension_eppic.h"
 
 /*
@@ -64,6 +65,131 @@ reg_callback(char *name, int load)
 	return;
 }
 
+/*
+ * Call back functions for eppic to query the dump image
+ */
+
+static int
+apigetmem(ull iaddr, void *p, int nbytes)
+{
+	return readmem(VADDR, iaddr, p, nbytes);
+}
+
+static int
+apiputmem(ull iaddr, void *p, int nbytes)
+{
+	return 1;
+}
+
+static char *
+apimember(char *mname, ull pidx, type_t *tm,
+		member_t *m, ull *lidx)
+{
+	return 0;
+}
+
+static int
+apigetctype(int ctype, char *name, type_t *tout)
+{
+	return 0;
+}
+
+static char *
+apigetrtype(ull idx, type_t *t)
+{
+	return "";
+}
+
+static int
+apialignment(ull idx)
+{
+	return 0;
+}
+
+int
+apigetval(char *name, ull *val, VALUE_S *value)
+{
+	ull ptr = 0;
+
+	ptr = get_symbol_addr(name);
+	if (!ptr)
+		return 0;
+
+	*val = ptr;
+	return 1;
+}
+
+static enum_t *
+apigetenum(char *name)
+{
+	return 0;
+}
+
+static def_t *
+apigetdefs(void)
+{
+	return 0;
+}
+
+static uint8_t
+apigetuint8(void *ptr)
+{
+	uint8_t val;
+	if (!readmem(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
+		return (uint8_t) -1;
+	return val;
+}
+
+static uint16_t
+apigetuint16(void *ptr)
+{
+	uint16_t val;
+	if (!readmem(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
+		return (uint16_t) -1;
+	return val;
+}
+
+static uint32_t
+apigetuint32(void *ptr)
+{
+	uint32_t val;
+	if (!readmem(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
+		return (uint32_t) -1;
+	return val;
+}
+
+static uint64_t
+apigetuint64(void *ptr)
+{
+	uint64_t val;
+	if (!readmem(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
+		return (uint64_t) -1;
+	return val;
+}
+
+static char *
+apifindsym(char *p)
+{
+	return NULL;
+}
+
+apiops icops = {
+	apigetmem,
+	apiputmem,
+	apimember,
+	apigetctype,
+	apigetrtype,
+	apialignment,
+	apigetval,
+	apigetenum,
+	apigetdefs,
+	apigetuint8,
+	apigetuint16,
+	apigetuint32,
+	apigetuint64,
+	apifindsym
+};
+
 
 /* Initialize eppic */
 int
@@ -72,7 +198,7 @@ _init()
 	if (eppic_open() >= 0) {
 
 		/* Register call back functions */
-		eppic_apiset(NULL, 3, sizeof(long), 0);
+		eppic_apiset(&icops, 3, sizeof(long), 0);
 
 		/* set the new function callback */
 		eppic_setcallback(reg_callback);
diff --git a/extension_eppic.h b/extension_eppic.h
index 34396e4..beb68e4 100644
--- a/extension_eppic.h
+++ b/extension_eppic.h
@@ -20,5 +20,52 @@
 
 #include "eppic_api.h"
 
-#endif /* _EXTENSION_EPPIC_H */
+/*
+ * MEMBER_S, ENUM_S, DEF_S and TYPE_S are extracts from eppic header
+ * file eppic.h. The reason for not including the eppic.h header file
+ * in this file is because, lot of things in eppic.h are not required
+ * for makedumpfile extension.
+ */
+
+/* member information */
+typedef MEMBER_S {
+
+	char *name;
+	int offset; /* offset from top of structure */
+	int size;   /* size in bytes of the member or of the bit array */
+	int fbit;   /* fist bit (-1) is not a bit field */
+	int nbits;  /* number of bits for this member */
+	int value;  /* for a enum member, the corresponding value_t */
+
+} member_t;
+
+/* list to hold enum constant information */
+typedef ENUM_S {
+	struct enum_s *next;
+	char *name;
+	int value;
 
+} enum_t;
+
+/* list of macro symbols and there corresponding value_ts */
+typedef DEF_S {
+	struct def_s *next;
+	char *name;
+	char *val;
+
+} def_t;
+
+
+typedef TYPE_S {
+	int type;   /* type_t of type_t */
+	ull idx;    /* index to basetype_t or ctype_t */
+	int size;   /* size of this item */
+	/* ... next fields are use internally */
+	int typattr;    /* base type_t qualifiers */
+	int ref;    /* level of reference */
+	int fct;        /* 1 if function pointer */
+	int *idxlst;    /* points to list of indexes if array */
+	ull rtype;  /* type_t a reference refers too */
+} type_t;
+
+#endif /* _EXTENSION_EPPIC_H */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
