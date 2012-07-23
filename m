Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat.scz.novell.com ([213.151.88.252] helo=nathan.suse.cz)
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1StHdQ-0001nZ-DQ
 for kexec@lists.infradead.org; Mon, 23 Jul 2012 12:21:14 +0000
Message-Id: <20120723113254.321050806@suse.cz>
Date: Mon, 23 Jul 2012 13:32:45 +0200
From: ptesarik@suse.cz
Subject: [PATCH 1/8] Read the Xen crash ELF note into memory at startup
References: <20120723113244.751777873@suse.cz>
Content-Disposition: inline; filename=makedumpfile-crash_xen_info_t.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Petr Tesarik <ptesarik@suse.cz>

Instead of seeking individual fields inside the ELF note, copy the
corresponding struct type from the Xen sources, so people can understand
why the code does what it does.

This is mainly a cleanup patch to improve maintainability, but it also
simplifies reusing the crash note data from other places.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 elf_info.c     |   45 +++++++++++++++++++++++++++++----------------
 elf_info.h     |   38 +++++++++++++++++++++++++++++++++++++-
 makedumpfile.c |   28 ++++++++--------------------
 makedumpfile.h |    2 --
 4 files changed, 74 insertions(+), 39 deletions(-)

--- a/elf_info.c
+++ b/elf_info.c
@@ -86,9 +86,8 @@ static unsigned long		size_eraseinfo;
 /*
  * Xen information:
  */
-static off_t			offset_xen_crash_info;
+static void			*xen_crash_info;
 static unsigned long		size_xen_crash_info;
