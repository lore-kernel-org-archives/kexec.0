Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjRXt-0000PW-Vy
 for kexec@lists.infradead.org; Fri, 14 Dec 2012 09:27:07 +0000
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 14 Dec 2012 04:27:04 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C898A6E803C
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2012 04:26:56 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBE9Qv9c269526
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2012 04:26:57 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBE9QuSl032078
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2012 04:26:57 -0500
Subject: [PATCH v3 6/7] Extend eppic built-in functions to include memset
 function
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Fri, 14 Dec 2012 14:56:52 +0530
Message-ID: <20121214092652.4854.72806.stgit@aravinda>
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
index 0b6dcf4..cd365b1 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -68,6 +68,8 @@ struct filter_info {
 	int			erase_info_idx;	/* 0= invalid index */
 	int			size_idx;
 
+	int			erase_ch;
+
 	struct filter_info      *next;
 	unsigned short          nullify;
 };
@@ -1576,6 +1578,7 @@ update_filter_info(struct config_entry *filter_symbol,
 	fl_info->paddr   = vaddr_to_paddr(sym_addr);
 	fl_info->size    = size;
 	fl_info->nullify = filter_symbol->nullify;
+	fl_info->erase_ch = 'X';
 
 	if (insert_filter_info(fl_info)) {
 		fl_info->erase_info_idx = add_erase_info_node(filter_symbol);
@@ -1584,6 +1587,34 @@ update_filter_info(struct config_entry *filter_symbol,
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
@@ -2022,7 +2053,7 @@ filter_data_buffer(unsigned char *buf, unsigned long long paddr,
 		if (fl_info.nullify)
 			memset(buf_ptr, 0, fl_info.size);
 		else
-			memset(buf_ptr, 'X', fl_info.size);
+			memset(buf_ptr, fl_info.erase_ch, fl_info.size);
 	}
 }
 
diff --git a/erase_info.h b/erase_info.h
index 636fcfa..2a9c43d 100644
--- a/erase_info.h
+++ b/erase_info.h
@@ -38,6 +38,7 @@ int gather_filter_info(void);
 void clear_filter_info(void);
 void filter_data_buffer(unsigned char *buf, unsigned long long paddr, size_t size);
 unsigned long get_size_eraseinfo(void);
+int update_filter_info_raw(unsigned long long, int, int);
 
 #endif /* _ERASE_INFO_H */
 
diff --git a/extension_eppic.c b/extension_eppic.c
index 8d0027f..85dfdcd 100644
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
@@ -400,6 +416,10 @@ _init()
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
index 15d7efc..0a53646 100644
--- a/extension_eppic.h
+++ b/extension_eppic.h
@@ -70,4 +70,6 @@ typedef TYPE_S {
 	ull rtype;  /* type_t a reference refers too */
 } type_t;
 
+extern int update_filter_info_raw(unsigned long long, int, int);
+
 #endif /* _EXTENSION_EPPIC_H */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
