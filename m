Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pythia.bakeyournoodle.com ([203.82.209.197])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jqclm-0003oO-Uo
	for kexec@lists.infradead.org; Mon, 28 Apr 2008 23:28:28 +0000
Message-Id: <3146e524987d7843732ce3885174ed91a9e80567.1209425237.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 1/1] Allow building for ppc32 platforms.
Date: Tue, 29 Apr 2008 09:28:09 +1000 (EST)
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Kexec testing list <kexec@lists.infradead.org>

Currently any ppc32 compile will error out with "Please, fix this for
your platform".  While this is a great way to encourage people to update
the code it seesm to be a disinsentive for distros to package
kexec-tools for powerpc (incl. 64-bit).

Make get_memory_ranges() do the right thing in the GameCube case and
fail at runtime for all other ppc32 cases.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
Compile tested for 32-bit and 64-bit powerpc

 kexec/arch/ppc/kexec-ppc.c |   53 +++++---------------------------------------
 1 files changed, 6 insertions(+), 47 deletions(-)

diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index 9a88f9c..96537f6 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -27,62 +27,21 @@ static struct memory_range memory_range[MAX_MEMORY_RANGES];
 int get_memory_ranges(struct memory_range **range, int *ranges,
 					unsigned long kexec_flags)
 {
-	int memory_ranges = 0;
 #ifdef WITH_GAMECUBE
+	int memory_ranges = 0;
+
 	/* RAM - lowmem used by DOLs - framebuffer */
 	memory_range[memory_ranges].start = 0x00003000;
 	memory_range[memory_ranges].end = 0x0174bfff;
 	memory_range[memory_ranges].type = RANGE_RAM;
 	memory_ranges++;
-#else
-#error Please, fix this for your platform
-	const char *iomem = proc_iomem();
-	char line[MAX_LINE];
-	FILE *fp;
-	unsigned long long start, end;
-	char *str;
-	int type, consumed, count;
-
-	fp = fopen(iomem, "r");
-	if (!fp) {
-		fprintf(stderr, "Cannot open %s: %s\n", iomem, strerror(errno));
-		return -1;
-	}
-	while (fgets(line, sizeof(line), fp) != 0) {
-		if (memory_ranges >= MAX_MEMORY_RANGES)
-			break;
-		count = sscanf(line, "%Lx-%Lx : %n", &start, &end, &consumed);
-		if (count != 2)
-			continue;
-		str = line + consumed;
-		end = end + 1;
-#if 0
-		printf("%016Lx-%016Lx : %s\n", start, end, str);
-#endif
-		if (memcmp(str, "System RAM\n", 11) == 0) {
-			type = RANGE_RAM;
-		} else if (memcmp(str, "reserved\n", 9) == 0) {
-			type = RANGE_RESERVED;
-		} else if (memcmp(str, "ACPI Tables\n", 12) == 0) {
-			type = RANGE_ACPI;
-		} else if (memcmp(str, "ACPI Non-volatile Storage\n", 26) == 0) {
-			type = RANGE_ACPI_NVS;
-		} else {
-			continue;
-		}
-		memory_range[memory_ranges].start = start;
-		memory_range[memory_ranges].end = end;
-		memory_range[memory_ranges].type = type;
-#if 0
-		printf("%016Lx-%016Lx : %x\n", start, end, type);
-#endif
-		memory_ranges++;
-	}
-	fclose(fp);
-#endif
 	*range = memory_range;
 	*ranges = memory_ranges;
 	return 0;
+#else
+	fprintf(stderr, "%s(): Unsupported platform\n", __func__);
+	return -1;
+#endif
 }
 
 struct file_type file_type[] = {
-- 
1.5.5.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