-static unsigned long		xen_p2m_mfn;
 
 
 /*
@@ -292,8 +291,7 @@ static int
 get_pt_note_info(void)
 {
 	int n_type, size_desc;
-	unsigned long p2m_mfn;
-	off_t offset, offset_desc, off_p2m = 0;
+	off_t offset, offset_desc;
 	char buf[VMCOREINFO_XEN_NOTE_NAME_BYTES];
 	char note[MAX_SIZE_NHDR];
 
@@ -346,23 +344,25 @@ get_pt_note_info(void)
 		 */
 		} else if (n_type == XEN_ELFNOTE_CRASH_INFO) {
 			flags_memory |= MEMORY_XEN;
-			offset_xen_crash_info = offset_desc;
 			size_xen_crash_info   = size_desc;
+			xen_crash_info = malloc(size_desc);
+			if (!xen_crash_info) {
+				ERRMSG("Can't allocate note (%d bytes). %s\n",
+				    size_desc, strerror(errno));
+				return FALSE;
+			}
 
-			off_p2m = offset + offset_next_note(note)
-					 - sizeof(p2m_mfn);
-			if (lseek(fd_memory, off_p2m, SEEK_SET) < 0){
+			if (lseek(fd_memory, offset_desc, SEEK_SET) < 0) {
 				ERRMSG("Can't seek the dump memory(%s). %s\n",
 				    name_memory, strerror(errno));
 				return FALSE;
 			}
-			if (read(fd_memory, &p2m_mfn, sizeof(p2m_mfn))
-			     != sizeof(p2m_mfn)) {
+			if (read(fd_memory, xen_crash_info, size_desc)
+			    != size_desc) {
 				ERRMSG("Can't read the dump memory(%s). %s\n",
 				    name_memory, strerror(errno));
 				return FALSE;
 			}
-			xen_p2m_mfn = p2m_mfn;
 
 		/*
 		 * Check whether a source dumpfile contains eraseinfo.
@@ -826,13 +826,12 @@ get_vmcoreinfo_xen(off_t *offset, unsign
 		*size   = size_vmcoreinfo_xen;
 }
 
-void
-get_xen_crash_info(off_t *offset, unsigned long *size)
+void *
+get_xen_crash_info(unsigned long *size)
 {
-	if (offset)
-		*offset = offset_xen_crash_info;
 	if (size)
 		*size   = size_xen_crash_info;
+	return xen_crash_info;
 }
 
 int
@@ -859,9 +858,23 @@ set_eraseinfo(off_t offset, unsigned lon
 	size_eraseinfo   = size;
 }
 
+#if defined(__ia64__)
+#define p2m_mfn dom0_mm_pgd_mfn
+#else
+#define p2m_mfn dom0_pfn_to_mfn_frame_list_list
+#endif
+
 unsigned long
 get_xen_p2m_mfn(void)
 {
-	return xen_p2m_mfn;
+#if defined(__x86__) || defined(__x86_64__) || defined(__ia64__)
+	if (xen_crash_info) {
+		if (size_xen_crash_info >= sizeof(crash_xen_info_v2_t))
+			return ((crash_xen_info_v2_t*)xen_crash_info)->p2m_mfn;
+		if (size_xen_crash_info >= sizeof(crash_xen_info_t))
+			return ((crash_xen_info_t*)xen_crash_info)->p2m_mfn;
+	}
+#endif
+	return 0;
 }
 
--- a/elf_info.h
+++ b/elf_info.h
@@ -24,6 +24,42 @@
 
 #define MAX_SIZE_NHDR	MAX(sizeof(Elf64_Nhdr), sizeof(Elf32_Nhdr))
 
+typedef struct {
+	unsigned long xen_major_version;
+	unsigned long xen_minor_version;
+	unsigned long xen_extra_version;
+	unsigned long xen_changeset;
+	unsigned long xen_compiler;
+	unsigned long xen_compile_date;
+	unsigned long xen_compile_time;
+	unsigned long tainted;
+} crash_xen_info_common_t;
+
+typedef struct {
+	crash_xen_info_common_t c;
+#if defined(__x86__) || defined(__x86_64__)
+	/* added by changeset 2b43fb3afb3e: */
+	unsigned long dom0_pfn_to_mfn_frame_list_list;
+#endif
+#if defined(__ia64__)
+	/* added by changeset d7c3b12014b3: */
+	unsigned long dom0_mm_pgd_mfn;
+#endif
+} crash_xen_info_t;
+
+/* changeset 439a3e9459f2 added xen_phys_start
+ * to the middle of the struct... */
+typedef struct {
+	crash_xen_info_common_t c;
+#if defined(__x86__) || defined(__x86_64__)
+	unsigned long xen_phys_start;
+	unsigned long dom0_pfn_to_mfn_frame_list_list;
+#endif
+#if defined(__ia64__)
+	unsigned long dom0_mm_pgd_mfn;
+#endif
+} crash_xen_info_v2_t;
+
 
 off_t paddr_to_offset(unsigned long long paddr);
 off_t paddr_to_offset2(unsigned long long paddr, off_t hint);
@@ -62,7 +98,7 @@ void get_vmcoreinfo(off_t *offset, unsig
 
 int has_vmcoreinfo_xen(void);
 void get_vmcoreinfo_xen(off_t *offset, unsigned long *size);
-void get_xen_crash_info(off_t *offset, unsigned long *size);
+void *get_xen_crash_info(unsigned long *size);
 
 int has_eraseinfo(void);
 void get_eraseinfo(off_t *offset, unsigned long *size);
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5315,30 +5315,18 @@ get_structure_info_xen(void)
 int
 get_xen_phys_start(void)
 {
-	off_t offset, offset_xen_crash_info;
-	unsigned long xen_phys_start, size_xen_crash_info;
-	const off_t failed = (off_t)-1;
+	unsigned long size_xen_crash_info;
+	crash_xen_info_v2_t *xen_crash_info;
 
 	if (info->xen_phys_start)
 		return TRUE;
 
-	get_xen_crash_info(&offset_xen_crash_info, &size_xen_crash_info);
-	if (size_xen_crash_info >= SIZE_XEN_CRASH_INFO_V2) {
-		offset = offset_xen_crash_info + size_xen_crash_info
-			 - sizeof(unsigned long) * 2;
-		if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
-			ERRMSG("Can't seek the dump memory(%s). %s\n",
-			    info->name_memory, strerror(errno));
-			return FALSE;
-		}
-		if (read(info->fd_memory, &xen_phys_start, sizeof(unsigned long))
-		    != sizeof(unsigned long)) {
-			ERRMSG("Can't read the dump memory(%s). %s\n",
-			    info->name_memory, strerror(errno));
-			return FALSE;
-		}
-		info->xen_phys_start = xen_phys_start;
-	}
+#if defined(__x86__) || defined(__x86_64__)
+	xen_crash_info = get_xen_crash_info(&size_xen_crash_info);
+	if (xen_crash_info &&
+	    size_xen_crash_info >= sizeof(crash_xen_info_v2_t))
+		info->xen_phys_start = xen_crash_info->xen_phys_start;
+#endif
 
 	return TRUE;
 }
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -416,8 +416,6 @@ do { \
 #define SIZE_BUF_STDIN	(4096)
 #define STRLEN_OSRELEASE (65)	/* same length as diskdump.h */
 
-#define SIZE_XEN_CRASH_INFO_V2	(sizeof(unsigned long) * 10)
-
 /*
  * The value of dependence on machine
  */



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
