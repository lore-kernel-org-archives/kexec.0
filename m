Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K3JJK-00021Y-KM
	for kexec@lists.infradead.org; Mon, 02 Jun 2008 23:19:30 +0000
Received: from Relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id EB3A545ACA
	for <kexec@lists.infradead.org>; Tue,  3 Jun 2008 01:19:27 +0200 (CEST)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Fix implicit declaration of inb/outb
Date: Tue,  3 Jun 2008 01:20:06 +0200
Message-Id: <1212448806-22450-1-git-send-email-bwalle@suse.de>
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

This patch fixes following compiler warning:

    purgatory/arch/i386/console-x86.c:84: \
        warning: implicit declaration of function `outb'
    purgatory/arch/i386/console-x86.c:89: \
        warning: implicit declaration of function `inb'

Found on x86_64. The problem did not happen with i386.
Fix tested on x86_64-suse-linux and i586-suse-linux.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 purgatory/arch/i386/console-x86.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/purgatory/arch/i386/console-x86.c b/purgatory/arch/i386/console-x86.c
index 9773573..68f5daf 100644
--- a/purgatory/arch/i386/console-x86.c
+++ b/purgatory/arch/i386/console-x86.c
@@ -1,5 +1,5 @@
 #include <stdint.h>
-#include <arch/io.h>
+#include <sys/io.h>
 #include <purgatory.h>
 
 /*
-- 
1.5.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
