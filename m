Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TB2d1-0001Y8-JM
 for kexec@lists.infradead.org; Mon, 10 Sep 2012 11:58:12 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:48176 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1621318Ab2IJL5w
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Mon, 10 Sep 2012 13:57:52 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 3/7] kexec: Move crash kernel area placement and size
 detection to is_crashkernel_mem_reserved()
Date: Mon, 10 Sep 2012 13:57:47 +0200
Message-Id: <1347278271-5211-4-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1347278271-5211-3-git-send-email-daniel.kiper@oracle.com>
References: <1347278271-5211-1-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-2-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-3-git-send-email-daniel.kiper@oracle.com>
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

Move crash kernel area placement and size detection
from get_crash_memory_ranges() to is_crashkernel_mem_reserved().
Former one will not be used by fixed Xen kdump support.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/arch/i386/crashdump-x86.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 2af090c..ec9432b 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -212,13 +212,6 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 		/* Only Dumping memory of type System RAM. */
 		if (memcmp(str, "System RAM\n", 11) == 0) {
 			type = RANGE_RAM;
-		} else if (memcmp(str, "Crash kernel\n", 13) == 0) {
-				/* Reserved memory region. New kernel can
-				 * use this region to boot into. */
-				crash_reserved_mem.start = start;
-				crash_reserved_mem.end = end;
-				crash_reserved_mem.type = RANGE_RAM;
-				continue;
 		} else if (memcmp(str, "ACPI Tables\n", 12) == 0) {
 			/*
 			 * ACPI Tables area need to be passed to new
@@ -849,6 +842,12 @@ int is_crashkernel_mem_reserved(void)
 {
 	uint64_t start, end;
 
-	return parse_iomem_single("Crash kernel\n", &start, &end) == 0 ?
-	  (start != end) : 0;
+	if (parse_iomem_single("Crash kernel\n", &start, &end) || start == end)
+		return 0;
+
+	crash_reserved_mem.start = start;
+	crash_reserved_mem.end = end;
+	crash_reserved_mem.type = RANGE_RAM;
+
+	return 1;
 }
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
