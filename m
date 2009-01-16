Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LNtAE-0004Mk-Bg
	for kexec@lists.infradead.org; Fri, 16 Jan 2009 18:11:29 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 43DA34853B
	for <kexec@lists.infradead.org>; Fri, 16 Jan 2009 19:11:23 +0100 (CET)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] [PPC64] Fix typo in realloc_memory_ranges()
Date: Fri, 16 Jan 2009 19:11:23 +0100
Message-Id: <1232129483-19974-1-git-send-email-bwalle@suse.de>
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

The base_memory_range should not become memory_range. We need to realloc
base_memory_range to not change the contents of memory. That was a copy & paste
error.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/arch/ppc64/kexec-ppc64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index d8347f1..b0d8acd 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -107,7 +107,7 @@ static int realloc_memory_ranges(void)
 	if (!memory_range)
 		goto err;
 
-	base_memory_range = (struct memory_range *) realloc(memory_range, memory_range_len);
+	base_memory_range = (struct memory_range *) realloc(base_memory_range, memory_range_len);
 	if (!base_memory_range)
 		goto err;
 
-- 
1.6.0.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
