Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LNpLX-0001fS-Lp
	for kexec@lists.infradead.org; Fri, 16 Jan 2009 14:06:54 +0000
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id EB837474E0
	for <kexec@lists.infradead.org>; Fri, 16 Jan 2009 15:06:48 +0100 (CET)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Fix missing FILE argument in fprintf()
Date: Fri, 16 Jan 2009 15:06:48 +0100
Message-Id: <1232114808-22809-1-git-send-email-bwalle@suse.de>
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
To: kexec@lists.infradead.org
Cc: Bernhard Walle <bwalle@suse.de>

This fixes the following compiler warning

    kexec/arch/i386/crashdump-x86.c: In function 'get_crash_memory_ranges':
    kexec/arch/i386/crashdump-x86.c:144: warning: passing argument 1 of \
        'fprintf' from incompatible pointer type
    kexec/arch/i386/crashdump-x86.c:144: warning: passing argument 2 of \
        'fprintf' makes pointer from integer without a cast


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/arch/i386/crashdump-x86.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 478d6be..ec61dfe 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -141,7 +141,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 			}
 		}
 		if (crash_reserved_mem.start >= mem_max) {
-			fprintf("Too small mem_max: 0x%lx.\n", mem_max);
+			fprintf(stderr, "Too small mem_max: 0x%lx.\n", mem_max);
 			return -1;
 		}
 		crash_reserved_mem.end = mem_max;
-- 
1.6.0.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
