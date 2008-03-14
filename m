Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JaDAP-0007jm-UK
	for kexec@lists.infradead.org; Fri, 14 Mar 2008 16:54:02 +0000
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 443C03B9CB
	for <kexec@lists.infradead.org>; Fri, 14 Mar 2008 17:53:59 +0100 (CET)
Date: Fri, 14 Mar 2008 17:53:58 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Fix kexec-tools on x86_64
Message-ID: <20080314165358.GA10674@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This patch fixes kexec-tools on x86_64. The build had two problems:

 1. The distribution missed the files

        purgatory/arch/x86_64/entry64-32.S,
        purgatory/arch/x86_64/entry64.S,
        purgatory/arch/x86_64/setup-x86_64.S,
        purgatory/arch/x86_64/stack.S,
        purgatory/arch/x86_64/purgatory-x86_64.c

    The problem was that variable expansion in a Makefile is a bit different
    from the expectation, i.e. the final value is used even if the variable is
    used in the middle.

 2. The build didn't include the files mentioned above. This was because of
    using '=' instead of '+=' in the 2nd part of the Makefile.

Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 purgatory/arch/x86_64/Makefile |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/purgatory/arch/x86_64/Makefile b/purgatory/arch/x86_64/Makefile
index 01fbbf3..af25cd3 100644
--- a/purgatory/arch/x86_64/Makefile
+++ b/purgatory/arch/x86_64/Makefile
@@ -2,19 +2,21 @@
 # Purgatory x86_64
 #
 
-x86_64_PURGATORY_SRCS += purgatory/arch/x86_64/entry64-32.S
-x86_64_PURGATORY_SRCS += purgatory/arch/x86_64/entry64.S
-x86_64_PURGATORY_SRCS += purgatory/arch/x86_64/setup-x86_64.S
-x86_64_PURGATORY_SRCS += purgatory/arch/x86_64/stack.S
-x86_64_PURGATORY_SRCS += purgatory/arch/x86_64/purgatory-x86_64.c
+x86_64_PURGATORY_SRCS_native = purgatory/arch/x86_64/entry64-32.S
+x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/entry64.S
+x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/setup-x86_64.S
+x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/stack.S
+x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/purgatory-x86_64.c
 
-dist += purgatory/arch/x86_64/Makefile $(x86_64_PURGATORY_SRCS) \
-	purgatory/arch/x86_64/include/arch/io.h			\
-	purgatory/arch/x86_64/include/arch/debug.h		\
+x86_64_PURGATORY_SRCS += $(x86_64_PURGATORY_SRCS_native)
+
+dist += purgatory/arch/x86_64/Makefile $(x86_64_PURGATORY_SRCS_native) 	\
+	purgatory/arch/x86_64/include/arch/io.h				\
+	purgatory/arch/x86_64/include/arch/debug.h			\
 	purgatory/arch/x86_64/purgatory-x86_64.h
 
 # Done add sources in i386/ to dist, as i386/Makefile adds them
-x86_64_PURGATORY_SRCS =  purgatory/arch/i386/entry32-16.S
+x86_64_PURGATORY_SRCS +=  purgatory/arch/i386/entry32-16.S
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/entry32-16-debug.S
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/crashdump_backup.c
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/console-x86.c
-- 
1.5.3.8


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
