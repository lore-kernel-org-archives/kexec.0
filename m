Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ScD8q-0005yK-Ug
 for kexec@lists.infradead.org; Wed, 06 Jun 2012 10:07:05 +0000
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 6 Jun 2012 04:07:03 -0600
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 61A00C90057
 for <kexec@lists.infradead.org>; Wed,  6 Jun 2012 06:07:00 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q56A70TS120720
 for <kexec@lists.infradead.org>; Wed, 6 Jun 2012 06:07:00 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q56A6vw4012548
 for <kexec@lists.infradead.org>; Wed, 6 Jun 2012 07:07:00 -0300
Subject: [PATCH 6/7] Extend eppic built-in functions to include memset function
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Wed, 06 Jun 2012 15:36:52 +0530
Message-ID: <20120606100652.12534.58807.stgit@aravinda>
In-Reply-To: <20120606095709.12534.63967.stgit@aravinda>
References: <20120606095709.12534.63967.stgit@aravinda>
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
To: kexec@lists.infradead.org
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, buendgen@de.ibm.com

The memset function will be used to specify the virtual address
and the length of the data to be scrubbed in the dump file from
the eppic macro. makedumpfile will convert these requests into
filter_info nodes which will be enqueued for filtering. Existing
makedumpfile functionality reads the filter_info nodes and scrubs the
data accordingly.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 erase_info.c      |   32 +++++++++++++++++++++++++++++++-
 erase_info.h      |    1 +
 extension_eppic.c |   19 +++++++++++++++++++
 extension_eppic.h |    2 ++
 4 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/erase_info.c b/erase_info.c
index d301f20..79baecc 100644
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
@@ -1582,6 +1585,33 @@ update_filter_info(struct config_entry *filter_symbol,
 	return TRUE;
 }
 
+int
+update_filter_info_raw(unsigned long long sym_addr, int ch, int len)
+{
+	struct filter_info *fl_info;
+
+	if ((fl_info = calloc(1, sizeof(struct filter_info))) == NULL) {
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
@@ -2004,7 +2034,7 @@ filter_data_buffer(unsigned char *buf, unsigned long long paddr,
 		if (fl_info.nullify)
 			memset(buf_ptr, 0, fl_info.size);
 		else
-			memset(buf_ptr, 'X', fl_info.size);
+			memset(buf_ptr, fl_info.erase_ch, fl_info.size);
 	}
 }
 
diff --git a/erase_info.h b/erase_info.h
index 2dc8b88..499d12c 100644
--- a/erase_info.h
+++ b/erase_info.h
@@ -40,6 +40,7 @@ int gather_filter_info(void);
 void clear_filter_info(void);
 void filter_data_buffer(unsigned char *buf, unsigned long long paddr, size_t size);
 unsigned long get_size_eraseinfo(void);
+int update_filter_info_raw(unsigned long long, int, int);
 
 #endif /* _ERASE_INFO_H */
 
diff --git a/extension_eppic.c b/extension_eppic.c
index 0f9e3c2..826f860 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -382,6 +382,22 @@ apiops icops = {
 	apifindsym
 };
 
+/* Extensions to built-in functions */
+VALUE_S *
+eppic_memset(VALUE_S* vaddr, VALUE_S* vch, VALUE_S* vlen)
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
@@ -395,6 +411,9 @@ eppic_init()
 		/* set the new function callback */
 		eppic_setcallback(reg_callback);
 
+		/* Extend built-in functions to include memset */
+		eppic_builtin("int memset(char*, int, int)", (bf_t*)eppic_memset);
+
 		return 0;
 	}
 	return 1;
diff --git a/extension_eppic.h b/extension_eppic.h
index 805015a..5827a8a 100644
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
