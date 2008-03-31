Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JgBbA-0007WT-9G
	for kexec@lists.infradead.org; Mon, 31 Mar 2008 04:26:21 +0000
Date: Mon, 31 Mar 2008 13:26:19 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: [PATCH 4/4] extract vmcoreinfo from /proc/vmcore for Xen
Message-Id: <20080331132027.DDD3.ODA@valinux.co.jp>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xen-devel@lists.xensource.com
Cc: kexec@lists.infradead.org

This patch is for makedumpfile-1.2.4.

--- makedumpfile.c.org	2008-03-25 13:35:03.000000000 +0900
+++ makedumpfile.c	2008-03-27 11:32:03.000000000 +0900
@@ -2389,7 +2389,7 @@
 	off_t offset, off_note;
 	int flag_elf64;
 	unsigned long sz_note;
-	char buf[VMCOREINFO_NOTE_NAME_BYTES];
+	char buf[VMCOREINFO_XEN_NOTE_NAME_BYTES];
 	Elf64_Nhdr note64;
 	Elf32_Nhdr note32;
 
@@ -2430,30 +2430,40 @@
 			    info->name_memory, strerror(errno));
 			return FALSE;
 		}
-		if (strncmp(VMCOREINFO_NOTE_NAME, buf,
+		if (!strncmp(VMCOREINFO_XEN_NOTE_NAME, buf,
+		    VMCOREINFO_XEN_NOTE_NAME_BYTES)) { /* must be first */
+			if (flag_elf64) {
+				info->offset_vmcoreinfo_xen = offset + (sizeof(note64)
+				    + ((note64.n_namesz + 3) & ~3));
+				info->size_vmcoreinfo_xen = note64.n_descsz;
+			} else {
+				info->offset_vmcoreinfo_xen = offset + (sizeof(note32)
+				    + ((note32.n_namesz + 3) & ~3));
+				info->size_vmcoreinfo_xen = note32.n_descsz;
+			}
+			(*flag_found) |= VMCOREINFO_XEN;
+		} else if (!strncmp(VMCOREINFO_NOTE_NAME, buf,
 		    VMCOREINFO_NOTE_NAME_BYTES)) {
 			if (flag_elf64) {
-				offset += sizeof(Elf64_Nhdr)
-				    + ((note64.n_namesz + 3) & ~3)
-				    + ((note64.n_descsz + 3) & ~3);
+				info->offset_vmcoreinfo = offset + (sizeof(note64)
+				    + ((note64.n_namesz + 3) & ~3));
+				info->size_vmcoreinfo = note64.n_descsz;
 			} else {
-				offset += sizeof(Elf32_Nhdr)
-				    + ((note32.n_namesz + 3) & ~3)
-				    + ((note32.n_descsz + 3) & ~3);
+				info->offset_vmcoreinfo = offset + (sizeof(note32)
+				    + ((note32.n_namesz + 3) & ~3));
+				info->size_vmcoreinfo = note32.n_descsz;
 			}
-			continue;
+			(*flag_found) |= VMCOREINFO_LINUX;
 		}
 		if (flag_elf64) {
-			info->offset_vmcoreinfo = offset + (sizeof(note64)
-			    + ((note64.n_namesz + 3) & ~3));
-			info->size_vmcoreinfo = note64.n_descsz;
+			offset += sizeof(Elf64_Nhdr)
+			    + ((note64.n_namesz + 3) & ~3)
+			    + ((note64.n_descsz + 3) & ~3);
 		} else {
-			info->offset_vmcoreinfo = offset + (sizeof(note32)
-			    + ((note32.n_namesz + 3) & ~3));
-			info->size_vmcoreinfo = note32.n_descsz;
+			offset += sizeof(Elf32_Nhdr)
+			    + ((note32.n_namesz + 3) & ~3)
+			    + ((note32.n_descsz + 3) & ~3);
 		}
-		(*flag_found) = TRUE;
-		break;
 	}
 	return TRUE;
 }
