Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from py-out-1112.google.com ([64.233.166.182])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JoRzo-00074m-DY
	for kexec@lists.infradead.org; Tue, 22 Apr 2008 23:33:56 +0000
Received: by py-out-1112.google.com with SMTP id a73so3543921pye.2
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 16:33:56 -0700 (PDT)
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: [PATCH 2/9] Fix copy-paste bug: entry16 does not start at
	entry16_debug.
Date: Tue, 22 Apr 2008 16:21:05 -0700
Message-Id: <1208906472-18465-3-git-send-email-jamey@thetovacompany.com>
In-Reply-To: <1208906472-18465-1-git-send-email-jamey@thetovacompany.com>
References: <1208906472-18465-1-git-send-email-jamey@thetovacompany.com>
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

The entry16 and entry16_debug functions need to compute appropriate 16-bit
segments before dropping to real mode. Each is intended to use its own
entry address as the segment base. However, both were using the entry
address of entry16_debug, causing the code-segment reload to branch to the
wrong place in the non-debug case.

This bug was only visible when running kexec with --real-mode and without
--debug.

Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
---
 purgatory/arch/i386/entry32-16.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/purgatory/arch/i386/entry32-16.S b/purgatory/arch/i386/entry32-16.S
index a37fb55..aaf1273 100644
--- a/purgatory/arch/i386/entry32-16.S
+++ b/purgatory/arch/i386/entry32-16.S
@@ -25,7 +25,7 @@
 entry16:
 	.code32
 	/* Compute where I am running at */
-	movl	$entry16_debug, %ebx	
+	movl	$entry16, %ebx
 
 	/* Fixup my real mode segment */
 	movl	%ebx, %eax
-- 
1.5.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
