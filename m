Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2nam01on0060.outbound.protection.outlook.com
 ([104.47.34.60] helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e2kdB-0002wx-8N
 for kexec@lists.infradead.org; Thu, 12 Oct 2017 21:03:03 +0000
From: David Daney <david.daney@cavium.com>
Subject: [PATCH 3/4] kexec-tools: mips: Use proper page_offset for OCTEON CPUs.
Date: Thu, 12 Oct 2017 14:02:27 -0700
Message-Id: <20171012210228.7353-4-david.daney@cavium.com>
In-Reply-To: <20171012210228.7353-1-david.daney@cavium.com>
References: <20171012210228.7353-1-david.daney@cavium.com>
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
To: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
Cc: linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>

The OCTEON family of MIPS64 CPUs uses a PAGE_OFFSET of
0x8000000000000000ULL, which is differs from other CPUs.

Scan /proc/cpuinfo to see if the current system is "Octeon", if so,
patch the page_offset so that usable kdump core files are produced.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 kexec/arch/mips/crashdump-mips.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index 22fc38e..e98badf 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -315,6 +315,30 @@ static struct crash_elf_info elf_info32 = {
 	lowmem_limit : MAXMEM,
 };
 
+static int patch_elf_info(void)
+{
+	const char cpuinfo[] = "/proc/cpuinfo";
+	char line[MAX_LINE];
+	FILE *fp;
+
+	fp = fopen(cpuinfo, "r");
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s: %s\n",
+			cpuinfo, strerror(errno));
+		return -1;
+	}
+	while (fgets(line, sizeof(line), fp) != 0) {
+		if (strncmp(line, "cpu model", 9) == 0) {
+			/* OCTEON uses a different page_offset. */
+			if (strstr(line, "Octeon"))
+				elf_info64.page_offset = 0x8000000000000000ULL;
+			break;
+		}
+	}
+	fclose(fp);
+	return 0;
+}
+
 /* Loads additional segments in case of a panic kernel is being loaded.
  * One segment for backup region, another segment for storing elf headers
  * for crash memory image.
@@ -331,6 +355,9 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	struct crash_elf_info *elf_info = &elf_info32;
 	unsigned long start_offset = 0x80000000UL;
 
+	if (patch_elf_info())
+		return -1;
+
 	if (arch_options.core_header_type == CORE_TYPE_ELF64) {
 		elf_info = &elf_info64;
 		crash_create = crash_create_elf64_headers;
-- 
2.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
