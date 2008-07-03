Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.18.174])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KEOYT-0003hK-QJ
	for kexec@lists.infradead.org; Thu, 03 Jul 2008 13:08:58 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id m63D8DxS029948
	for <kexec@lists.infradead.org>; Thu, 3 Jul 2008 23:08:13 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m63D8RT44202496
	for <kexec@lists.infradead.org>; Thu, 3 Jul 2008 23:08:28 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m63D8rmW012757
	for <kexec@lists.infradead.org>; Thu, 3 Jul 2008 23:08:53 +1000
Message-ID: <486CCF6E.2010804@in.ibm.com>
Date: Thu, 03 Jul 2008 18:39:02 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
Subject: [PATCH] Fix 32 bit kexec binary to boot on 64 bit ppc64
Content-Type: multipart/mixed; boundary="------------070605070801030701030400"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Bernhard Walle <bwalle@suse.de>, Simon Horman <horms@verge.net.au>

This is a multi-part message in MIME format.
--------------070605070801030701030400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Allow 32 bit kexec binary to boot kdump kernel on
ppc64 architecture.

This problem was reported by Bernhard here.

http://lists.infradead.org/pipermail/kexec/2008-June/001998.html

Thanks
-Sachin

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---




--------------070605070801030701030400
Content-Type: text/x-patch;
 name="32bit-kexec-with-64bit-ppc64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="32bit-kexec-with-64bit-ppc64.patch"

* Allow 32 bit kexec binary to boot kdump kernel on ppc64 architecture.

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---

diff -Naurp old/kexec/arch/ppc64/crashdump-ppc64.c new/kexec/arch/ppc64/crashdump-ppc64.c
--- old/kexec/arch/ppc64/crashdump-ppc64.c	2008-07-01 11:20:12.000000000 +0530
+++ new/kexec/arch/ppc64/crashdump-ppc64.c	2008-07-03 17:27:50.000000000 +0530
@@ -82,7 +82,7 @@ mem_rgns_t usablemem_rgns = {0, NULL};
  * we can determine the RAM size unless parsing the device-tree/memoy@/reg
  * property in the kernel.
  */
-unsigned long saved_max_mem = 0;
+uint64_t saved_max_mem = 0;
 
 /* Reads the appropriate file and retrieves the SYSTEM RAM regions for whom to
  * create Elf headers. Keeping it separate from get_memory_ranges() as
@@ -264,7 +264,7 @@ err:
 }
 
 /* Converts unsigned long to ascii string. */
-static void ultoa(unsigned long i, char *str)
+static void ultoa(uint64_t i, char *str)
 {
 	int j = 0, k;
 	char tmp;
@@ -282,8 +282,8 @@ static void ultoa(unsigned long i, char 
 	}
 }
 
-static int add_cmdline_param(char *cmdline, unsigned long addr,
-				char *cmdstr, char *byte)
+static int add_cmdline_param(char *cmdline, uint64_t addr, char *cmdstr,
+				char *byte)
 {
 	int cmdlen, len, align = 1024;
 	char str[COMMAND_LINE_SIZE], *ptr;
@@ -320,10 +320,11 @@ static int add_cmdline_param(char *cmdli
  * for crash memory image.
  */
 int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
-				unsigned long max_addr, unsigned long min_base)
+				uint64_t max_addr, unsigned long min_base)
 {
 	void *tmp;
-	unsigned long sz, elfcorehdr;
+	unsigned long sz;
+	uint64_t elfcorehdr;
 	int nr_ranges, align = 1024, i;
 	unsigned long long end;
 	struct memory_range *mem_range;
diff -Naurp old/kexec/arch/ppc64/crashdump-ppc64.h new/kexec/arch/ppc64/crashdump-ppc64.h
--- old/kexec/arch/ppc64/crashdump-ppc64.h	2008-07-01 11:20:12.000000000 +0530
+++ new/kexec/arch/ppc64/crashdump-ppc64.h	2008-07-03 17:25:34.000000000 +0530
@@ -3,7 +3,7 @@
 
 struct kexec_info;
 int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
-				unsigned long max_addr, unsigned long min_base);
+				uint64_t max_addr, unsigned long min_base);
 void add_usable_mem_rgns(unsigned long long base, unsigned long long size);
 
 #define PAGE_OFFSET     0xC000000000000000
