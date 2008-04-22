Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wr-out-0506.google.com ([64.233.184.239])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JoRzN-00070O-Eo
	for kexec@lists.infradead.org; Tue, 22 Apr 2008 23:33:29 +0000
Received: by wr-out-0506.google.com with SMTP id c46so2299719wra.18
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 16:33:29 -0700 (PDT)
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: [PATCH 4/9] Fix "Warning: indirect jmp without `*'".
Date: Tue, 22 Apr 2008 16:21:07 -0700
Message-Id: <1208906472-18465-5-git-send-email-jamey@thetovacompany.com>
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

The generated code is byte-for-byte identical.

Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
---
 purgatory/arch/i386/entry32-16-debug.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/purgatory/arch/i386/entry32-16-debug.S b/purgatory/arch/i386/entry32-16-debug.S
index 558ac1f..82b58ca 100644
--- a/purgatory/arch/i386/entry32-16-debug.S
+++ b/purgatory/arch/i386/entry32-16-debug.S
@@ -191,5 +191,5 @@ DEBUG_CHAR('j')
 entry16_debug_old_first32:
 	.long 0x100000
 	.size entry16_debug_old_first32, . - entry16_debug_old_first32
-	jmp	%eax
+	jmp	*%eax
 .size entry16_debug_first32, . - entry16_debug_first32
-- 
1.5.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
