Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LNtAO-0004Zd-Ky
	for kexec@lists.infradead.org; Fri, 16 Jan 2009 18:11:39 +0000
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id AB45B484B7
	for <kexec@lists.infradead.org>; Fri, 16 Jan 2009 19:11:34 +0100 (CET)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] [PPC64] Fix memory corruption when using
	realloc_memory_ranges()
Date: Fri, 16 Jan 2009 19:11:34 +0100
Message-Id: <1232129494-20143-1-git-send-email-bwalle@suse.de>
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

Because realloc_memory_ranges() makes the old memory invalid, and we return
a pointer to memory_range in get_memory_ranges(), we need to copy the contents
in get_memory_ranges().

Some code that calls realloc_memory_ranges() may be triggered by
get_base_ranges() which is called after get_memory_ranges().

Yes, the memory needs to be deleted somewhere, but I don't know currently
where it's the best, and since it's not in a loop and memory is deleted
anyway after program termination I don't want to introduce unneccessary
complexity. The problem is that get_base_ranges() gets called from
architecture independent code and that allocation is PPC64-specific here.


Signed-off-by: Bernhard Walle <bwalle@suse.de>diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index b0d8acd..ad8a31c 100644
Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/arch/ppc64/kexec-ppc64.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index b0d8acd..ad8a31c 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -715,7 +715,16 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 	if (setup_memory_ranges(kexec_flags))
 		return -1;
 
-	*range = memory_range;
+	/*
+	 * copy the memory here, another realloc_memory_ranges might
+	 * corrupt the old memory
+	 */
+	*range = calloc(sizeof(struct memory_range), nr_memory_ranges);
+	if (*range == NULL)
+		return -1;
+	memmove(*range, memory_range,
+		sizeof(struct memory_range) * nr_memory_ranges);
+
 	*ranges = nr_memory_ranges;
 	fprintf(stderr, "get memory ranges:%d\n", nr_memory_ranges);
 	return 0;
-- 
1.6.0.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
