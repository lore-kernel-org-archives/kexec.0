Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp2.provo.novell.com ([137.65.250.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cUGeY-0005DS-Ev
 for kexec@lists.infradead.org; Thu, 19 Jan 2017 17:37:40 +0000
Date: Thu, 19 Jan 2017 18:37:09 +0100
From: Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH] ppc64: Reduce number of ELF LOAD segments
Message-ID: <20170119183709.67327e67@hananiah.suse.cz>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

The number of program header table entries (e_phnum) is an Elf64_Half,
which is a 16-bit entity, i.e. the limit is 65534 entries (one entry is
reserved for NOTE). This is a hard limit, defined by the ELF standard.
It is possible that more LMBs (Logical Memory Blocks) are needed to
represent all RAM on some machines, and this field overflows, causing
an incomplete /proc/vmcore file.

This has actually happened on a machine with 31TB of RAM and an LMB size
of 256MB.

However, since there is usually no memory hole between adjacent LMBs, the
map can be "compressed", combining multiple adjacent into a single LOAD
segment.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 kexec/arch/ppc64/crashdump-ppc64.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index b3c8928..f62b159 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -123,6 +123,7 @@ static void exclude_crash_region(uint64_t start, uint64_t end)
 static int get_dyn_reconf_crash_memory_ranges(void)
 {
 	uint64_t start, end;
+	uint64_t startrange, endrange;
 	char fname[128], buf[32];
 	FILE *file;
 	unsigned int i;
@@ -137,6 +138,7 @@ static int get_dyn_reconf_crash_memory_ranges(void)
 	}
 
 	fseek(file, 4, SEEK_SET);
+	startrange = endrange = 0;
 	for (i = 0; i < num_of_lmbs; i++) {
 		if ((n = fread(buf, 1, 24, file)) < 0) {
 			perror(fname);
@@ -162,8 +164,16 @@ static int get_dyn_reconf_crash_memory_ranges(void)
 		if ((flags & 0x80) || !(flags & 0x8))
 			continue;
 
-		exclude_crash_region(start, end);
+		if (start != endrange) {
+			if (startrange != endrange)
+				exclude_crash_region(startrange, endrange);
+			startrange = start;
+		}
+		endrange = end;
 	}
+	if (startrange != endrange)
+		exclude_crash_region(startrange, endrange);
+
 	fclose(file);
 	return 0;
 }
-- 
2.6.6

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