@@ -2501,6 +2511,46 @@
 	return TRUE;
 }
 
+int
+copy_vmcoreinfo_xen()
+{
+	int fd;
+	char buf[VMCOREINFO_BYTES];
+	const off_t failed = (off_t)-1;
+
+	if (!info->offset_vmcoreinfo_xen || !info->size_vmcoreinfo_xen)
+		return FALSE;
+
+	if ((fd = mkstemp(info->name_vmcoreinfo)) < 0) {
+		ERRMSG("Can't open the vmcoreinfo file(%s). %s\n",
+		    info->name_vmcoreinfo, strerror(errno));
+		return FALSE;
+	}
+	if (lseek(info->fd_memory, info->offset_vmcoreinfo_xen, SEEK_SET)
+	    == failed) {
+		ERRMSG("Can't seek the dump memory(%s). %s\n",
+		    info->name_memory, strerror(errno));
+		return FALSE;
+	}
+	if (read(info->fd_memory, &buf, info->size_vmcoreinfo_xen)
+	    != info->size_vmcoreinfo_xen) {
+		ERRMSG("Can't read the dump memory(%s). %s\n",
+		    info->name_memory, strerror(errno));
+		return FALSE;
+	}
+	if (write(fd, &buf, info->size_vmcoreinfo_xen) != info->size_vmcoreinfo_xen) {
+		ERRMSG("Can't write the vmcoreinfo file(%s). %s\n",
+		    info->name_vmcoreinfo, strerror(errno));
+		return FALSE;
+	}
+	if (close(fd) < 0) {
+		ERRMSG("Can't close the vmcoreinfo file(%s). %s\n",
+		    info->name_vmcoreinfo, strerror(errno));
+		return FALSE;
+	}
+	return TRUE;
+}
+
 /*
  * Get the number of online nodes.
  */
@@ -3182,8 +3232,6 @@
 int
 initial()
 {
-	int vmcoreinfo_in_vmcore = FALSE;
-
 	if (!get_elf_info())
 		return FALSE;
 
@@ -3208,48 +3256,8 @@
 
 		if (!get_srcfile_info())
 			return FALSE;
-	/*
-	 * Get the debug information for analysis from /proc/vmcore
-	 */
-	} else {
-		/*
-		 * Check whether /proc/vmcore contains vmcoreinfo,
-		 * and get both the offset and the size.
-		 */
-		if (!is_vmcoreinfo_in_vmcore(&vmcoreinfo_in_vmcore))
-			return FALSE;
-
-		if (!vmcoreinfo_in_vmcore) {
-			if (info->dump_level <= DL_EXCLUDE_ZERO)
-				goto out;
-
-			MSG("%s doesn't contain vmcoreinfo.\n",
-			    info->name_memory);
-			MSG("'-x' or '-i' must be specified.\n");
-			return FALSE;
-		}
-		/*
-		 * Copy vmcoreinfo to /tmp/vmcoreinfoXXXXXX.
-		 */
-		if ((info->name_vmcoreinfo
-		    = malloc(sizeof(FILENAME_VMCOREINFO))) == NULL) {
-			ERRMSG("Can't allocate memory for the name(%s). %s\n",
-			    FILENAME_VMCOREINFO, strerror(errno));
-			return FALSE;
-		}
-		strcpy(info->name_vmcoreinfo, FILENAME_VMCOREINFO);
-		if (!copy_vmcoreinfo())
-			return FALSE;
-		/*
-		 * Read vmcoreinfo from /tmp/vmcoreinfoXXXXXX.
-		 */
-		if (!open_vmcoreinfo("r"))
-			return FALSE;
-		if (!read_vmcoreinfo())
-			return FALSE;
-		unlink(info->name_vmcoreinfo);
 	}
