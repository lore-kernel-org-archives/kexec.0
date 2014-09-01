Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XOI7s-0001Ja-VW
 for kexec@lists.infradead.org; Mon, 01 Sep 2014 03:17:53 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 8/8] add a new interface to show the memory usage of 1st
 kernel
Date: Mon,  1 Sep 2014 11:15:40 +0800
Message-Id: <1409541340-2719-9-git-send-email-bhe@redhat.com>
In-Reply-To: <1409541340-2719-1-git-send-email-bhe@redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
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
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, Baoquan He <bhe@redhat.com>, vgoyal@redhat.com

Recently people complained that they don't know how to decide how
much disk size need be reserved for kdump. E.g there are lots of
machines with different memory size, if the memory usage information
of current system can be shown, that can help them to make an estimate
how much storage space need be reserved.

In this patch, a new interface is added into makedumpfile. By the
help of this, people can know the page number of memory in different
use. The implementation is analyzing the "System Ram" and "kernel text"
program segment of /proc/kcore excluding the crashkernel range, then
calculating the page number of different kind per vmcoreinfo.

The print is like below:

~$ ./makedumpfile --mem-usage /proc/kcore
The kernel version is not supported.
The makedumpfile operation may be incomplete.
Excluding unnecessary pages        : [100.0 %] |

----------------------------------------------------------------------
TYPE		PAGES			EXCLUDABLE	DESCRIPTION
ZERO		28823           	yes		Pages filled with zero
CACHE		197932          	yes		Cache pages
CACHE_PRIVATE	15862           	yes		Cache pages + private
USER		30778           	yes		User process pages
FREE		3671105         	yes		Free pages
KERN_DATA	105168          	no		Dumpable kernel data

Total pages on system:	4049668

makedumpfile Completed.

BTW, in formal version of kernel which maintainer declares to support
after sufficient test, the warning message about kernel version won't
occur.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.8 | 17 ++++++++++++++
 makedumpfile.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 makedumpfile.h |  2 ++
 print_info.c   |  8 +++++++
 4 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 25fe74e..64abbc7 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -532,6 +532,23 @@ it is necessary to specfiy [\-x \fIVMLINUX\fR] or [\-i \fIVMCOREINFO\fR].
 # makedumpfile \-\-dump-dmesg -x vmlinux /proc/vmcore dmesgfile
 .br
 
+
+.TP
+\fB\-\-mem-usage\fR
+This option is used to show the page numbers of current system in different
+use. It should be executed in 1st kernel. By the help of this, user can know
+how many pages is dumpable when different dump_level is specified. It analyzes
+the 'System Ram' and 'kernel text' program segment of /proc/kcore excluding
+the crashkernel range, then calculates the page number of different kind per
+vmcoreinfo. So currently /proc/kcore need be specified explicitly.
+
+.br
+.B Example:
+.br
+# makedumpfile \-\-mem-usage /proc/kcore
+.br
+
+
 .TP
 \fB\-\-diskset=VMCORE\fR
 Specify multiple \fIVMCORE\fRs created on sadump diskset configuration
diff --git a/makedumpfile.c b/makedumpfile.c
index c3d45de..a9d0e63 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -707,7 +707,7 @@ get_kernel_version(char *release)
 
 	if ((version < OLDEST_VERSION) || (LATEST_VERSION < version)) {
 		MSG("The kernel version is not supported.\n");
-		MSG("The created dumpfile may be incomplete.\n");
+		MSG("The makedumpfile operation may be incomplete.\n");
 	}
 
 	return version;
@@ -9007,6 +9007,13 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
 		 */
 		info->name_memory   = argv[optind];
 
+	} else if ((argc == optind + 1) && info->flag_mem_usage) {
+		/*
+		* Parameter for showing the page number of memory
+		* in different use from.
+		*/
+		info->name_memory   = argv[optind];
+
 	} else
 		return FALSE;
 
@@ -9251,6 +9258,58 @@ static int get_sys_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
 	return TRUE;
 }
 
