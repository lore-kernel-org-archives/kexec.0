Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBqxm-00004r-I0
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 12:52:34 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Remove experimental status of kdump on IA64
Date: Thu, 26 Jun 2008 14:53:11 +0200
Message-Id: <1214484791-25439-1-git-send-email-bwalle@suse.de>
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
To: linux-ia64@vger.kernel.org
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

This patch removes the experimental status of kdump on IA64. kdump is on IA64
now since more than one year and it has proven to be stable.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 arch/ia64/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 16be414..f548e43 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -539,8 +539,8 @@ config KEXEC
 	  strongly in flux, so no good recommendation can be made.
 
 config CRASH_DUMP
-	  bool "kernel crash dumps (EXPERIMENTAL)"
-	  depends on EXPERIMENTAL && IA64_MCA_RECOVERY && !IA64_HP_SIM && (!SMP || HOTPLUG_CPU)
+	  bool "kernel crash dumps"
+	  depends on IA64_MCA_RECOVERY && !IA64_HP_SIM && (!SMP || HOTPLUG_CPU)
 	  help
 	    Generate crash dump after being started by kexec.
 
-- 
1.5.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
