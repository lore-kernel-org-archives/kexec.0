Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by casper.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dcEcr-0007Iq-Kl
 for kexec@lists.infradead.org; Mon, 31 Jul 2017 17:37:07 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [makedumpfile PATCH] Wipe excluded pages that are written into ELF
 dump file
Date: Mon, 31 Jul 2017 06:35:30 -0700
Message-Id: <1501508130-27022-1-git-send-email-eric.devolder@oracle.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, ats-kumagai@wm.jp.nec.com
Cc: daniel.kiper@oracle.com, eric.devolder@oracle.com, konrad.wilk@oracle.com

When a page is excluded by any of the existing dump levels,
that page may still be written to the ELF dump file, depending
upon the PFN_EXCLUDED mechanism.

The PFN_EXCLUDED mechanism looks for N consecutive "not
dumpable" pages, and if found, the current ELF segment is
closed out and a new ELF segment started, at the next dumpable
page. Otherwise, if the PFN_EXCLUDED criteria is not meet (that
is, there is a mix of dumpable and not dumpable pages, but not
N consecutive not dumpable pages) all pages are written to the
dump file.

This patch implements a mechanism for those "not dumpable" pages
that are written to the ELF dump file to fill those pages with
constant data, rather than the original data. In other words,
the dump file still contains the page, but its data is wiped.

The motivation for doing this is to protect real user (customer)
data from "leaking" through to a dump file when that data was
intended to be omitted.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 makedumpfile.8 |  8 ++++++++
 makedumpfile.c | 32 +++++++++++++++++++++++++-------
 makedumpfile.h |  2 ++
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index f94f2d7..64af0cf 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -621,6 +621,14 @@ order from left to right.  \fIVMCORE\fRs are assembled into a single
 # makedumpfile \-x vmlinux \-\-diskset=vmcore1 \-\-diskset=vmcore2 dumpfile
 
 .TP
+\fB\-\-fill-excluded-pages FILL_VALUE\fR
+For the ELF dump file format, excluded pages may be written into the dump
+file, but the page contents are wiped. This option allows the wipe value
+to be changed from the default 0x5041474557495045UL "PAGEWIPE", or on
+32-bit systems "WIPE".
+
+
+.TP
 \fB\-D\fR
 Print debugging message.
 
diff --git a/makedumpfile.c b/makedumpfile.c
index f85003a..cee0ab0 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7139,7 +7139,7 @@ out:
 
 int
 write_elf_load_segment(struct cache_data *cd_page, unsigned long long paddr,
-		       off_t off_memory, long long size)
+		       off_t off_memory, long long size, struct cycle *cycle)
 {
 	long page_size = info->page_size;
 	long long bufsz_write;
@@ -7163,10 +7163,23 @@ write_elf_load_segment(struct cache_data *cd_page, unsigned long long paddr,
 		else
 			bufsz_write = size;
 
-		if (read(info->fd_memory, buf, bufsz_write) != bufsz_write) {
-			ERRMSG("Can't read the dump memory(%s). %s\n",
-			    info->name_memory, strerror(errno));
-			return FALSE;
+		if (!is_dumpable(info->bitmap2, paddr_to_pfn(paddr), cycle)) {
+			unsigned k;
+			unsigned long *p = (unsigned long *)buf;
+			for (k = 0; k < info->page_size; k += sizeof(unsigned long)) {
+				*p++ = info->fill_excluded_pages_value;
+			}
+			if (lseek(info->fd_memory, bufsz_write, SEEK_CUR) < 0) {
+				ERRMSG("Can't seek the dump memory(%s). %s\n",
+				    info->name_memory, strerror(errno));
+				return FALSE;
+			}
+		} else {
+			if (read(info->fd_memory, buf, bufsz_write) != bufsz_write) {
+				ERRMSG("Can't read the dump memory(%s). %s\n",
+				    info->name_memory, strerror(errno));
+				return FALSE;
+			}
 		}
 		filter_data_buffer((unsigned char *)buf, paddr, bufsz_write);
 		paddr += bufsz_write;
@@ -7431,7 +7444,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 				 */
 				if (load.p_filesz)
 					if (!write_elf_load_segment(cd_page, paddr,
-								    off_memory, load.p_filesz))
+								    off_memory, load.p_filesz, &cycle))
 						return FALSE;
 
 				load.p_paddr += load.p_memsz;
@@ -7473,7 +7486,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 		 */
 		if (load.p_filesz)
 			if (!write_elf_load_segment(cd_page, paddr,
-						    off_memory, load.p_filesz))
+						    off_memory, load.p_filesz, &cycle))
 				return FALSE;
 
 		off_seg_load += load.p_filesz;
@@ -11057,6 +11070,7 @@ static struct option longopts[] = {
 	{"splitblock-size", required_argument, NULL, OPT_SPLITBLOCK_SIZE},
 	{"work-dir", required_argument, NULL, OPT_WORKING_DIR},
 	{"num-threads", required_argument, NULL, OPT_NUM_THREADS},
+	{"fill-excluded-pages", required_argument, NULL, OPT_FILL_EXCLUDED_PAGES},
 	{0, 0, 0, 0}
 };
 
@@ -11083,6 +11097,7 @@ main(int argc, char *argv[])
 	info->fd_dumpfile = -1;
 	info->fd_bitmap = -1;
 	info->kaslr_offset = 0;
+	info->fill_excluded_pages_value = 0x5041474557495045UL;
 	initialize_tables();
 
 	/*
@@ -11218,6 +11233,9 @@ main(int argc, char *argv[])
 		case OPT_NUM_THREADS:
 			info->num_threads = MAX(atoi(optarg), 0);
 			break;
+		case OPT_FILL_EXCLUDED_PAGES:
+			info->fill_excluded_pages_value = strtoul(optarg, NULL, 0);
+			break;
 		case '?':
 			MSG("Commandline parameter is invalid.\n");
 			MSG("Try `makedumpfile --help' for more information.\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index 8a05794..9ccd06d 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1266,6 +1266,7 @@ struct DumpInfo {
 	int		vmemmap_cnt;
 	struct ppc64_vmemmap	*vmemmap_list;
 	unsigned long	kaslr_offset;
+	unsigned long	fill_excluded_pages_value; /* fill value for excluded pages */
 
 	/*
 	 * page table info for ppc64
@@ -2275,6 +2276,7 @@ struct elf_prstatus {
 #define OPT_WORKING_DIR         OPT_START+15
 #define OPT_NUM_THREADS	OPT_START+16
 #define OPT_PARTIAL_DMESG	OPT_START+17
+#define OPT_FILL_EXCLUDED_PAGES	OPT_START+18
 
 /*
  * Function Prototype.
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
