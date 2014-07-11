Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X5V4s-0004RF-Qa
 for kexec@lists.infradead.org; Fri, 11 Jul 2014 07:17:07 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 7/7] add a new interface to show the memory usage of 1st kernel
Date: Fri, 11 Jul 2014 15:16:04 +0800
Message-Id: <1405062964-11406-7-git-send-email-bhe@redhat.com>
In-Reply-To: <1405062964-11406-1-git-send-email-bhe@redhat.com>
References: <1405062964-11406-1-git-send-email-bhe@redhat.com>
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
To: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: Baoquan He <bhe@redhat.com>, vgoyal@redhat.com

Recently people complained that they don't decide how much disk size
need be reserved for kdump storing. E.g there are lots of machines
with different memory size, if the memory usage information of current
system can be shown, that can help them to make an estimate how much
storage space need be reserved.

In this patch, a new interface is added into makedumpfile. With the
help of this, people can know the page number of memory in different
use. The implementation is analyzing the "System Ram" and "kernel text"
program segment of /proc/kcore excluding the crashkernel range, then
calculating the page number of different kind per vmcoreinfo.

The print is like below:
->$ ./makedumpfile  --mem-usage  /proc/kcore
Excluding unnecessary pages        : [100.0 %] |

Page number of memory in different use
--------------------------------------------------
TYPE			PAGES			EXCLUDABLE	DESCRIPTION
pfn_zero		0x0000000000000000	yes		Pages filled with zero
pfn_cache		0x000000000002b19f	yes		Cache pages
pfn_cache_private	0x0000000000042526	yes		Cache pages + private
pfn_user		0x0000000000026bc3	yes		User process data pages
pfn_free		0x0000000000133f79	yes		Free pages
pfn_hwpoison		0x0000000000000000	yes		Hwpoison pages
pfn_kernel_data		0x000000000001dd56	no		Dumpable kernel data

Total pages on system:	0x00000000001e5f57
Excludable pages:	0x00000000001c8201
Memory Hole: 		0x00000000000386a9
--------------------------------------------------
Total pages:		0x000000000021e600

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |  2 ++
 2 files changed, 73 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index a170dd3..b281d73 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -8904,6 +8904,13 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
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
 
@@ -9146,6 +9153,54 @@ static int get_sys_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
 	return 0;
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
+        if (!get_page_offset())
+                return FALSE;
+
+        if (!open_dump_memory())
+                return FALSE;
+
+        if (!get_elf_loads(info->fd_memory, info->name_memory))
+                return FALSE;
+
+        if (get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
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
+        if (!info->flag_cyclic)
+                info->flag_cyclic = TRUE;
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
@@ -9163,6 +9218,7 @@ static struct option longopts[] = {
 	{"cyclic-buffer", required_argument, NULL, OPT_CYCLIC_BUFFER},
 	{"eppic", required_argument, NULL, OPT_EPPIC},
 	{"non-mmap", no_argument, NULL, OPT_NON_MMAP},
+	{"mem-usage", no_argument, NULL, OPT_MEM_USAGE},
 	{0, 0, 0, 0}
 };
 
@@ -9254,6 +9310,9 @@ main(int argc, char *argv[])
 		case OPT_DUMP_DMESG:
 			info->flag_dmesg = 1;
 			break;
+		case OPT_MEM_USAGE:
+                       info->flag_mem_usage = 1;
+                       break;
 		case OPT_COMPRESS_SNAPPY:
 			info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
 			break;
@@ -9394,6 +9453,18 @@ main(int argc, char *argv[])
 
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
+
+		MSG("\n");
+		MSG("Showing page number of memory in different use successfully.\n");
 	} else {
 		if (!check_param_for_creating_dumpfile(argc, argv)) {
 			MSG("Commandline parameter is invalid.\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index 7ffa1ee..7b537c7 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -910,6 +910,7 @@ struct DumpInfo {
 	int		flag_force;	     /* overwrite existing stuff */
 	int		flag_exclude_xen_dom;/* exclude Domain-U from xen-kdump */
 	int             flag_dmesg;          /* dump the dmesg log out of the vmcore file */
+	int             flag_mem_usage;  /*show the page number of memory in different use*/
 	int		flag_use_printk_log; /* did we read printk_log symbol name? */
 	int		flag_nospace;	     /* the flag of "No space on device" error */
 	int		flag_vmemmap;        /* kernel supports vmemmap address space */
@@ -1771,6 +1772,7 @@ struct elf_prstatus {
 #define OPT_CYCLIC_BUFFER       OPT_START+11
 #define OPT_EPPIC               OPT_START+12
 #define OPT_NON_MMAP            OPT_START+13
+#define OPT_MEM_USAGE            OPT_START+14
 
 /*
  * Function Prototype.
-- 
1.8.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
