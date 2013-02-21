Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8aFu-00068L-0S
 for kexec@lists.infradead.org; Thu, 21 Feb 2013 17:48:26 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 6/8] xen: kexec crash image when dom0 crashes
Date: Thu, 21 Feb 2013 17:48:12 +0000
Message-ID: <1361468894-18655-7-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>

From: David Vrabel <david.vrabel@citrix.com>

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 xen/common/shutdown.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/xen/common/shutdown.c b/xen/common/shutdown.c
index b18ef5d..12aa034 100644
--- a/xen/common/shutdown.c
+++ b/xen/common/shutdown.c
@@ -46,6 +46,9 @@ void dom0_shutdown(u8 reason)
     {
         debugger_trap_immediate();
         printk("Domain 0 crashed: ");
+#ifdef CONFIG_KEXEC
+        kexec_crash();
+#endif
         maybe_reboot();
         break; /* not reached */
     }
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
