Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBr1i-0002Wv-6I
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 12:56:38 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Remove experimental status of kdump on PPC64
Date: Thu, 26 Jun 2008 14:57:15 +0200
Message-Id: <1214485035-26041-1-git-send-email-bwalle@suse.de>
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
To: linuxppc-dev@ozlabs.org
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

This patch removes the experimental status of kdump on IA64. kdump is on IA64
now since more than one year and it has proven to be stable.

For i386/x86_64, a similar patch has been accepted by Ingo Molnar and Vivek
Goyal.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 arch/powerpc/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3934e26..2a116b9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -308,8 +308,8 @@ config KEXEC
 	  strongly in flux, so no good recommendation can be made.
 
 config CRASH_DUMP
-	bool "Build a kdump crash kernel (EXPERIMENTAL)"
-	depends on PPC_MULTIPLATFORM && PPC64 && EXPERIMENTAL
+	bool "Build a kdump crash kernel"
+	depends on PPC_MULTIPLATFORM && PPC64
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
 	  The kernel will be linked at a different address than normal, and
-- 
1.5.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
