Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TB2d4-0001Y8-CA
 for kexec@lists.infradead.org; Mon, 10 Sep 2012 11:58:15 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:48176 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1621606Ab2IJL5w
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Mon, 10 Sep 2012 13:57:52 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 5/7] kexec: Get backup area start address and size directly
 from mem_range
Date: Mon, 10 Sep 2012 13:57:49 +0200
Message-Id: <1347278271-5211-6-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1347278271-5211-5-git-send-email-daniel.kiper@oracle.com>
References: <1347278271-5211-1-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-2-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-3-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-4-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-5-git-send-email-daniel.kiper@oracle.com>
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
To: konrad.wilk@oracle.com, andrew.cooper3@citrix.com, olaf@aepfle.de, jbeulich@suse.com, ptesarik@suse.cz, kexec@lists.infradead.org, xen-devel@lists.xensource.com

Get backup area start address and size directly from mem_range.
Under Xen /proc/iomem contains invalid values.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/arch/i386/crashdump-x86.c |   55 +++++++++++++-------------------------
 1 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 77a1329..56ef59e 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -667,44 +667,28 @@ static int cmdline_add_memmap_acpi(char *cmdline, unsigned long start,
 	return 0;
 }
 
-static void get_backup_area(unsigned long *start, unsigned long *end)
+static void get_backup_area(struct kexec_info *info,
+				struct memory_range *range, int ranges)
 {
-	const char *iomem = proc_iomem();
-	char line[MAX_LINE];
-	FILE *fp;
+	int i;
 
-	fp = fopen(iomem, "r");
-	if (!fp) {
-		fprintf(stderr, "Cannot open %s: %s\n",
-			iomem, strerror(errno));
-		return;
-	}
+	/* Look for first 640 KiB RAM region. */
+	for (i = 0; i < ranges; ++i) {
+		if (range[i].type != RANGE_RAM || range[i].end > 0xa0000)
+			continue;
 
-	while(fgets(line, sizeof(line), fp) != 0) {
-		char *str;
-		int count, consumed;
-		unsigned long mstart, mend;
+		info->backup_src_start = range[i].start;
+		info->backup_src_size = range[i].end - range[i].start + 1;
 
-		count = sscanf(line, "%lx-%lx : %n",
-			&mstart, &mend, &consumed);
-		if (count != 2)
-			continue;
-		str = line + consumed;
-		dbgprintf("%016lx-%016lx : %s",
-			mstart, mend, str);
-
-		/* Hopefully there is only one RAM region in the first 640K */
-		if (memcmp(str, "System RAM\n", 11) == 0 && mend <= 0xa0000 ) {
-			dbgprintf("%s: %016lx-%016lx : %s", __func__, mstart, mend, str);
-			*start = mstart;
-			*end = mend;
-			fclose(fp);
-			return;
-		}
+		dbgprintf("%s: %016llx-%016llx : System RAM\n", __func__,
+						range[i].start, range[i].end);
+
+		return;
 	}
-	*start = BACKUP_SRC_START;
-	*end = BACKUP_SRC_END;
-	fclose(fp);
+
+	/* First 640 KiB RAM region not found. Assume defaults. */
+	info->backup_src_start = BACKUP_SRC_START;
+	info->backup_src_size = BACKUP_SRC_END - BACKUP_SRC_START + 1;
 }
 
 /* Loads additional segments in case of a panic kernel is being loaded.
@@ -720,15 +704,12 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	struct memory_range *mem_range, *memmap_p;
 	struct crash_elf_info elf_info;
 	unsigned kexec_arch;
-	unsigned long tmp_backup_end = 0;
 
 	memset(&elf_info, 0x0, sizeof(elf_info));
 
 	/* Constant parts of the elf_info */
 	memset(&elf_info, 0, sizeof(elf_info));
 	elf_info.data             = ELFDATA2LSB;
-	get_backup_area(&info->backup_src_start, &tmp_backup_end);
-	info->backup_src_size = tmp_backup_end - info->backup_src_start + 1;
 
 	/* Get the architecture of the running kernel */
 	kexec_arch = info->kexec_flags & KEXEC_ARCH_MASK;
@@ -756,6 +737,8 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 				    elf_info.lowmem_limit) < 0)
 		return -1;
 
+	get_backup_area(info, mem_range, nr_ranges);
+
 	/*
 	 * if the core type has not been set on command line, set it here
 	 * automatically
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
