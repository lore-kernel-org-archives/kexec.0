Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e37.co.us.ibm.com ([32.97.110.158])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWSL1-0006Ad-BI
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 13:40:08 +0000
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Thu, 8 Nov 2012 06:40:05 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DA81B1FF001D
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 06:39:59 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qA8DdslI110248
 for <kexec@lists.infradead.org>; Thu, 8 Nov 2012 06:39:55 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qA8Ddr5M008083
 for <kexec@lists.infradead.org>; Thu, 8 Nov 2012 06:39:53 -0700
Subject: [PATCH v2 6/7] Extend eppic built-in functions to include memset
 function
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Thu, 08 Nov 2012 19:09:47 +0530
Message-ID: <20121108133946.28410.8942.stgit@aravinda>
In-Reply-To: <20121108133554.28410.99763.stgit@aravinda>
References: <20121108133554.28410.99763.stgit@aravinda>
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

The memset function will be used to specify the virtual address
and the length of the data to be scrubbed in the dump file from
the eppic macro. makedumpfile will convert these requests into
filter_info nodes which will be enqueued for filtering. Existing
makedumpfile functionality reads the filter_info nodes and scrubs the
data accordingly.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 erase_info.c      |   33 ++++++++++++++++++++++++++++++++-
 erase_info.h      |    1 +
 extension_eppic.c |   20 ++++++++++++++++++++
 extension_eppic.h |    2 ++
 4 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/erase_info.c b/erase_info.c
index 5d4cfd1..3eba12f 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -66,6 +66,8 @@ struct filter_info {
 	int			erase_info_idx;	/* 0= invalid index */
 	int			size_idx;
 
+	int			erase_ch;
+
 	struct filter_info      *next;
 	unsigned short          nullify;
 };
@@ -1574,6 +1576,7 @@ update_filter_info(struct config_entry *filter_symbol,
 	fl_info->paddr   = vaddr_to_paddr(sym_addr);
 	fl_info->size    = size;
 	fl_info->nullify = filter_symbol->nullify;
+	fl_info->erase_ch = 'X';
 
 	if (insert_filter_info(fl_info)) {
 		fl_info->erase_info_idx = add_erase_info_node(filter_symbol);
@@ -1582,6 +1585,34 @@ update_filter_info(struct config_entry *filter_symbol,
 	return TRUE;
 }
 
+int
+update_filter_info_raw(unsigned long long sym_addr, int ch, int len)
+{
+	struct filter_info *fl_info;
+
+	fl_info = calloc(1, sizeof(struct filter_info));
+	if (fl_info == NULL) {
+		ERRMSG("Can't allocate filter info\n");
+		return FALSE;
+	}
+
+	fl_info->vaddr   = sym_addr;
+	fl_info->paddr   = vaddr_to_paddr(sym_addr);
+	fl_info->size    = len;
+	fl_info->nullify = 0;
+	fl_info->erase_ch = ch;
+
+	if (insert_filter_info(fl_info)) {
+		/* TODO
+		 * Add support to update erase information to the
+		 * resulting dump file
+		 */
+		fl_info->erase_info_idx = 0;
+		fl_info->size_idx = 0;
+	}
+	return TRUE;
+}
+
 static int
 initialize_iteration_entry(struct config_entry *ie,
 				char *type_name, unsigned char type_flag)
@@ -2014,7 +2045,7 @@ filter_data_buffer(unsigned char *buf, unsigned long long paddr,
 		if (fl_info.nullify)
 			memset(buf_ptr, 0, fl_info.size);
 		else
-			memset(buf_ptr, 'X', fl_info.size);
+			memset(buf_ptr, fl_info.erase_ch, fl_info.size);
 	}
 }
 
diff --git a/erase_info.h b/erase_info.h
index 0e3c3a3..ec55599 100644
--- a/erase_info.h
+++ b/erase_info.h
@@ -42,6 +42,7 @@ int gather_filter_info(void);
 void clear_filter_info(void);
 void filter_data_buffer(unsigned char *buf, unsigned long long paddr, size_t size);
 unsigned long get_size_eraseinfo(void);
+int update_filter_info_raw(unsigned long long, int, int);
 
 #endif /* _ERASE_INFO_H */
 
diff --git a/extension_eppic.c b/extension_eppic.c
index f2540e1..037c1bf 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -387,6 +387,22 @@ apiops icops = {
 	apifindsym
 };
 
+/* Extensions to built-in functions */
+VALUE_S *
+eppic_memset(VALUE_S *vaddr, VALUE_S *vch, VALUE_S *vlen)
+{
+	ull addr = eppic_getval(vaddr);
+	int len = eppic_getval(vlen);
+	int ch = eppic_getval(vch);
+
+	/*
+	 * Set the value at address from iaddr till iaddr + nbytes
+	 * to the value specified in variable ch
+	 */
+	update_filter_info_raw(addr, ch, len);
+	return eppic_makebtype(1);
+}
+
 
 /* Initialize eppic */
 int
@@ -400,6 +416,10 @@ eppic_init()
 		/* set the new function callback */
 		eppic_setcallback(reg_callback);
 
+		/* Extend built-in functions to include memset */
+		eppic_builtin("int memset(char *, int, int)",
+				(bf_t *)eppic_memset);
+
 		return 0;
 	}
 	return 1;
diff --git a/extension_eppic.h b/extension_eppic.h
index a6ecf40..68ec273 100644
--- a/extension_eppic.h
+++ b/extension_eppic.h
@@ -73,4 +73,6 @@ typedef TYPE_S {
 	ull rtype;  /* type_t a reference refers too */
 } type_t;
 
+extern int update_filter_info_raw(unsigned long long, int, int);
+
 #endif /* _EXTENSION_EPPIC_H */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
