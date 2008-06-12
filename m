Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K6pN2-00033g-3W
	for kexec@lists.infradead.org; Thu, 12 Jun 2008 16:09:52 +0000
Received: from Relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 219BE4164D
	for <kexec@lists.infradead.org>; Thu, 12 Jun 2008 18:09:49 +0200 (CEST)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Fix wrong remove_parameter() calls
Date: Thu, 12 Jun 2008 18:10:25 +0200
Message-Id: <1213287025-5443-1-git-send-email-bwalle@suse.de>
In-Reply-To: <20080612021935.GG22358@verge.net.au>
References: <20080612021935.GG22358@verge.net.au>
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

When --reuse-cmdline is specified, kexec automatically removes some command
line parameter that are *known* to break the kexec'd target. That patch
corrects that behaviour:

 1. BOOT_IMAGE should be removed always when --reuse-cmdline is specified since
    it's likely that the kernel is not the same as the running kernel. As only
    lilo-like bootloaders (i.e. not GRUB) adds that parameter, there's no need
    to add a BOOT_IMAGE here.

 2. crashkernel should be only removed when 'kexec -p' is called. For the
    normal kexec, the crashkernel parameter can be passed as in the
    running kernel.

The mistake has been introduced by commit 3c5bb06948881b3e31c783c19edef74275794280
by myself.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/kexec.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 1550d68..b831775 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -869,9 +869,9 @@ char *get_command_line(void)
 		/* strip newline */
 		*(line + strlen(line) - 1) = 0;
 
-		remove_parameter(line, "crashkernel");
+		remove_parameter(line, "BOOT_IMAGE");
 		if (kexec_flags & KEXEC_ON_CRASH)
-			remove_parameter(line, "BOOT_IMAGE");
+			remove_parameter(line, "crashkernel");
 	} else
 		line = strdup("");
 
-- 
1.5.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
