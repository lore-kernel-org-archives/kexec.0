Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TB2d5-0001Y8-P4
 for kexec@lists.infradead.org; Mon, 10 Sep 2012 11:58:16 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:48176 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1621607Ab2IJL5w
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Mon, 10 Sep 2012 13:57:52 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 6/7] kexec: Move crash memory ranges logging
Date: Mon, 10 Sep 2012 13:57:50 +0200
Message-Id: <1347278271-5211-7-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1347278271-5211-6-git-send-email-daniel.kiper@oracle.com>
References: <1347278271-5211-1-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-2-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-3-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-4-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-5-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-6-git-send-email-daniel.kiper@oracle.com>
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

Move crash memory ranges logging from get_crash_memory_ranges()
to load_crashdump_segments(). This solution will be used by
fixed Xen kdump support, too.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/arch/i386/crashdump-x86.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 56ef59e..c6b9354 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -270,14 +270,6 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 	*range = crash_memory_range;
 	*ranges = memory_ranges;
 
-	int i;
-	dbgprintf("CRASH MEMORY RANGES\n");
-	for(i = 0; i < memory_ranges; i++) {
-		start = crash_memory_range[i].start;
-		end = crash_memory_range[i].end;
-		dbgprintf("%016Lx-%016Lx\n", start, end);
-	}
-
 	return 0;
 }
 
@@ -739,6 +731,11 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 
 	get_backup_area(info, mem_range, nr_ranges);
 
+	dbgprintf("CRASH MEMORY RANGES\n");
+
+	for(i = 0; i < nr_ranges; ++i)
+		dbgprintf("%016Lx-%016Lx\n", mem_range[i].start, mem_range[i].end);
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