diff -Naurp old/kexec/arch/ppc64/fs2dt.c new/kexec/arch/ppc64/fs2dt.c
--- old/kexec/arch/ppc64/fs2dt.c	2008-07-01 11:20:12.000000000 +0530
+++ new/kexec/arch/ppc64/fs2dt.c	2008-07-03 17:19:35.000000000 +0530
@@ -125,9 +125,9 @@ static unsigned propnum(const char *name
 static void add_usable_mem_property(int fd, int len)
 {
 	char fname[MAXPATH], *bname;
-	unsigned long long buf[2];
-	unsigned long ranges[2*MAX_MEMORY_RANGES];
-	unsigned long long base, end, loc_base, loc_end;
+	uint64_t buf[2];
+	uint64_t ranges[2*MAX_MEMORY_RANGES];
+	uint64_t base, end, loc_base, loc_end;
 	int range, rlen = 0;
 
 	strcpy(fname, pathname);
@@ -137,9 +137,9 @@ static void add_usable_mem_property(int 
 	if (strncmp(bname, "/memory@", 8))
 		return;
 
-	if (len < 2 * sizeof(unsigned long long))
+	if (len < 2 * sizeof(uint64_t))
 		die("unrecoverable error: not enough data for mem property\n");
-	len = 2 * sizeof(unsigned long long);
+	len = 2 * sizeof(uint64_t);
 
 	if (lseek(fd, 0, SEEK_SET) < 0)
 		die("unrecoverable error: error seeking in \"%s\": %s\n",
@@ -179,7 +179,7 @@ static void add_usable_mem_property(int 
 		ranges[rlen++] = 0;
 	}
 
-	rlen = rlen * sizeof(unsigned long);
+	rlen = rlen * sizeof(uint64_t);
 	/*
 	 * No add linux,usable-memory property.
 	 */
diff -Naurp old/kexec/arch/ppc64/kexec-elf-ppc64.c new/kexec/arch/ppc64/kexec-elf-ppc64.c
--- old/kexec/arch/ppc64/kexec-elf-ppc64.c	2008-07-01 11:20:12.000000000 +0530
+++ new/kexec/arch/ppc64/kexec-elf-ppc64.c	2008-07-03 17:26:50.000000000 +0530
@@ -186,7 +186,7 @@ int elf_ppc64_load(int argc, char **argv
 	if (size > phdr->p_memsz)
 		size = phdr->p_memsz;
 
-	hole_addr = (unsigned long)locate_hole(info, size, 0, 0,
+	hole_addr = (uint64_t)locate_hole(info, size, 0, 0,
 			max_addr, 1);
 	ehdr.e_phdr[0].p_paddr = hole_addr;
 	result = elf_exec_load(&ehdr, info);
diff -Naurp old/kexec/arch/ppc64/kexec-ppc64.c new/kexec/arch/ppc64/kexec-ppc64.c
--- old/kexec/arch/ppc64/kexec-ppc64.c	2008-07-01 11:20:12.000000000 +0530
+++ new/kexec/arch/ppc64/kexec-ppc64.c	2008-07-03 17:19:35.000000000 +0530
@@ -37,8 +37,8 @@
 static struct memory_range *exclude_range = NULL;
 static struct memory_range *memory_range = NULL;
 static struct memory_range *base_memory_range = NULL;
-static unsigned long long rmo_top;
-unsigned long long memory_max = 0;
+static uint64_t rmo_top;
+uint64_t memory_max = 0;
 static int nr_memory_ranges, nr_exclude_ranges;
 uint64_t crash_base, crash_size;
 unsigned int rtas_base, rtas_size;
@@ -251,12 +251,12 @@ static int sort_ranges(void)
  */
 static int get_devtree_details(unsigned long kexec_flags)
 {
-	unsigned long long rmo_base;
-	unsigned long long tce_base;
+	uint64_t rmo_base;
+	uint64_t tce_base;
 	unsigned int tce_size;
-	unsigned long long htab_base, htab_size;
-	unsigned long long kernel_end;
-	unsigned long long initrd_start, initrd_end;
+	uint64_t htab_base, htab_size;
+	uint64_t kernel_end;
+	uint64_t initrd_start, initrd_end;
 	char buf[MAXBYTES];
 	char device_tree[256] = "/proc/device-tree/";
 	char fname[256];
@@ -465,8 +465,8 @@ static int get_devtree_details(unsigned 
 				perror(fname);
 				goto error_openfile;
 			}
-			rmo_base = ((unsigned long long *)buf)[0];
-			rmo_top = rmo_base + ((unsigned long long *)buf)[1];
+			rmo_base = ((uint64_t *)buf)[0];
+			rmo_top = rmo_base + ((uint64_t *)buf)[1];
 			if (rmo_top > 0x30000000UL)
 				rmo_top = 0x30000000UL;
 

--------------070605070801030701030400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------070605070801030701030400--

