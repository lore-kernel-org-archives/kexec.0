Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPHIZ-000719-EZ
 for kexec@lists.infradead.org; Mon, 08 Apr 2013 19:00:11 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 6/8] xen: kexec crash image when dom0 crashes
Date: Mon, 8 Apr 2013 19:59:51 +0100
Message-ID: <1365447593-11988-7-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
References: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org
Cc: Ian Jackson <Ian.Jackson@eu.citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, Ian Campbell <Ian.Campbell@citrix.com>

From: David Vrabel <david.vrabel@citrix.com>

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 xen/common/shutdown.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/xen/common/shutdown.c b/xen/common/shutdown.c
index 73a7d7b..b676a03 100644
--- a/xen/common/shutdown.c
+++ b/xen/common/shutdown.c
@@ -47,6 +47,9 @@ void dom0_shutdown(u8 reason)
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
