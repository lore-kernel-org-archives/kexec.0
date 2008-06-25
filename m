Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBcrb-0006Gj-Dc
	for kexec@lists.infradead.org; Wed, 25 Jun 2008 21:49:15 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Remove CONFIG_EXPERIMENTAL from kdump
Date: Wed, 25 Jun 2008 23:49:52 +0200
Message-Id: <1214430592-18043-1-git-send-email-bwalle@suse.de>
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
To: vgoyal@redhat.com
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

I would suggest to remove the "experimental" status from Kdump.
Kdump is now in the kernel since a long time and used by Enterprise
distributions. I don't think that "experimental" is true any more.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 arch/x86/Kconfig |    1 -
 fs/Kconfig       |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e0edaaa..f4f255b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1190,7 +1190,6 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "kernel crash dumps (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
 	depends on X86_64 || (X86_32 && HIGHMEM)
 	help
 	  Generate crash dump after being started by kexec.
diff --git a/fs/Kconfig b/fs/Kconfig
index cf12c40..b2252a4 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -930,7 +930,7 @@ config PROC_KCORE
 
 config PROC_VMCORE
         bool "/proc/vmcore support (EXPERIMENTAL)"
-        depends on PROC_FS && EXPERIMENTAL && CRASH_DUMP
+        depends on PROC_FS && CRASH_DUMP
 	default y
         help
         Exports the dump image of crashed kernel in ELF format.
-- 
1.5.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
