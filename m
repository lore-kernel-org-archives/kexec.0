Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XD7C2-0005wZ-OR
 for kexec@lists.infradead.org; Fri, 01 Aug 2014 07:23:59 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [Patch v3 7/7] add a new interface to show the memory usage of
 1st kernel
Date: Fri, 1 Aug 2014 07:12:30 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97246623@BPXM01GP.gisp.nec.co.jp>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
 <1406535606-16303-8-git-send-email-bhe@redhat.com>
In-Reply-To: <1406535606-16303-8-git-send-email-bhe@redhat.com>
Content-Language: ja-JP
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

>Recently people complained that they don't know how to decide how
>much disk size need be reserved for kdump. E.g there are lots of
>machines with different memory size, if the memory usage information
>of current system can be shown, that can help them to make an estimate
>how much storage space need be reserved.
>
>In this patch, a new interface is added into makedumpfile. By the
>help of this, people can know the page number of memory in different
>use. The implementation is analyzing the "System Ram" and "kernel text"
>program segment of /proc/kcore excluding the crashkernel range, then
>calculating the page number of different kind per vmcoreinfo.
>
>The print is like below:
>->$ ./makedumpfile  --mem-usage  /proc/kcore
>Excluding unnecessary pages        : [100.0 %] |
>
>Page number of memory in different use
>--------------------------------------------------
>TYPE		PAGES			EXCLUDABLE	DESCRIPTION
>ZERO		0               	yes		Pages filled with zero