-out:
+
 	if (info->dump_level <= DL_EXCLUDE_ZERO) {
 		if (!get_mem_map_without_mm())
 			return FALSE;
@@ -5880,6 +5888,7 @@
 main(int argc, char *argv[])
 {
 	int opt, flag_debug = FALSE;
+	int vmcoreinfo_in_vmcore = FALSE;
 
 	if ((info = calloc(1, sizeof(struct DumpInfo))) == NULL) {
 		ERRMSG("Can't allocate memory for the pagedesc cache. %s.\n",
@@ -6043,6 +6052,39 @@
 			print_usage();
 			goto out;
 		}
+		if (!info->flag_vmlinux && !info->flag_read_vmcoreinfo
+		    && !info->flag_rearrange) {
+			if (!open_dump_memory())
+				goto out;
+			if (!is_vmcoreinfo_in_vmcore(&vmcoreinfo_in_vmcore))
+				goto out;
+			if (!vmcoreinfo_in_vmcore && info->dump_level > DL_EXCLUDE_ZERO) {
+				MSG("%s doesn't contain vmcoreinfo.\n",
+				    info->name_memory);
+				MSG("'-x' or '-i' must be specified.\n");
+				goto out;
+			}
+			/*
+			 * Copy vmcoreinfo to /tmp/vmcoreinfoXXXXXX.
+			 */
+			if ((info->name_vmcoreinfo
+			    = malloc(sizeof(FILENAME_VMCOREINFO))) == NULL) {
+				ERRMSG("Can't allocate memory for the name(%s). %s\n",
+				    FILENAME_VMCOREINFO, strerror(errno));
+				goto out;
+			}
+			strcpy(info->name_vmcoreinfo, FILENAME_VMCOREINFO);
+			if (vmcoreinfo_in_vmcore & VMCOREINFO_XEN) {
+				info->flag_xen = 1;
+				if (!copy_vmcoreinfo_xen())
+					goto out;
+			} else {
+				if (!copy_vmcoreinfo())
+					goto out;
+			}
+			info->flag_read_vmcoreinfo = 1;
+			close_dump_memory();
+		}
 	}
 
 	if (elf_version(EV_CURRENT) == EV_NONE ) {
@@ -6081,7 +6123,8 @@
 			goto out;
 		}
 		info->dump_level |= DL_EXCLUDE_XEN;
-		return handle_xen();
+		retcd = handle_xen();
+		goto out;
 
 	} else if (info->flag_rearrange) {
 		if (!open_files_for_rearranging_dumpdata())
@@ -6155,6 +6198,9 @@
 		free(info->mem_map_data);
 	if (info->dump_header != NULL)
 		free(info->dump_header);
+	if (vmcoreinfo_in_vmcore && info->name_vmcoreinfo) {
+		unlink(info->name_vmcoreinfo);
+	}
 	if (info != NULL)
 		free(info);
 
--- makedumpfile.h.org	2008-03-25 13:35:19.000000000 +0900
+++ makedumpfile.h	2008-03-25 14:29:33.000000000 +0900
@@ -430,7 +430,11 @@
 #define VMCOREINFO_BYTES		(4096)
 #define VMCOREINFO_NOTE_NAME		"VMCOREINFO"
 #define VMCOREINFO_NOTE_NAME_BYTES	(sizeof(VMCOREINFO_NOTE_NAME))
+#define VMCOREINFO_XEN_NOTE_NAME	"VMCOREINFO_XEN"
+#define VMCOREINFO_XEN_NOTE_NAME_BYTES	(sizeof(VMCOREINFO_XEN_NOTE_NAME))
 #define FILENAME_VMCOREINFO		"/tmp/vmcoreinfoXXXXXX"
+#define VMCOREINFO_LINUX	(0x01)
+#define VMCOREINFO_XEN		(0x02)
 
 /*
  * field name of vmcoreinfo file
@@ -762,6 +766,8 @@
 	 */
 	off_t			offset_vmcoreinfo;
 	unsigned long		size_vmcoreinfo;
+	off_t			offset_vmcoreinfo_xen;
+	unsigned long		size_vmcoreinfo_xen;
 
 	/*
 	 * for Xen extraction

-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
