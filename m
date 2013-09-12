Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VKCtw-0004tE-NZ
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 19:50:06 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 5/9] xen: kexec crash image when dom0 crashes
Date: Thu, 12 Sep 2013 20:49:03 +0100
Message-ID: <1379015347-21653-6-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1379015347-21653-1-git-send-email-david.vrabel@citrix.com>
References: <1379015347-21653-1-git-send-email-david.vrabel@citrix.com>
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
Cc: kexec@lists.infradead.org, Daniel Kiper <daniel.kiper@oracle.com>, Keir Fraser <keir@xen.org>, David Vrabel <david.vrabel@citrix.com>, Jan Beulich <jbeulich@suse.com>

From: David Vrabel <david.vrabel@citrix.com>

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
Tested-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 xen/common/kexec.c    |    2 ++
 xen/common/shutdown.c |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/xen/common/kexec.c b/xen/common/kexec.c
index 5548c37..fe0424e 100644
--- a/xen/common/kexec.c
+++ b/xen/common/kexec.c
@@ -307,6 +307,8 @@ void kexec_crash(void)
     if ( !test_bit(KEXEC_IMAGE_CRASH_BASE + pos, &kexec_flags) )
         return;
 
+    printk("Executing crash image\n");
+
     kexecing = TRUE;
 
     kexec_common_shutdown();
diff --git a/xen/common/shutdown.c b/xen/common/shutdown.c
index 20f04b0..9bccd34 100644
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