The number of zero pages is always 0 since it isn't counted during
get_num_dumpable_cyclic(). To count it up, we have to read all of the
pages like exclude_zero_pages(), so we need "exclude_zero_pages_cyclic()".
My idea is to call it in get_num_dumpable_cyclic() like:

		for_each_cycle(0, info->max_mapnr, &cycle)
		{
				if (!exclude_unnecessary_pages_cyclic(&cycle))
					return FALSE;

+				if (info->flag_mem_usage)
+					exclude_zero_pages_cyclic(&cycle);
+
				for(pfn=cycle.start_pfn; pfn<cycle.end_pfn; pfn++)


BTW, what is the target kernel version of this feature?
It works well on 3.12 but fails on 2.6.32 like:

# ./makedumpfile --mem-usage /proc/kcore
read_device: Can't read a file(/proc/kcore). Success
set_kcore_vmcoreinfo: Can't read the dump memory(/proc/kcore). Success

makedumpfile Failed.
#

This error means reading VMCOREINFO from /proc/kcore was failed.
Of course, there is a VMCOREINFO on the memory,

# cat /sys/kernel/vmcoreinfo
1e01b80 1000
#

It seems like old /proc/kcore's issue, but I'm still investigating.
Any comments are helpful.


Thanks
Atsushi Kumagai

>CACHE		562006          	yes		Cache pages
>CACHE_PRIVATE	353502          	yes		Cache pages + private
>USER		225780          	yes		User process pages
>FREE		2761884         	yes		Free pages
>KERN_DATA	235873          	no		Dumpable kernel data
>
>Total pages on system:	4139045
>
>Signed-off-by: Baoquan He <bhe@redhat.com>
>---
> makedumpfile.8 | 17 +++++++++++++
> makedumpfile.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> makedumpfile.h |  2 ++
> print_info.c   |  8 +++++++
> 4 files changed, 103 insertions(+)
>
>diff --git a/makedumpfile.8 b/makedumpfile.8
>index 25fe74e..64abbc7 100644
>--- a/makedumpfile.8
>+++ b/makedumpfile.8
>@@ -532,6 +532,23 @@ it is necessary to specfiy [\-x \fIVMLINUX\fR] or [\-i \fIVMCOREINFO\fR].
> # makedumpfile \-\-dump-dmesg -x vmlinux /proc/vmcore dmesgfile
> .br
>
>+
>+.TP
>+\fB\-\-mem-usage\fR
>+This option is used to show the page numbers of current system in different
>+use. It should be executed in 1st kernel. By the help of this, user can know
>+how many pages is dumpable when different dump_level is specified. It analyzes
>+the 'System Ram' and 'kernel text' program segment of /proc/kcore excluding
>+the crashkernel range, then calculates the page number of different kind per
>+vmcoreinfo. So currently /proc/kcore need be specified explicitly.
>+
>+.br
>+.B Example:
>+.br
>+# makedumpfile \-\-mem-usage /proc/kcore
>+.br
>+
>+
> .TP
> \fB\-\-diskset=VMCORE\fR
> Specify multiple \fIVMCORE\fRs created on sadump diskset configuration
>diff --git a/makedumpfile.c b/makedumpfile.c
>index b5e920d..6bbf324 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -7853,6 +7853,7 @@ print_mem_usage(void)
> 	shrinking = shrinking / pfn_original;
>
> 	MSG("\n");
>+	MSG("\n");
> 	MSG("Page number of memory in different use\n");
> 	MSG("--------------------------------------------------\n");
> 	MSG("TYPE		PAGES			EXCLUDABLE	DESCRIPTION\n");
>@@ -8906,6 +8907,13 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
> 		 */
> 		info->name_memory   = argv[optind];
>
>+	} else if ((argc == optind + 1) && info->flag_mem_usage) {
>+		/*
>+		* Parameter for showing the page number of memory
>+		* in different use from.
>+		*/
>+		info->name_memory   = argv[optind];
>+
> 	} else
> 		return FALSE;
>
>@@ -9148,6 +9156,58 @@ static int get_sys_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
> 	return 0;
> }
>
>+int show_mem_usage(void)
>+{
>+        uint64_t vmcoreinfo_addr, vmcoreinfo_len;
>+
>+        if (!is_crashkernel_mem_reserved()) {
>+                ERRMSG("No memory is reserved for crashkenrel!\n");
>+                return FALSE;
>+        }
>+
>+
>+        if (!info->flag_cyclic)
>+                info->flag_cyclic = TRUE;
>+
>+	info->dump_level = MAX_DUMP_LEVEL;
>+
>+        if (!get_page_offset())
>+                return FALSE;
>+
>+        if (!open_dump_memory())
>+                return FALSE;
>+
>+        if (!get_elf_loads(info->fd_memory, info->name_memory))
>+                return FALSE;
>+
>+        if (get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
>+                return FALSE;
>+
>+        if (!set_kcore_vmcoreinfo(vmcoreinfo_addr, vmcoreinfo_len))
>+                return FALSE;
>+
>+        if (!get_kcore_dump_loads())
>+                return FALSE;
>+
>+        if (!initial())
>+                return FALSE;
>+
>+
>+        if (!prepare_bitmap2_buffer_cyclic())
>+                return FALSE;
>+
>+        info->num_dumpable = get_num_dumpable_cyclic();
>+
>+	free_bitmap2_buffer_cyclic();
>+
>+        print_mem_usage();
>+
>+        if (!close_files_for_creating_dumpfile())
>+                return FALSE;
>+
>+        return TRUE;
>+}
>+
>
> static struct option longopts[] = {
> 	{"split", no_argument, NULL, OPT_SPLIT},
>@@ -9165,6 +9225,7 @@ static struct option longopts[] = {
> 	{"cyclic-buffer", required_argument, NULL, OPT_CYCLIC_BUFFER},
> 	{"eppic", required_argument, NULL, OPT_EPPIC},
> 	{"non-mmap", no_argument, NULL, OPT_NON_MMAP},
>+	{"mem-usage", no_argument, NULL, OPT_MEM_USAGE},
> 	{0, 0, 0, 0}
> };
>
>@@ -9256,6 +9317,9 @@ main(int argc, char *argv[])
> 		case OPT_DUMP_DMESG:
> 			info->flag_dmesg = 1;
> 			break;
>+		case OPT_MEM_USAGE:
>+                       info->flag_mem_usage = 1;
>+                       break;
> 		case OPT_COMPRESS_SNAPPY:
> 			info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
> 			break;
>@@ -9396,6 +9460,18 @@ main(int argc, char *argv[])
>
> 		MSG("\n");
> 		MSG("The dmesg log is saved to %s.\n", info->name_dumpfile);
>+	} else if (info->flag_mem_usage) {
>+		if (!check_param_for_creating_dumpfile(argc, argv)) {
>+			MSG("Commandline parameter is invalid.\n");
>+			MSG("Try `makedumpfile --help' for more information.\n");
>+			goto out;
>+		}
>+
>+		if (!show_mem_usage())
>+			goto out;
>+
>+		MSG("\n");
>+		MSG("Showing page number of memory in different use successfully.\n");
> 	} else {
> 		if (!check_param_for_creating_dumpfile(argc, argv)) {
> 			MSG("Commandline parameter is invalid.\n");
>diff --git a/makedumpfile.h b/makedumpfile.h
>index 8881c76..ba8c0f9 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -911,6 +911,7 @@ struct DumpInfo {
> 	int		flag_force;	     /* overwrite existing stuff */
> 	int		flag_exclude_xen_dom;/* exclude Domain-U from xen-kdump */
> 	int             flag_dmesg;          /* dump the dmesg log out of the vmcore file */
>+	int             flag_mem_usage;  /*show the page number of memory in different use*/
> 	int		flag_use_printk_log; /* did we read printk_log symbol name? */
> 	int		flag_nospace;	     /* the flag of "No space on device" error */
> 	int		flag_vmemmap;        /* kernel supports vmemmap address space */
>@@ -1772,6 +1773,7 @@ struct elf_prstatus {
> #define OPT_CYCLIC_BUFFER       OPT_START+11
> #define OPT_EPPIC               OPT_START+12
> #define OPT_NON_MMAP            OPT_START+13
>+#define OPT_MEM_USAGE            OPT_START+14
>
> /*
>  * Function Prototype.
>diff --git a/print_info.c b/print_info.c
>index 7592690..29db918 100644
>--- a/print_info.c
>+++ b/print_info.c
>@@ -264,6 +264,14 @@ print_usage(void)
> 	MSG("      LOGFILE. If a VMCORE does not contain VMCOREINFO for dmesg, it is\n");
> 	MSG("      necessary to specfiy [-x VMLINUX] or [-i VMCOREINFO].\n");
> 	MSG("\n");
>+	MSG("  [--mem-usage]:\n");
>+	MSG("      This option is used to show the page numbers of current system in different\n");
>+	MSG("      use. It should be executed in 1st kernel. By the help of this, user can know\n");
>+	MSG("      how many pages is dumpable when different dump_level is specified. It analyzes\n");
>+	MSG("      the 'System Ram' and 'kernel text' program segment of /proc/kcore excluding\n");
>+	MSG("      the crashkernel range, then calculates the page number of different kind per\n");
>+	MSG("      vmcoreinfo. So currently /proc/kcore need be specified explicitly.\n");
>+	MSG("\n");
> 	MSG("  [-D]:\n");
> 	MSG("      Print debugging message.\n");
> 	MSG("\n");
>--
>1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
