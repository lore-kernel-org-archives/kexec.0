Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LNtAa-0004pl-E5
	for kexec@lists.infradead.org; Fri, 16 Jan 2009 18:11:51 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 5038345825
	for <kexec@lists.infradead.org>; Fri, 16 Jan 2009 19:11:45 +0100 (CET)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] [PPC64] printf() consolidation
Date: Fri, 16 Jan 2009 19:11:45 +0100
Message-Id: <1232129505-20327-1-git-send-email-bwalle@suse.de>
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

Remove the fprintf(stderr,...) in get_memory_ranges() that adds unnecessary
output in the normal kexec case that the user don't want to see.

Use dbgprintf() in get_base_ranges() instead of

    #ifdef DEBUG
        fprintf(stderr,...)
    #endif

to to make the code more readable.


Signed-off-by: Bernhard Walle <bwalle@suse.de>diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index ad8a31c..8d4e42b 100644
Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/arch/ppc64/kexec-ppc64.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index ad8a31c..8d4e42b 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -263,9 +263,8 @@ static int get_base_ranges(void)
 	closedir(dir);
 	sort_base_ranges();
 	memory_max = base_memory_range[nr_memory_ranges - 1].end;
-#ifdef DEBUG
-	fprintf(stderr, "get base memory ranges:%d\n", nr_memory_ranges);
-#endif
+	dbgprintf("get base memory ranges:%d\n", nr_memory_ranges);
+
 	return 0;
 }
 
@@ -726,7 +725,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 		sizeof(struct memory_range) * nr_memory_ranges);
 
 	*ranges = nr_memory_ranges;
-	fprintf(stderr, "get memory ranges:%d\n", nr_memory_ranges);
+	dbgprintf("get memory ranges:%d\n", nr_memory_ranges);
 	return 0;
 }
 
-- 
1.6.0.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