+int show_mem_usage(void)
+{
+        uint64_t vmcoreinfo_addr, vmcoreinfo_len;
+
+        if (!is_crashkernel_mem_reserved()) {
+                ERRMSG("No memory is reserved for crashkenrel!\n");
+                return FALSE;
+        }
+
+
+        if (!info->flag_cyclic)
+                info->flag_cyclic = TRUE;
+
+	info->dump_level = MAX_DUMP_LEVEL;
+
+        if (!get_page_offset())
+                return FALSE;
+
+        if (!open_dump_memory())
+                return FALSE;
+
+        if (!get_elf_loads(info->fd_memory, info->name_memory))
+                return FALSE;
+
+        if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
+                return FALSE;
+
+        if (!set_kcore_vmcoreinfo(vmcoreinfo_addr, vmcoreinfo_len))
+                return FALSE;
+
+        if (!get_kcore_dump_loads())
+                return FALSE;
+
+        if (!initial())
+                return FALSE;
+
+
+        if (!prepare_bitmap2_buffer_cyclic())
+                return FALSE;
+
+        info->num_dumpable = get_num_dumpable_cyclic();
+
+	free_bitmap2_buffer_cyclic();
+
+        print_mem_usage();
+
+        if (!close_files_for_creating_dumpfile())
+                return FALSE;
+
+        return TRUE;
+}
+
 
 static struct option longopts[] = {
 	{"split", no_argument, NULL, OPT_SPLIT},
@@ -9268,6 +9327,7 @@ static struct option longopts[] = {
 	{"cyclic-buffer", required_argument, NULL, OPT_CYCLIC_BUFFER},
 	{"eppic", required_argument, NULL, OPT_EPPIC},
 	{"non-mmap", no_argument, NULL, OPT_NON_MMAP},
+	{"mem-usage", no_argument, NULL, OPT_MEM_USAGE},
 	{0, 0, 0, 0}
 };
 
@@ -9359,6 +9419,9 @@ main(int argc, char *argv[])
 		case OPT_DUMP_DMESG:
 			info->flag_dmesg = 1;
 			break;
+		case OPT_MEM_USAGE:
+                       info->flag_mem_usage = 1;
+                       break;
 		case OPT_COMPRESS_SNAPPY:
 			info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
 			break;
@@ -9499,6 +9562,15 @@ main(int argc, char *argv[])
 
 		MSG("\n");
 		MSG("The dmesg log is saved to %s.\n", info->name_dumpfile);
+	} else if (info->flag_mem_usage) {
+		if (!check_param_for_creating_dumpfile(argc, argv)) {
+			MSG("Commandline parameter is invalid.\n");
+			MSG("Try `makedumpfile --help' for more information.\n");
+			goto out;
+		}
+
+		if (!show_mem_usage())
+			goto out;
 	} else {
 		if (!check_param_for_creating_dumpfile(argc, argv)) {
 			MSG("Commandline parameter is invalid.\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index e83bd95..6ee4cae 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -978,6 +978,7 @@ struct DumpInfo {
 	int		flag_force;	     /* overwrite existing stuff */
 	int		flag_exclude_xen_dom;/* exclude Domain-U from xen-kdump */
 	int             flag_dmesg;          /* dump the dmesg log out of the vmcore file */
+	int             flag_mem_usage;  /*show the page number of memory in different use*/
 	int		flag_use_printk_log; /* did we read printk_log symbol name? */
 	int		flag_nospace;	     /* the flag of "No space on device" error */
 	int		flag_vmemmap;        /* kernel supports vmemmap address space */
@@ -1867,6 +1868,7 @@ struct elf_prstatus {
 #define OPT_CYCLIC_BUFFER       OPT_START+11
 #define OPT_EPPIC               OPT_START+12
 #define OPT_NON_MMAP            OPT_START+13
+#define OPT_MEM_USAGE            OPT_START+14
 
 /*
  * Function Prototype.
diff --git a/print_info.c b/print_info.c
index 7592690..29db918 100644
--- a/print_info.c
+++ b/print_info.c
@@ -264,6 +264,14 @@ print_usage(void)
 	MSG("      LOGFILE. If a VMCORE does not contain VMCOREINFO for dmesg, it is\n");
 	MSG("      necessary to specfiy [-x VMLINUX] or [-i VMCOREINFO].\n");
 	MSG("\n");
+	MSG("  [--mem-usage]:\n");
+	MSG("      This option is used to show the page numbers of current system in different\n");
+	MSG("      use. It should be executed in 1st kernel. By the help of this, user can know\n");
+	MSG("      how many pages is dumpable when different dump_level is specified. It analyzes\n");
+	MSG("      the 'System Ram' and 'kernel text' program segment of /proc/kcore excluding\n");
+	MSG("      the crashkernel range, then calculates the page number of different kind per\n");
+	MSG("      vmcoreinfo. So currently /proc/kcore need be specified explicitly.\n");
+	MSG("\n");
 	MSG("  [-D]:\n");
 	MSG("      Print debugging message.\n");
 	MSG("\n");
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
