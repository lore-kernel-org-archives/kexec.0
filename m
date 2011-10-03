Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RAfcw-0003vB-8l
	for kexec@lists.infradead.org; Mon, 03 Oct 2011 10:20:12 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id p93AJTou029935
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 15:49:29 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p93AIDd43928214
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 15:48:13 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p93AICrk002458
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 21:18:13 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH] kexec: powerpc: crash_dump: No backup region for PPC BookE
Date: Mon, 03 Oct 2011 15:48:12 +0530
Message-ID: <20111003101746.30979.44424.stgit@suzukikp.in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>, "M. Mohan Kumar" <mohan@in.ibm.com>, "Suzuki K. Poulose" <suzuki@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

Disable backup regions for BookE in case of a CRASH Dump, as they can
be run from anywhere.

The patch introduces --with-booke option to support the BookE.

With the patch, we get :

## On a 256M machine:

# busybox cat /proc/cmdline
init=/bin/init console=ttyS0,16550 crashkernel=128M@100M
# kexec -p root/vmlinux
usable memory rgns size:1 base:6400000 size:8000000
CRASH MEMORY RANGES
0000000000000000-0000000006400000
000000000e400000-0000000010000000
Command line after adding elfcorehdr:  elfcorehdr=112380K
Command line after adding elfcorehdr:  elfcorehdr=112380K savemaxmem=256M

Signed-off-by: Suzuki K. Poulose<suzuki@in.ibm.com>
---

 configure.ac                       |    5 +++++
 kexec/arch/ppc/crashdump-powerpc.c |    7 ++++++-
 kexec/arch/ppc/crashdump-powerpc.h |    8 ++++++++
 kexec/arch/ppc/kexec-ppc.c         |    5 +++++
 purgatory/arch/ppc/purgatory-ppc.c |    2 ++
 5 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0d09bba..7dd6028 100644
--- a/configure.ac
+++ b/configure.ac
@@ -85,6 +85,11 @@ AC_ARG_WITH([lzma], AC_HELP_STRING([--without-lzma],[disable lzma support]),
 AC_ARG_WITH([xen], AC_HELP_STRING([--without-xen],
 	[disable extended xen support]), [ with_xen="$withval"], [ with_xen=yes ] )
 
+AC_ARG_WITH([booke],
+		AC_HELP_STRING([--with-booke],[build for booke]),
+		AC_DEFINE(CONFIG_BOOKE,1,
+			[Define to build for BookE]))
+
 dnl ---Programs
 dnl To specify a different compiler, just 'export CC=/path/to/compiler'
 
diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index 243721a..7c9dbff 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -95,11 +95,13 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 	}
 	memset(crash_memory_range, 0, crash_rng_len);
 
+#ifndef CONFIG_BOOKE
 	/* create a separate program header for the backup region */
 	crash_memory_range[0].start = BACKUP_SRC_START;
 	crash_memory_range[0].end = BACKUP_SRC_END + 1;
 	crash_memory_range[0].type = RANGE_RAM;
 	memory_ranges++;
+#endif
 
 	dir = opendir(device_tree);
 	if (!dir) {
@@ -143,9 +145,10 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 					" excedeed the max limit\n");
 				goto err;
 			}
-
+#ifndef CONFIG_BOOKE
 			if (start == 0 && end >= (BACKUP_SRC_END + 1))
 				start = BACKUP_SRC_END + 1;
+#endif
 
 			cstart = crash_base;
 			cend = crash_base + crash_size;
@@ -310,6 +313,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 
 	info->backup_src_start = BACKUP_SRC_START;
 	info->backup_src_size = BACKUP_SRC_SIZE;
+#ifndef CONFIG_BOOKE
 	/* Create a backup region segment to store backup data*/
 	sz = (BACKUP_SRC_SIZE + align - 1) & ~(align - 1);
 	tmp = xmalloc(sz);
@@ -317,6 +321,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 	info->backup_start = add_buffer(info, tmp, sz, sz, align,
 					0, max_addr, 1);
 	reserve(info->backup_start, sz);
+#endif
 
 	/* On powerpc memory ranges in device-tree is denoted as start
 	 * and size rather than start and end, as is the case with
diff --git a/kexec/arch/ppc/crashdump-powerpc.h b/kexec/arch/ppc/crashdump-powerpc.h
index dc2772d..a377146 100644
--- a/kexec/arch/ppc/crashdump-powerpc.h
+++ b/kexec/arch/ppc/crashdump-powerpc.h
@@ -21,10 +21,18 @@ extern struct arch_options_t arch_options;
 #define __pa(x)		((unsigned long)(x)-PAGE_OFFSET)
 
 #define COMMAND_LINE_SIZE	512 /* from kernel */
+
+#ifdef CONFIG_BOOKE
+/* We don't need backup region in Book E */
+#define BACKUP_SRC_START	0x0000
+#define BACKUP_SRC_END		0x0000
+#define BACKUP_SRC_SIZE		0x0000
+#else
 /* Backup Region, First 64K of System RAM. */
 #define BACKUP_SRC_START	0x0000
 #define BACKUP_SRC_END		0xffff
 #define BACKUP_SRC_SIZE		(BACKUP_SRC_END - BACKUP_SRC_START + 1)
+#endif
 
 #define KDUMP_BACKUP_LIMIT	BACKUP_SRC_SIZE
 #define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((size)-1)))
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index 4e3569f..57852dc 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -502,9 +502,14 @@ static int get_devtree_details(unsigned long kexec_flags)
 				if (crash_base + crash_size < mem_max)
 					mem_max = crash_base + crash_size;
 
+#ifndef CONFIG_BOOKE
 				add_usable_mem_rgns(0, crash_base + crash_size);
+				/* Reserve the region (KDUMP_BACKUP_LIMIT,crash_base) */
 				reserve(KDUMP_BACKUP_LIMIT,
 						crash_base-KDUMP_BACKUP_LIMIT);
+#else
+				add_usable_mem_rgns(crash_base, crash_size);
+#endif
 			}
 			/* reserve the initrd_start and end locations. */
 			memset(fname, 0, sizeof(fname));
diff --git a/purgatory/arch/ppc/purgatory-ppc.c b/purgatory/arch/ppc/purgatory-ppc.c
index 3e6b354..3df3767 100644
--- a/purgatory/arch/ppc/purgatory-ppc.c
+++ b/purgatory/arch/ppc/purgatory-ppc.c
@@ -36,8 +36,10 @@ void setup_arch(void)
 
 void post_verification_setup_arch(void)
 {
+#ifndef CONFIG_BOOKE
 	if (panic_kernel)
 		crashdump_backup_memory();
+#endif
 }
 
 void crashdump_backup_memory(void)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
