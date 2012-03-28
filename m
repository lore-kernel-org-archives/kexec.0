Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SCyGC-000103-E1
 for kexec@lists.infradead.org; Wed, 28 Mar 2012 19:10:24 +0000
Date: Wed, 28 Mar 2012 13:09:02 -0600
From: Khalid Aziz <khalid@hp.com>
Subject: Add a descriptive error message for kexec load failure
Message-ID: <20120328190902.GA7651@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: Simon Horman <horms@verge.net.au>

kexec-tools package for debian includes a patch that adds a more 
descriptive error message when someone tries to laod a crash kernel 
and didn't remember to boot up with crashkernel= parameter. This 
patch would be of general interest. This patch was originally written 
by Alastair McKinstry.

Please apply.

Signed-off-by: Khalid Aziz <khalid.aziz@hp.com>
---
 kexec/arch/i386/crashdump-x86.c |   10 ++++++----
 kexec/kexec.c                   |   18 ++++++++++++++----
 kexec/kexec.h                   |    6 ++++++
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 590c883..2af090c 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -776,7 +776,9 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	memset(memmap_p, 0, sz);
 	add_memmap(memmap_p, info->backup_src_start, info->backup_src_size);
 	sz = crash_reserved_mem.end - crash_reserved_mem.start +1;
-	add_memmap(memmap_p, crash_reserved_mem.start, sz);
+	if (add_memmap(memmap_p, crash_reserved_mem.start, sz) < 0) {
+		return ENOCRASHKERNEL;
+	}
 
 	/* Create a backup region segment to store backup data*/
 	if (!(info->kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
@@ -788,7 +790,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 		dbgprintf("Created backup segment at 0x%lx\n",
 			  info->backup_start);
 		if (delete_memmap(memmap_p, info->backup_start, sz) < 0)
-			return -1;
+			return EFAILED;
 	}
 
 	/* Create elf header segment and store crash image data. */
@@ -797,14 +799,14 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 					       crash_memory_range, nr_ranges,
 					       &tmp, &bufsz,
 					       ELF_CORE_HEADER_ALIGN) < 0)
-			return -1;
+			return EFAILED;
 	}
 	else {
 		if (crash_create_elf32_headers(info, &elf_info,
 					       crash_memory_range, nr_ranges,
 					       &tmp, &bufsz,
 					       ELF_CORE_HEADER_ALIGN) < 0)
-			return -1;
+			return EFAILED;
 	}
 	/* the size of the elf headers allocated is returned in 'bufsz' */
 
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 19133fa..84dab70 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -718,10 +718,20 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 	}
 	info.kexec_flags |= native_arch;
 
-	if (file_type[i].load(argc, argv, kernel_buf,
-			      kernel_size, &info) < 0) {
-		fprintf(stderr, "Cannot load %s\n", kernel);
-		return -1;
+	result = file_type[i].load(argc, argv, kernel_buf, kernel_size, &info);
+	if (result < 0) {
+		switch (result) {
+		case ENOCRASHKERNEL:
+			fprintf(stderr,
+				"No crash kernel segment found in /proc/iomem\n"
+				"Please check the crashkernel= boot parameter.\n");
+			break;
+		case EFAILED:
+		default:
+			fprintf(stderr, "Cannot load %s\n", kernel);
+			break;
+		}
+		return result;
 	}
 	/* If we are not in native mode setup an appropriate trampoline */
 	if (arch_compat_trampoline(&info) < 0) {
diff --git a/kexec/kexec.h b/kexec/kexec.h
index dfd3630..279dfdf 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -57,6 +57,12 @@
 #error unknwon BYTE_ORDER
 #endif
 
+/*
+ * Document some of the reasons why crashdump may fail, so we can give
+ * better error messages
+ */
+#define EFAILED		-1	/* default error code */
+#define ENOCRASHKERNEL	-2	/* no memory reserved for crashkernel */
 
 /*
  * This function doesn't actually exist.  The idea is that when someone
-- 
1.7.8.3


====================================================================
Khalid Aziz                                         Unix Systems Lab
(970)898-9214                                        Hewlett-Packard
khalid.aziz@hp.com                                  Fort Collins, CO

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
